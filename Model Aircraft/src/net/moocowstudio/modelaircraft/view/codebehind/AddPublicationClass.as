package net.moocowstudio.modelaircraft.view.codebehind {
    import flash.events.MouseEvent;

    import mx.containers.Canvas;
    import mx.controls.TextInput;

    import net.moocowstudio.modelaircraft.database.DatabaseFacade;
    import net.moocowstudio.modelaircraft.model.Publication;

    public class AddPublicationClass extends Canvas {
        /* Properties */
        public var txtTitle : TextInput;


        public function AddPublicationClass() {
            super();
        }

        /* Event Handlers */

        public function onClick_btnAdd(event : MouseEvent) : void {
            var facade : DatabaseFacade = new DatabaseFacade();
            var publication : Publication = new Publication();
            publication.title = this.txtTitle.text;
            facade.addPublication(publication);
        }

    }
}