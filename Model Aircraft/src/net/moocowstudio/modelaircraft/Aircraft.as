package net.moocowstudio.modelaircraft {
    import flash.utils.ByteArray;
    
    import mx.controls.Image;


    public class Aircraft {
        public var name : String;
        public var type : String;
        public var typeId : int;
        public var wingSpan : int;
        public var year : String;
        public var designerId : int;
        public var publicationId : int;
        public var designer : String;
        public var publication : String;
        public var id : int;
        public var image : ByteArray;;

        public function Aircraft() {
        }

    }
}