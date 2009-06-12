package net.moocowstudio.modelaircraft.view.codebehind {
    import flash.events.Event;

    import mx.containers.Canvas;
    import mx.controls.DataGrid;

    import net.moocowstudio.modelaircraft.Aircraft;
    import net.moocowstudio.modelaircraft.database.Helper;
    import net.moocowstudio.modelaircraft.database.sqlite.Query;


    public class AircraftCatalogItemClass extends Canvas {
        [Bindable] public var aircraft : Aircraft;
        public var dgItems : DataGrid;
        [Bindable] public var allMyAircraft : Array = new Array();

        /* Queries */
        public var queryListAircraft : Query;

        public function AircraftCatalogItemClass() {
        }


        /* Event Handlers */
        public function onCreationComplete(event : Event) : void {
            this.queryListAircraft.execute();
        }

        public function onClick_imageRefresh(event : Event) : void {
            this.queryListAircraft.execute();
        }

        public function onResult_listAircraft_query() : void {
            var result : Array = this.queryListAircraft.data;
            this.allMyAircraft = new Array();
            for each (var object : Object in result) {
                var o : Aircraft = new Aircraft();
                o.name = object.name;
                o.id = object.aircraft_id;
                o.designerId = object.designer_id;
                o.publicationId = object.publication_id;
                o.publication = object.publication_title;
                o.designer = object.first_name + " " + object.last_name;
                o.typeId = object.aircraft_type_id;
                o.type = object.aircraft_type_title;
                o.wingSpan = object.wingspan;
                o.year = object.year;
                o.planKeyTitle = object.plan_key_title;
                o.comment = object.comment;
                try {
                    o.image = Helper.base64ToByteArray(object.image);
                } catch (e : *) {
                    trace("onResult_listAircraft_query error: " + e);
                }
                this.allMyAircraft.push(o);
            }

        }

        public function onItemClick_dgItems(event : Event) : void {
            this.aircraft = this.dgItems.selectedItem as Aircraft;
        }
    }
}