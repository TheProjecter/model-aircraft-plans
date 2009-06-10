package net.moocowstudio.modelaircraft.view.codebehind {
    import flash.events.Event;
    import flash.events.MouseEvent;

    import mx.containers.Canvas;
    import mx.controls.TextInput;

    import net.moocowstudio.modelaircraft.database.DatabaseFacade;
    import net.moocowstudio.modelaircraft.model.Designer;

    public class AddDesignerClass extends Canvas {
        /* Properties */
        public var txtFirstName : TextInput;
        public var txtLastName : TextInput;

        public function AddDesignerClass() {
        }

        /* Event Handlers */
        public function onClick_btnAdd(event : MouseEvent) : void {
            var database : DatabaseFacade = new DatabaseFacade();
            var designer : Designer = new Designer();
            designer.id = 1;
            designer.firstName = this.txtFirstName.text;
            designer.lastName = this.txtLastName.text;
            database.addDesginer(designer);
        }

        public function onCreationComplete(event : Event) : void {
        }
    }
}