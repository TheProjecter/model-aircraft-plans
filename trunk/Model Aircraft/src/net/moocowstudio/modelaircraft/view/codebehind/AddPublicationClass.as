package net.moocowstudio.modelaircraft.view.codebehind {
    import flash.events.Event;
    import flash.events.MouseEvent;

    import mx.containers.Canvas;
    import mx.controls.TextInput;

    public class AddPublicationClass extends Canvas {
        /* Properties */
        public var txtTitle : TextInput;


        public function AddPublicationClass() {
            super();
        }

        public function clearFormFields() : void {
            this.txtTitle.text = "";
        }

        /* Event Handlers */

        public function onClick_btnAdd(event : MouseEvent) : void {
            dispatchEvent(new Event("save"));
        }

    }
}