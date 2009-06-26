package net.moocowstudio.modelaircraftplanlibrary.ux.views.codebehindviews {
    import flash.events.*;

    import mx.controls.TextInput;

    import net.moocowstudio.modelaircraftplanlibrary.domain.PlanType;
    import net.moocowstudio.modelaircraftplanlibrary.events.DatabaseEvent;
    import net.moocowstudio.modelaircraftplanlibrary.events.PlanEvent;
    import net.moocowstudio.windowmanagement.UXWindow;

    /* Events */
    [Event(name="onSave", type = "net.moocowstudio.modelaircraftplanlibrary.events.PlanEvent")]

    public class PlanTypeEntryViewBase extends UXWindow {
        /* Properties */

        /* Text Inputs */
        public var txtPlanType : TextInput;

        public function PlanTypeEntryViewBase() {
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
                    /* Create the object that will represent this plan type and
                     * pass it along on the save event. */
                    var planType : PlanType = new PlanType();
                    planType.plan_type_description = this.txtPlanType.text;
                    var saveEvent : PlanEvent = new PlanEvent(PlanEvent.onSavePlanType);
                    saveEvent.data = planType;
                    saveEvent.originator = this;
                    dispatchEvent(saveEvent);
                    trace("Event sent: " + PlanEvent.onSavePublication);
                    break;
                case "btnClear":
                    break;
                case "btnCancel":
                    break;
            }
        }

        public function didSaveToDatabase(event : DatabaseEvent) : void {
            this.resetForm();
        }

        public function resetForm() : void {
            this.txtPlanType.text = "";
        }

    }
}