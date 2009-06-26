package net.moocowstudio.modelaircraftplanlibrary.ux.views.codebehindviews {
    import flash.events.Event;

    import mx.controls.ComboBox;
    import mx.controls.TextArea;
    import mx.controls.TextInput;

    import net.moocowstudio.modelaircraftplanlibrary.database.vo.PlanVO;
    import net.moocowstudio.modelaircraftplanlibrary.domain.Plan;
    import net.moocowstudio.modelaircraftplanlibrary.domain.PlanDesigner;
    import net.moocowstudio.modelaircraftplanlibrary.domain.PlanPublication;
    import net.moocowstudio.modelaircraftplanlibrary.domain.PlanType;
    import net.moocowstudio.modelaircraftplanlibrary.events.DatabaseEvent;
    import net.moocowstudio.modelaircraftplanlibrary.events.PlanEvent;
    import net.moocowstudio.windowmanagement.UXWindow;

    public class ModelAircraftPlanEntryViewBase extends UXWindow {
        /* Properties */

        /* Text Inputs */
        public var txtDescription : TextInput;
        public var txtYear : TextInput;
        public var txtWingspan : TextInput;

        /* Text Areas */
        public var txtComments : TextArea;


        /* Comboboxes */
        public var comboboxType : ComboBox;
        public var comboboxDesigner : ComboBox;
        public var comboboxPublication : ComboBox;

        public function ModelAircraftPlanEntryViewBase() {
            super();
            this.addEventHandlers();
        }

        public function addEventHandlers() : void {
            this.addEventListener(DatabaseEvent.didSaveToDatabase, this.didSaveToDatabase);
        }

        /* Event Handlers */
        public function onClick(event : Event) : void {
            var id : String = event.currentTarget.id;
            switch (id) {
                case "btnSave":
                    /* Create the object that will represent this entry and
                     * pass it along on the save event. */

                    var object : PlanVO = new PlanVO();
                    object.plan_name = this.txtDescription.text;
                    object.plan_wingspan = this.txtWingspan.text;
                    object.plan_comments = this.txtComments.text;
                    object.plan_year = this.txtYear.text;
                    object.plan_type_id = this.comboboxType.selectedItem.plan_type_id;
                    object.plan_designer_id = this.comboboxDesigner.selectedItem.designer_id;
                    object.plan_publication_id = this.comboboxPublication.selectedItem.publication_id;

                    var saveEvent : PlanEvent = new PlanEvent(PlanEvent.onSavePlan);
                    saveEvent.data = object;
                    saveEvent.originator = this;
                    dispatchEvent(saveEvent);
                    trace("Event sent: " + PlanEvent.onSavePlan);
                    break;
                case "btnClear":
                    this.resetForm();
                    break;
                case "btnCancel":
                    break;
            }
        }

        public function didSaveToDatabase(event : DatabaseEvent) : void {
            this.resetForm();
        }

        public function onCreationComplete(event : Event) : void {
            var loadPlanTypes : PlanEvent = new PlanEvent(PlanEvent.onLoadPlanTypes);
            dispatchEvent(loadPlanTypes);
            trace("Event sent: " + loadPlanTypes.type);

            var loadPublications : PlanEvent = new PlanEvent(PlanEvent.onLoadPublications);
            dispatchEvent(loadPublications);
            trace("Event sent: " + loadPublications.type);

            var loadDesigners : PlanEvent = new PlanEvent(PlanEvent.onLoadDesigners);
            dispatchEvent(loadDesigners);
            trace("Event sent: " + loadDesigners.type);
        }

        public function resetForm() : void {
            this.txtComments.text = "";
            this.txtDescription.text = "";
            this.txtWingspan.text = "";
            this.txtYear.text = "";
        }

        /* Label Functions */
        public function labelFunction_planTypes(item : Object) : String {
            var text : String = item.plan_type_description;
            return text;
        }

        public function labelFunction_publications(item : Object) : String {
            var text : String = item.publication_name;
            return text;
        }

        public function labelFunction_designers(item : Object) : String {
            var text : String = item.designer_first_name + " " + item.designer_last_name;
            return text;
        }

    }
}