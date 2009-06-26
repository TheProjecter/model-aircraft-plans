package net.moocowstudio.modelaircraftplanlibrary.ux.views.codebehindviews {
    import flash.events.Event;

    import mx.controls.TextInput;

    import net.moocowstudio.modelaircraftplanlibrary.domain.Publication;
    import net.moocowstudio.modelaircraftplanlibrary.events.DatabaseEvent;
    import net.moocowstudio.modelaircraftplanlibrary.events.PlanEvent;
    import net.moocowstudio.windowmanagement.UXWindow;

    /* Events */
    [Event(name="onSave", type = "net.moocowstudio.modelaircraftplanlibrary.events.PlanEvent")]

    public class PublicationEntryViewBase extends UXWindow {
        /* Properties */

        /* Text Inputs */
        public var txtPublicationName : TextInput;

        public function PublicationEntryViewBase() {
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
                    var object : Publication = new Publication();
                    object.name = this.txtPublicationName.text;
                    var saveEvent : PlanEvent = new PlanEvent(PlanEvent.onSavePublication);
                    saveEvent.data = object;
                    saveEvent.originator = this;
                    dispatchEvent(saveEvent);
                    trace("Event sent: " + PlanEvent.onSavePublication);
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
            this.txtPublicationName.text = "";
        }

    }
}