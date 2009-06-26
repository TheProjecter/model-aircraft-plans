package net.moocowstudio.modelaircraftplanlibrary.ux.views.codebehindviews {
    import flash.events.Event;

    import mx.controls.TextInput;

    import net.moocowstudio.modelaircraftplanlibrary.domain.PlanDesigner;
    import net.moocowstudio.modelaircraftplanlibrary.events.DatabaseEvent;
    import net.moocowstudio.modelaircraftplanlibrary.events.PlanEvent;
    import net.moocowstudio.windowmanagement.UXWindow;

    /* Events */
    [Event(name="onSave", type = "net.moocowstudio.modelaircraftplanlibrary.events.PlanEvent")]


    public class DesignerEntryViewBase extends UXWindow {
        /* Properties */

        /* Text Inputs */
        public var txtFirstName : TextInput;
        public var txtLastName : TextInput;

        public function DesignerEntryViewBase() {
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
                    var object : PlanDesigner = new PlanDesigner();
                    object.designer_first_name = this.txtFirstName.text;
                    object.designer_last_name = this.txtLastName.text;
                    var saveEvent : PlanEvent = new PlanEvent(PlanEvent.onSaveDesigner);
                    saveEvent.data = object;
                    saveEvent.originator = this;
                    dispatchEvent(saveEvent);
                    trace("Event sent: " + PlanEvent.onSaveDesigner);
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

        public function resetForm() : void {
            this.txtFirstName.text = "";
            this.txtLastName.text = "";
        }

    }
}