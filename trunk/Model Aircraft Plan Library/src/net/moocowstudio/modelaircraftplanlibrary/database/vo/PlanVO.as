package net.moocowstudio.modelaircraftplanlibrary.database.vo {

    public class PlanVO {
        /* Properties */
        public var plan_name : String;
        public var plan_id : int;

        public var plan_type_id : int;
        public var plan_type_description : String;

        public var plan_designer_id : int;
        public var designer_first_name : String;
        public var designer_last_name : String;

        public var plan_publication_id : int;
        public var plan_publication_name : String;

        public var plan_year : String;
        public var plan_wingspan : String;
        public var plan_comments : String;
    }
}