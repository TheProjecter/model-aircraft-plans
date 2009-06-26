package net.moocowstudio.modelaircraftplanlibrary.domain {

    public class Plan {
        /* Properties */
        public var type : PlanType;
        public var description : String;
        public var id : int;
        public var designer : PlanDesigner;
        public var publication : PlanPublication;
        public var year : String;
        public var wingspan : String;
        public var comments : String;

        public function Plan() {
        }

    }
}