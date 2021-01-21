DROP PROCEDURE IF EXISTS create_etl_tables$$
CREATE PROCEDURE create_etl_tables()
  BEGIN
    DECLARE script_id INT(11);

    -- create/recreate database kp_etl
    drop database if exists kp_etl;
    create database kp_etl;

    drop database if exists kp_datatools;
    create database kp_datatools;

    DROP TABLE IF EXISTS kp_etl.etl_script_status;
    CREATE TABLE kp_etl.etl_script_status(
      id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
      script_name VARCHAR(50) DEFAULT null,
      start_time DATETIME DEFAULT NULL,
      stop_time DATETIME DEFAULT NULL,
      error VARCHAR(255) DEFAULT NULL
    );

    -- Log start time
    INSERT INTO kp_etl.etl_script_status(script_name, start_time) VALUES('initial_creation_of_tables', NOW());
    SET script_id = LAST_INSERT_ID();

    DROP TABLE IF EXISTS kp_etl.etl_client_registration;
    DROP TABLE IF EXISTS kp_etl.etl_contact;
    DROP TABLE IF EXISTS kp_etl.etl_client_enrollment;
    DROP TABLE IF EXISTS kp_etl.etl_clinical_visit;
    DROP TABLE IF EXISTS kp_etl.etl_peer_calendar;
    DROP TABLE IF EXISTS kp_etl.etl_sti_treatment;
    DROP TABLE IF EXISTS kp_etl.etl_peer_tracking;
    DROP TABLE IF EXISTS kp_etl.etl_referral;
    DROP TABLE IF EXISTS kp_etl.etl_alcohol_screening;
    DROP TABLE IF EXISTS kp_etl.etl_peer_overdose_reporting;
    DROP TABLE IF EXISTS kp_etl.etl_CHW_overdose_reporting;
    DROP TABLE IF EXISTS kp_etl.etl_patient_triage;
    DROP TABLE IF EXISTS kp_etl.etl_diagnosis;




    -- create table etl_client_registration
    create table kp_etl.etl_client_registration (
      client_id INT(11) not null primary key,
      registration_date DATE,
      given_name VARCHAR(255),
      middle_name VARCHAR(255),
      family_name VARCHAR(255),
      Gender VARCHAR(10),
      DOB DATE,
      alias_name VARCHAR(255),
      postal_address VARCHAR (255),
      county VARCHAR (255),
      sub_county VARCHAR (255),
      location VARCHAR (255),
      sub_location VARCHAR (255),
      village VARCHAR (255),
      phone_number VARCHAR (255)  DEFAULT NULL,
      alt_phone_number VARCHAR (255)  DEFAULT NULL,
      email_address VARCHAR (255)  DEFAULT NULL,
      national_id_number VARCHAR(50),
      passport_number VARCHAR(50)  DEFAULT NULL,
      dead INT(11),
      death_date DATE DEFAULT NULL,
      voided INT(11),
      index(client_id),
      index(Gender),
      index(registration_date),
      index(DOB)
    );

    SELECT "Successfully created etl_client_registration table";

    -- create table etl_contact
    create table kp_etl.etl_contact (
      uuid char(38) ,
      unique_identifier VARCHAR(50),
      client_id INT(11) NOT NULL,
      visit_id INT(11) DEFAULT NULL,
      visit_date DATE,
      location_id INT(11) DEFAULT NULL,
      encounter_id INT(11) NOT NULL PRIMARY KEY,
      encounter_provider INT(11),
      date_created DATE,
      key_population_type VARCHAR(255),
      contacted_by_peducator VARCHAR(10),
      program_name VARCHAR(255),
      frequent_hotspot_name VARCHAR(255),
      frequent_hotspot_type VARCHAR(255),
      year_started_sex_work VARCHAR(10),
      year_started_sex_with_men VARCHAR(10),
      year_started_drugs VARCHAR(10),
      avg_weekly_sex_acts int(11),
      avg_weekly_anal_sex_acts int(11),
      avg_daily_drug_injections int(11),
      contact_person_name VARCHAR(255),
      contact_person_alias VARCHAR(255),
      contact_person_phone VARCHAR(255),
      voided INT(11),
      constraint foreign key(client_id) references kp_etl.etl_client_registration(client_id),
      CONSTRAINT unique_uuid UNIQUE(uuid),
      index(client_id),
      index(unique_identifier),
      index(key_population_type)
    );

    SELECT "Successfully created etl_contact table";

    -- create table etl_client_enrollment

    create table kp_etl.etl_client_enrollment (
      uuid char(38) ,
      client_id INT(11) NOT NULL,
      visit_id INT(11) DEFAULT NULL,
      visit_date DATE,
      location_id INT(11) DEFAULT NULL,
      encounter_id INT(11) NOT NULL PRIMARY KEY,
      encounter_provider INT(11),
      date_created DATE,
      contacted_for_prevention VARCHAR(10),
      has_regular_free_sex_partner VARCHAR(10),
      year_started_sex_work VARCHAR(10),
      year_started_sex_with_men VARCHAR(10),
      year_started_drugs VARCHAR(10),
      has_expereienced_sexual_violence VARCHAR(10),
      has_expereienced_physical_violence VARCHAR(10),
      ever_tested_for_hiv VARCHAR(10),
      test_type VARCHAR(255),
      share_test_results VARCHAR(100),
      willing_to_test VARCHAR(10),
      test_decline_reason VARCHAR(255),
      receiving_hiv_care VARCHAR(10),
      care_facility_name VARCHAR(100),
      ccc_number VARCHAR(100),
      vl_test_done VARCHAR(10),
      vl_results_date DATE,
      contact_for_appointment VARCHAR(10),
      contact_method VARCHAR(255),
      buddy_name VARCHAR(255),
      buddy_phone_number VARCHAR(255),
      voided INT(11),
      constraint foreign key(client_id) references kp_etl.etl_client_registration(client_id),
      CONSTRAINT unique_uuid UNIQUE(uuid),
      index(client_id)
    );
    SELECT "Successfully created etl_client_enrollment table";

    -- create table etl_clinical_visit

    create table kp_etl.etl_clinical_visit (
      uuid char(38) ,
      client_id INT(11) NOT NULL,
      visit_id INT(11) DEFAULT NULL,
      visit_date DATE,
      location_id INT(11) DEFAULT NULL,
      encounter_id INT(11) NOT NULL PRIMARY KEY,
      encounter_provider INT(11),
      date_created DATE,
      implementing_partner VARCHAR(255),
      type_of_visit VARCHAR(255),
      visit_reason VARCHAR(255),
      service_delivery_model VARCHAR(255),
      sti_screened VARCHAR(10),
      sti_results VARCHAR(255),
      sti_treated VARCHAR(10),
      sti_referred VARCHAR(10),
      sti_referred_text VARCHAR(255),
      tb_screened VARCHAR(10),
      tb_results VARCHAR(255),
      tb_treated VARCHAR(10),
      tb_referred VARCHAR(10),
      tb_referred_text VARCHAR(255),
      hepatitisB_screened VARCHAR(10),
      hepatitisB_results VARCHAR(255),
      hepatitisB_treated VARCHAR(10),
      hepatitisB_referred VARCHAR(10),
      hepatitisB_text VARCHAR(255),
      hepatitisC_screened VARCHAR(10),
      hepatitisC_results VARCHAR(255),
      hepatitisC_treated VARCHAR(10),
      hepatitisC_referred VARCHAR(10),
      hepatitisC_text VARCHAR(255),
      overdose_screened VARCHAR(10),
      overdose_results VARCHAR(255),
      overdose_treated VARCHAR(10),
      received_naloxone VARCHAR(10),
      overdose_referred VARCHAR(10),
      overdose_text VARCHAR(255),
      abscess_screened VARCHAR(10),
      abscess_results VARCHAR(255),
      abscess_treated VARCHAR(10),
      abscess_referred VARCHAR(10),
      abscess_text VARCHAR(255),
      alcohol_screened VARCHAR(10),
      alcohol_results VARCHAR(255),
      alcohol_treated VARCHAR(10),
      alcohol_referred VARCHAR(10),
      alcohol_text VARCHAR(255),
      cerv_cancer_screened VARCHAR(10),
      cerv_cancer_results VARCHAR(255),
      cerv_cancer_treated VARCHAR(10),
      cerv_cancer_referred VARCHAR(10),
      cerv_cancer_text VARCHAR(255),
      prep_screened VARCHAR(10),
      prep_results VARCHAR(255),
      prep_treated VARCHAR(10),
      prep_referred VARCHAR(10),
      prep_text VARCHAR(255),
      violence_screened VARCHAR(10),
      violence_results VARCHAR(255),
      violence_treated VARCHAR(10),
      violence_referred VARCHAR(10),
      violence_text VARCHAR(255),
      risk_red_counselling_screened VARCHAR(10),
      risk_red_counselling_eligibility VARCHAR(255),
      risk_red_counselling_support VARCHAR(10),
      risk_red_counselling_ebi_provided VARCHAR(10),
      risk_red_counselling_text VARCHAR(255),
      fp_screened VARCHAR(10),
      fp_eligibility VARCHAR(255),
      fp_treated VARCHAR(10),
      fp_referred VARCHAR(10),
      fp_text VARCHAR(255),
      mental_health_screened VARCHAR(10),
      mental_health_results VARCHAR(255),
      mental_health_support VARCHAR(100),
      mental_health_referred VARCHAR(10),
      mental_health_text VARCHAR(255),
      hiv_self_rep_status VARCHAR(50),
      last_hiv_test_setting VARCHAR(100),
      counselled_for_hiv VARCHAR(10),
      hiv_tested VARCHAR(10),
      test_frequency VARCHAR(100),
      received_results VARCHAR(10),
      test_results VARCHAR(100),
      linked_to_art VARCHAR(10),
      facility_linked_to VARCHAR(10),
      self_test_education VARCHAR(10),
      self_test_kits_given VARCHAR(100),
      self_use_kits VARCHAR (10),
      distribution_kits VARCHAR (10),
      self_tested VARCHAR(10),
      self_test_date DATE,
      self_test_frequency VARCHAR(100),
      self_test_results VARCHAR(100),
      test_confirmatory_results VARCHAR(100),
      confirmatory_facility VARCHAR(100),
      offsite_confirmatory_facility VARCHAR(100),
      self_test_linked_art VARCHAR(10),
      self_test_link_facility VARCHAR(255),
      hiv_care_facility VARCHAR(255),
      other_hiv_care_facility VARCHAR(255),
      initiated_art_this_month VARCHAR(10),
      active_art VARCHAR(10),
      eligible_vl VARCHAR(50),
      vl_test_done VARCHAR(100),
      vl_results VARCHAR(100),
      received_vl_results VARCHAR(100),
      condom_use_education VARCHAR(10),
      post_abortal_care VARCHAR(10),
      linked_to_psychosocial VARCHAR(10),
      male_condoms_no VARCHAR(10),
      female_condoms_no VARCHAR(10),
      lubes_no VARCHAR(10),
      syringes_needles_no VARCHAR(10),
      pep_eligible VARCHAR(10),
      exposure_type VARCHAR(100),
      other_exposure_type VARCHAR(100),
      clinical_notes VARCHAR(255),
      appointment_date DATE,
      voided INT(11),
      constraint foreign key(client_id) references kp_etl.etl_client_registration(client_id),
      CONSTRAINT unique_uuid UNIQUE(uuid),
      index(client_id),
      index(client_id,visit_date)
    );
    SELECT "Successfully created etl_clinical_visit table";

    -- ------------ create table etl_peer_calendar-----------------------
    CREATE TABLE kp_etl.etl_peer_calendar (
      uuid CHAR(38),
      encounter_id INT(11) NOT NULL PRIMARY KEY,
      client_id INT(11) NOT NULL ,
      location_id INT(11) DEFAULT NULL,
      visit_date DATE,
      visit_id INT(11),
      encounter_provider INT(11),
      date_created DATE,
      hotspot_name VARCHAR(255),
      typology VARCHAR(255),
      other_hotspots VARCHAR(255),
      weekly_sex_acts INT(10),
      monthly_condoms_required INT(10),
      weekly_anal_sex_acts INT(10),
      monthly_lubes_required INT(10),
      daily_injections INT(10),
      monthly_syringes_required INT(10),
      years_in_sexwork_drugs INT(10),
      experienced_violence VARCHAR(10),
      service_provided_within_last_month VARCHAR(255),
      monthly_n_and_s_distributed  INT(10),
      monthly_male_condoms_distributed  INT(10),
      monthly_lubes_distributed  INT(10),
      monthly_female_condoms_distributed  INT(10),
      monthly_self_test_kits_distributed INT(10),
      received_clinical_service VARCHAR(10),
      violence_reported VARCHAR(10),
      referred  VARCHAR(10),
      health_edu  VARCHAR(10),
      remarks VARCHAR(255),
      voided INT(11),
      CONSTRAINT FOREIGN KEY (client_id) REFERENCES kp_etl.etl_client_registration(client_id),
      CONSTRAINT unique_uuid UNIQUE(uuid),
      INDEX(visit_date),
      INDEX(client_id, visit_date)
    );

    SELECT "Successfully created etl_peer_calendar table";

    CREATE TABLE kp_etl.etl_peer_tracking (
      uuid char(38),
      client_id INT(11) NOT NULL ,
      visit_id INT(11),
      visit_date DATE,
      location_id INT(11) DEFAULT NULL,
      encounter_id INT(11) NOT NULL PRIMARY KEY,
      encounter_provider INT(11),
      date_created DATE,
      tracing_attempted VARCHAR(10),
      tracing_not_attempted_reason VARCHAR(100),
      attempt_number VARCHAR(11),
      tracing_date DATE,
      tracing_type VARCHAR(100),
      tracing_outcome VARCHAR(100),
      is_final_trace VARCHAR(10),
      tracing_outcome_status VARCHAR(100),
      voluntary_exit_comment VARCHAR(255),
      status_in_program VARCHAR(100),
      source_of_information VARCHAR(100),
      other_informant VARCHAR(100),
      date_last_modified DATETIME,
      voided INT(11),
      CONSTRAINT FOREIGN KEY (client_id) REFERENCES kp_etl.etl_client_registration(client_id),
      CONSTRAINT unique_uuid UNIQUE(uuid),
      INDEX(visit_date),
      INDEX(encounter_id),
      INDEX(client_id),
      INDEX(status_in_program),
      INDEX(tracing_type)
      );
        SELECT "Successfully created etl_peer_tracking table";

    -- ------------ create table etl_referral-----------------------

    CREATE TABLE kp_etl.etl_referral (
         uuid char(38) ,
         client_id INT(11) NOT NULL,
         visit_id INT(11) DEFAULT NULL,
         visit_date DATE,
         location_id INT(11) DEFAULT NULL,
         encounter_id INT(11) NOT NULL PRIMARY KEY,
         encounter_provider INT(11),
         date_created DATE,
        referral_order VARCHAR(10),
        referral_date DATETIME,
        institution_referred VARCHAR(50),
        service_referred_for VARCHAR(50),
        contact_person VARCHAR(250),
        referred_outcome VARCHAR(50),
        remarks VARCHAR(100),
        voided INT(11),
         CONSTRAINT FOREIGN KEY (client_id) REFERENCES kp_etl.etl_client_registration(client_id),
         CONSTRAINT unique_uuid UNIQUE(uuid),
        index(client_id),
        index(visit_date)
      );
      SELECT "Successfully created etl_referral table";


            -- -------------- create table etl_gender_based_violence ----------------------------
             CREATE TABLE kp_etl.etl_gender_based_violence (
                      uuid char(38),
                      provider INT(11),
                      client_id INT(11) NOT NULL ,
                      visit_id INT(11),
                      visit_date DATE,
                      location_id INT(11) DEFAULT NULL,
                      encounter_id INT(11) NOT NULL PRIMARY KEY,
                      is_physically_abused VARCHAR(10),
                      physical_abuse_perpetrator VARCHAR(100),
                      other_physical_abuse_perpetrator VARCHAR(100),
                      in_physically_abusive_relationship VARCHAR(10),
                      in_physically_abusive_relationship_with VARCHAR(100),
                      other_physically_abusive_relationship_perpetrator VARCHAR(100),
                      in_emotionally_abusive_relationship VARCHAR(10),
                      emotional_abuse_perpetrator VARCHAR(100),
                      other_emotional_abuse_perpetrator VARCHAR(100),
                      in_sexually_abusive_relationship VARCHAR(10),
                      sexual_abuse_perpetrator VARCHAR(100),
                      other_sexual_abuse_perpetrator VARCHAR(100),
                      ever_abused_by_unrelated_person VARCHAR(10),
                      unrelated_perpetrator VARCHAR(100),
                      other_unrelated_perpetrator VARCHAR(100),
                      sought_help VARCHAR(10),
                      help_provider VARCHAR(100),
                      date_helped DATE,
                      help_outcome VARCHAR(100),
                      other_outcome VARCHAR(100),
                      reason_for_not_reporting VARCHAR(100),
                      other_reason_for_not_reporting VARCHAR(100),
                      date_created DATETIME NOT NULL,
                      date_last_modified DATETIME,
                      voided INT(11),
                      CONSTRAINT FOREIGN KEY (client_id) REFERENCES kp_etl.etl_client_registration(client_id),
                      CONSTRAINT unique_uuid UNIQUE(uuid),
                      INDEX(visit_date),
                      INDEX(encounter_id),
                      INDEX(client_id)
                    );
                SELECT "Successfully created etl_gender_based_violence table";

                  -- -------------- create table etl_alcohol_screening ----------------------------

                      CREATE TABLE kp_etl.etl_alcohol_screening (
                           uuid char(38) ,
                                 client_id INT(11) NOT NULL,
                                 visit_id INT(11) DEFAULT NULL,
                                 visit_date DATE,
                                 location_id INT(11) DEFAULT NULL,
                                 encounter_id INT(11) NOT NULL PRIMARY KEY,
                                 encounter_provider INT(11),
                                 date_created DATE,
                     	  how_often_do_you_drink VARCHAR(10),
                           how_many_drinks_you_take VARCHAR(10),
                           how_often_do_you_drink_six_or_more VARCHAR(10),
                           how_often_you_cant_stop_once_started VARCHAR(10),
                           how_often_you_failed_task_due_to_drinking VARCHAR(10),
                           how_often_you_needed_first_drink VARCHAR(10),
                           how_often_have_you_felt_guilt VARCHAR(10),
                           not_able_to_remember_becouse_of_drink VARCHAR(10),
                           injury_as_a_result_of_drinking VARCHAR(10),
                           people_concerned_about_your_drinking VARCHAR(20),
                     	  total INT(10),
                     	  remarks VARCHAR(100),
                           voided INT(11),
                           CONSTRAINT FOREIGN KEY (client_id) REFERENCES kp_etl.etl_client_registration(client_id),
                           CONSTRAINT unique_uuid UNIQUE(uuid),
                           INDEX(visit_date),
                           INDEX(encounter_id),
                           INDEX(client_id)
                         );
                       SELECT "Successfully created etl_alcohol_screening table";
               -- -------------- create table etl_peer_overdose_reporting ----------------------------

                   CREATE TABLE kp_etl.etl_peer_overdose_reporting (
                    uuid char(38) ,
                          client_id INT(11) NOT NULL,
                          visit_id INT(11) DEFAULT NULL,
                          visit_date DATE,
                          location_id INT(11) DEFAULT NULL,
                          encounter_id INT(11) NOT NULL PRIMARY KEY,
                          encounter_provider INT(11),
                          date_created DATE,
               	     address_overdose_happened VARCHAR(250),
                     incident_type VARCHAR(10),
                     hotspot VARCHAR(10),
                     type_of_site VARCHAR(10),
                     naloxone_provided VARCHAR(10),
                     specific_drug_use VARCHAR(200),
                     outcome VARCHAR(10),
                     reported_by VARCHAR(10),
               	     reported_date DATETIME,
               	     witnessed_by VARCHAR(10),
               	     witnessed_date DATETIME,
               	     remarks VARCHAR(100),
                     voided INT(11),
                     CONSTRAINT FOREIGN KEY (client_id) REFERENCES kp_etl.etl_client_registration(client_id),
                     CONSTRAINT unique_uuid UNIQUE(uuid),
                     INDEX(visit_date),
                     INDEX(encounter_id),
                     INDEX(client_id)
                   );
                   SELECT "Successfully created etl_peer_overdose_reporting table";

             -- -------------- create table etl_CHW_overdose_reporting ----------------------------

                 CREATE TABLE kp_etl.etl_CHW_overdose_reporting (
                   uuid char(38) ,
                         client_id INT(11) NOT NULL,
                         visit_id INT(11) DEFAULT NULL,
                         visit_date DATE,
                         location_id INT(11) DEFAULT NULL,
                         encounter_id INT(11) NOT NULL PRIMARY KEY,
                         encounter_provider INT(11),
                         date_created DATE,
             	  address_overdose_happened VARCHAR(250),
                   incident_type VARCHAR(10),
                   hotspot VARCHAR(10),
                   type_of_site VARCHAR(10),
                   naloxone_provided VARCHAR(10),
                   specific_drug_use VARCHAR(200),
                   outcome VARCHAR(10),
                   reported_by VARCHAR(10),
             	  reported_date DATETIME,
             	  witnessed_by VARCHAR(10),
             	  witnessed_date DATETIME,
             	  remarks VARCHAR(100),
                   voided INT(11),
                   CONSTRAINT FOREIGN KEY (client_id) REFERENCES kp_etl.etl_client_registration(client_id),
                   CONSTRAINT unique_uuid UNIQUE(uuid),
                   INDEX(visit_date),
                   INDEX(encounter_id),
                   INDEX(client_id)
                 );
                 SELECT "Successfully created etl_CHW_overdose_reporting table";


    -- -------------- create table etl_diagnosis ----------------------------
                   CREATE TABLE kp_etl.etl_diagnosis (
                        uuid char(38) ,
                          client_id INT(11) NOT NULL,
                          visit_id INT(11) DEFAULT NULL,
                          visit_date DATE,
                          location_id INT(11) DEFAULT NULL,
                          encounter_id INT(11) NOT NULL PRIMARY KEY,
                          encounter_provider INT(11),
                          date_created DATE,
                   	      skin_findings VARCHAR(100),
                         skin_finding_notes VARCHAR(250),
                   	     eyes_findings VARCHAR(100),
                         eyes_finding_notes VARCHAR(250),
                   	     ent_findings VARCHAR(100),
                         ent_finding_notes VARCHAR(250),
                   	      chest_findings VARCHAR(100),
                         chest_finding_notes VARCHAR(250),
                   	     cvs_findings VARCHAR(100),
                         cvs_finding_notes VARCHAR(250),
                   	     abdomen_findings VARCHAR(100),
                         abdomen_finding_notes VARCHAR(250),
                   	     cns_findings VARCHAR(100),
                         cns_finding_notes VARCHAR(250),
                   	     genitourinary_findings VARCHAR(100),
                         genitourinary_finding_notes VARCHAR(250),
                         diagnosis VARCHAR(10),
                   	     clinical_notes VARCHAR(100),
                         voided INT(11),
                         CONSTRAINT FOREIGN KEY (client_id) REFERENCES kp_etl.etl_client_registration(client_id),
                         CONSTRAINT unique_uuid UNIQUE(uuid),
                         INDEX(visit_date),
                         INDEX(encounter_id),
                         INDEX(client_id)
                       );
                      SELECT "Successfully created etl_diagnosis table";



                -- ------------ create table etl_patient_triage-----------------------

                CREATE TABLE kp_etl.etl_patient_triage (
                       uuid char(38) ,
                      client_id INT(11) NOT NULL,
                      visit_id INT(11) DEFAULT NULL,
                      visit_date DATE,
                      location_id INT(11) DEFAULT NULL,
                      encounter_id INT(11) NOT NULL PRIMARY KEY,
                      encounter_provider INT(11),
                      date_created DATE,
                    visit_reason VARCHAR(255),
                    weight DOUBLE,
                    height DOUBLE,
                    systolic_pressure DOUBLE,
                    diastolic_pressure DOUBLE,
                    temperature DOUBLE,
                    pulse_rate DOUBLE,
                    respiratory_rate DOUBLE,
                    oxygen_saturation DOUBLE,
                    muac DOUBLE,
                    nutritional_status INT(11) DEFAULT NULL,
                    last_menstrual_period DATE,
                    date_last_modified DATETIME,
                    voided INT(11),
                    CONSTRAINT FOREIGN KEY (client_id) REFERENCES kp_etl.etl_client_registration(client_id),
                     CONSTRAINT unique_uuid UNIQUE(uuid),
                                             INDEX(visit_date),
                                             INDEX(encounter_id),
                                             INDEX(client_id)
                  );

                   SELECT "Successfully created etl_patient_triage table";


        -- ------------ create table etl_sti_treatment-----------------------
    CREATE TABLE kp_etl.etl_sti_treatment (
      uuid CHAR(38),
      encounter_id INT(11) NOT NULL PRIMARY KEY,
      client_id INT(11) NOT NULL ,
      location_id INT(11) DEFAULT NULL,
      visit_date DATE,
      visit_id INT(11),
      encounter_provider INT(11),
      date_created DATE,
      visit_reason VARCHAR(255),
      syndrome VARCHAR(10),
      other_syndrome VARCHAR(255),
      drug_prescription VARCHAR(10),
      other_drug_prescription VARCHAR(255),
      genital_exam_done VARCHAR(10),
      lab_referral VARCHAR(10),
      lab_form_number VARCHAR(100),
      referred_to_facility VARCHAR(10),
      facility_name VARCHAR(255),
      partner_referral_done VARCHAR(10),
      given_lubes VARCHAR(10),
      no_of_lubes INT(10),
      given_condoms VARCHAR(10),
      no_of_condoms INT(10),
      provider_comments VARCHAR(255),
      provider_name VARCHAR(255),
      appointment_date DATE,
      voided INT(11),
      CONSTRAINT FOREIGN KEY (client_id) REFERENCES kp_etl.etl_client_registration(client_id),
      CONSTRAINT unique_uuid UNIQUE(uuid),
      INDEX(visit_date),
      INDEX(encounter_id),
      INDEX(client_id),
      INDEX(visit_reason),
      INDEX(given_lubes),
      INDEX(given_condoms)
    );


-- -------------------------- CREATE hts_test table ---------------------------------

create table kp_etl.etl_hts_test (
client_id INT(11) not null,
visit_id INT(11) DEFAULT NULL,
encounter_id INT(11) NOT NULL primary key,
encounter_uuid CHAR(38) NOT NULL,
encounter_location INT(11) NOT NULL,
creator INT(11) NOT NULL,
date_created DATE NOT NULL,
visit_date DATE,
test_type INT(11) DEFAULT NULL,
population_type VARCHAR(50),
key_population_type VARCHAR(50),
ever_tested_for_hiv VARCHAR(10),
months_since_last_test INT(11),
patient_disabled VARCHAR(50),
disability_type VARCHAR(50),
patient_consented VARCHAR(50) DEFAULT NULL,
client_tested_as VARCHAR(50),
test_strategy VARCHAR(50),
hts_entry_point VARCHAR(50),
test_1_kit_name VARCHAR(50),
test_1_kit_lot_no VARCHAR(50) DEFAULT NULL,
test_1_kit_expiry DATE DEFAULT NULL,
test_1_result VARCHAR(50) DEFAULT NULL,
test_2_kit_name VARCHAR(50),
test_2_kit_lot_no VARCHAR(50) DEFAULT NULL,
test_2_kit_expiry DATE DEFAULT NULL,
test_2_result VARCHAR(50) DEFAULT NULL,
final_test_result VARCHAR(50) DEFAULT NULL,
patient_given_result VARCHAR(50) DEFAULT NULL,
couple_discordant VARCHAR(100) DEFAULT NULL,
tb_screening VARCHAR(20) DEFAULT NULL,
patient_had_hiv_self_test VARCHAR(50) DEFAULT NULL,
remarks VARCHAR(255) DEFAULT NULL,
voided INT(11),
index(client_id),
index(visit_id),
index(tb_screening),
index(visit_date),
index(population_type),
index(test_type),
index(final_test_result),
index(couple_discordant),
index(test_1_kit_name),
index(test_2_kit_name)
);

END$$