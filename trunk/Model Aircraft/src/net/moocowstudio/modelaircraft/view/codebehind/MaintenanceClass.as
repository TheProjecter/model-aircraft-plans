package net.moocowstudio.modelaircraft.view.codebehind {
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.IBitmapDrawable;
    import flash.events.Event;
    import flash.events.SQLEvent;

    import mx.containers.Canvas;
    import mx.containers.ViewStack;
    import mx.controls.Image;
    import mx.core.UIComponent;
    import mx.effects.Glow;
    import mx.effects.Sequence;
    import mx.graphics.ImageSnapshot;

    import net.moocowstudio.modelaircraft.database.Helper;
    import net.moocowstudio.modelaircraft.database.sqlite.Query;
    import net.moocowstudio.modelaircraft.database.sqlite.SQLite;
    import net.moocowstudio.modelaircraft.view.AddAircraft;
    import net.moocowstudio.modelaircraft.view.AddDesigner;
    import net.moocowstudio.modelaircraft.view.AddPublication;
    import net.moocowstudio.modelaircraft.view.AddType;

    public class MaintenanceClass extends Canvas {
        /* Properties */
        public var viewStack : ViewStack;

        /* Views */
        public var viewAddAircraft : AddAircraft;
        public var viewAddAircraftType : AddType;
        public var viewAddPublication : AddPublication;
        public var viewAddDesigner : AddDesigner;

        /* Queries */
        public var queryAddAircraft : Query;
        public var queryAddAircraftType : Query;
        public var queryAddPublication : Query;
        public var queryAddDesigner : Query;

        /* Datbase */
        public var aircraft_db : SQLite;

        /* Components */
        public var imageDatabase : Image;


        public function MaintenanceClass() {
            super();
        }

        /* Animation */
        public function animateDatabaseSave() : void {
            var sequence : Sequence = new Sequence();
            var glow : Glow = new Glow();
            glow.color = 0xFFFFFF;
            glow.strength = 6;
            glow.duration = 1000;

            glow.alphaFrom = 0;
            glow.alphaTo = 1;

            glow.blurXFrom = 0;
            glow.blurXTo = 6;

            glow.blurYFrom = 0;
            glow.blurYTo = 6;

            sequence.addChild(glow);
            glow = new Glow();
            glow.strength = 6;
            glow.duration = 1000;
            glow.color = 0xFFFFFF;

            glow.alphaFrom = 1;
            glow.alphaTo = 0;

            glow.blurXFrom = 6;
            glow.blurXTo = 0;

            glow.blurYFrom = 6;
            glow.blurYTo = 0;

            sequence.addChild(glow);

            sequence.play([this.imageDatabase]);
        }

        public function getSnapshopOf(object : UIComponent) : Image {
            var image : Image = new Image();
            image.source = this.takeSnapshot(object);
            image.x = object.x;
            image.y = object.y
            image.source.x = object.x;
            image.source.y = object.y;
            return image;
        }

        public function takeSnapshot(source : IBitmapDrawable) : Bitmap {
            var imageBitmapData : BitmapData = ImageSnapshot.captureBitmapData(source);
            return new Bitmap(imageBitmapData);
        }

        /* Event Handlers */
        public function onItemClick_viewStack(event : Event) : void {
            if (this.viewStack.selectedIndex == 0) {
                this.viewAddAircraft.loadDataProviders();
            }
        }

        public function clearFormFields() : void {
            var k_ADD_AIRCRAFT : int = 0;
            var k_ADD_DESIGNER : int = 1;
            var k_ADD_PUBLICATION : int = 2;
            var k_ADD_AIRCRAFT_TYPE : int = 3;

            this.animateDatabaseSave();

            var index : int = this.viewStack.selectedIndex;
            switch (index) {
                case k_ADD_AIRCRAFT:
                    this.viewAddAircraft.clearFormFields();
                    break;
                case k_ADD_AIRCRAFT_TYPE:
                    this.viewAddAircraftType.clearFormFields();
                    break;
                case k_ADD_PUBLICATION:
                    this.viewAddPublication.clearFormFields();
                    break;
                case k_ADD_DESIGNER:
                    var image : Image = this.getSnapshopOf(this.viewAddDesigner);
                    this.viewAddDesigner.clearFormFields();
                    break;
            }
        }


        public function onAddAircraft() : void {
            var query : Query = new Query();
            query.connection = this.aircraft_db.connection;
            query.sql = "select max(aircraft_id) id from aircraft";
            query.addEventListener(SQLEvent.RESULT, this.onGetNextAircraftId);
            query.execute();
        }

        public function onGetNextAircraftId(event : SQLEvent) : void {
            var id : int = event.currentTarget.data[0].id;
            id++;
            try {
                var imageAsBase64String : String = Helper.byteArrayToBase64(this.viewAddAircraft.imagePicker.imageAsByteArray);
            } catch (e : *) {
                trace(e);
            }
            this.queryAddAircraft.parameters = [
                this.viewAddAircraft.txtPlanNumber.text,
                this.viewAddAircraft.comboBoxPlanKey.selectedItem.plan_key_id,
                this.viewAddAircraft.txtComment.text,
                id,
                this.viewAddAircraft.txtName.text,
                this.viewAddAircraft.comboBoxPublication.selectedItem.publication_id,
                this.viewAddAircraft.comboBoxDesigner.selectedItem.designer_id,
                this.viewAddAircraft.comboBoxType.selectedItem.type_id,
                this.viewAddAircraft.txtYear.text,
                int(new Number(this.viewAddAircraft.txtWingspan.text)),
                imageAsBase64String
                ]
            this.queryAddAircraft.execute();
        }

        public function onAddAircraftType() : void {
            var query : Query = new Query();
            query.connection = this.aircraft_db.connection;
            query.sql = "select max(type_id) from aircraft_type";
            query.addEventListener(SQLEvent.RESULT, this.onGetNextAircraftTypeId);
            query.execute();
        }

        public function onGetNextAircraftTypeId(event : SQLEvent) : void {


            var id : int = event.currentTarget.data[0];
            id++;
            this.queryAddAircraftType.parameters = [
                id,
                this.viewAddAircraftType.txtTitle.text
                ]
            this.queryAddAircraftType.execute();
        }

        public function onAddPublication() : void {
            var query : Query = new Query();
            query.connection = this.aircraft_db.connection;
            query.sql = "select max(publication_id) from publication";
            query.addEventListener(SQLEvent.RESULT, this.onGetNextPublicationId);
            query.execute();
        }

        public function onGetNextPublicationId(event : SQLEvent) : void {
            var id : int = event.currentTarget.data[0];
            id++;
            this.queryAddPublication.parameters = [
                id,
                this.viewAddPublication.txtTitle.text
                ]
            this.queryAddPublication.execute()
        }

        public function onAddDesigner() : void {
            var query : Query = new Query();
            query.connection = this.aircraft_db.connection;
            query.sql = "select max(designer_id) from designer";
            query.addEventListener(SQLEvent.RESULT, this.onGetNextDesignerTypeId);
            query.execute();
        }

        public function onGetNextDesignerTypeId(event : SQLEvent) : void {
            var id : int = event.currentTarget.data[0];
            id++;
            this.queryAddDesigner.parameters = [
                id,
                this.viewAddDesigner.txtFirstName.text,
                this.viewAddDesigner.txtLastName.text
                ]
            this.queryAddDesigner.execute()
        }

    }
}