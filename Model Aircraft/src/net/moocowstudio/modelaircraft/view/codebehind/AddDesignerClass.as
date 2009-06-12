package net.moocowstudio.modelaircraft.view.codebehind {
    import flash.events.Event;
    import flash.events.MouseEvent;

    import mx.containers.Canvas;
    import mx.controls.TextInput;

    import net.moocowstudio.modelaircraft.model.Designer;

    public class AddDesignerClass extends Canvas {
        /* Properties */
        public var txtFirstName : TextInput;
        public var txtLastName : TextInput;

        public function AddDesignerClass() {
        }

        public function clearFormFields() : void {
            this.txtFirstName.text = "";
            this.txtLastName.text = "";
        }

        /* Event Handlers */
        public function onClick_btnAdd(event : MouseEvent) : void {
            dispatchEvent(new Event("save"));
        }

        public function onCreationComplete(event : Event) : void {
        }
    }
}