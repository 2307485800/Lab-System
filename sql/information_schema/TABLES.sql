create view information_schema.TABLES as
select (`cat`.`name` collate utf8mb3_tolower_ci)                                                                      AS `TABLE_CATALOG`,
       (`sch`.`name` collate utf8mb3_tolower_ci)                                                                      AS `TABLE_SCHEMA`,
       (`tbl`.`name` collate utf8mb3_tolower_ci)                                                                      AS `TABLE_NAME`,
       `tbl`.`type`                                                                                                   AS `TABLE_TYPE`,
       if((`tbl`.`type` = 'BASE TABLE'), `tbl`.`engine`, NULL)                                                        AS `ENGINE`,
       if((`tbl`.`type` = 'VIEW'), NULL, 10)                                                                          AS `VERSION`,
       `tbl`.`row_format`                                                                                             AS `ROW_FORMAT`,
       if((`tbl`.`type` = 'VIEW'), NULL,
          internal_table_rows(`sch`.`name`, `tbl`.`name`, if((`tbl`.`partition_type` is null), `tbl`.`engine`, ''),
                              `tbl`.`se_private_id`, (`tbl`.`hidden` <> 'Visible'), `ts`.`se_private_data`,
                              coalesce(`stat`.`table_rows`, 0),
                              coalesce(cast(`stat`.`cached_time` as unsigned), 0)))                                   AS `TABLE_ROWS`,
       if((`tbl`.`type` = 'VIEW'), NULL,
          internal_avg_row_length(`sch`.`name`, `tbl`.`name`, if((`tbl`.`partition_type` is null), `tbl`.`engine`, ''),
                                  `tbl`.`se_private_id`, (`tbl`.`hidden` <> 'Visible'), `ts`.`se_private_data`,
                                  coalesce(`stat`.`avg_row_length`, 0),
                                  coalesce(cast(`stat`.`cached_time` as unsigned), 0)))                               AS `AVG_ROW_LENGTH`,
       if((`tbl`.`type` = 'VIEW'), NULL,
          internal_data_length(`sch`.`name`, `tbl`.`name`, if((`tbl`.`partition_type` is null), `tbl`.`engine`, ''),
                               `tbl`.`se_private_id`, (`tbl`.`hidden` <> 'Visible'), `ts`.`se_private_data`,
                               coalesce(`stat`.`data_length`, 0),
                               coalesce(cast(`stat`.`cached_time` as unsigned), 0)))                                  AS `DATA_LENGTH`,
       if((`tbl`.`type` = 'VIEW'), NULL,
          internal_max_data_length(`sch`.`name`, `tbl`.`name`, if((`tbl`.`partition_type` is null), `tbl`.`engine`, ''),
                                   `tbl`.`se_private_id`, (`tbl`.`hidden` <> 'Visible'), `ts`.`se_private_data`,
                                   coalesce(`stat`.`max_data_length`, 0),
                                   coalesce(cast(`stat`.`cached_time` as unsigned), 0)))                              AS `MAX_DATA_LENGTH`,
       if((`tbl`.`type` = 'VIEW'), NULL,
          internal_index_length(`sch`.`name`, `tbl`.`name`, if((`tbl`.`partition_type` is null), `tbl`.`engine`, ''),
                                `tbl`.`se_private_id`, (`tbl`.`hidden` <> 'Visible'), `ts`.`se_private_data`,
                                coalesce(`stat`.`index_length`, 0),
                                coalesce(cast(`stat`.`cached_time` as unsigned), 0)))                                 AS `INDEX_LENGTH`,
       if((`tbl`.`type` = 'VIEW'), NULL,
          internal_data_free(`sch`.`name`, `tbl`.`name`, if((`tbl`.`partition_type` is null), `tbl`.`engine`, ''),
                             `tbl`.`se_private_id`, (`tbl`.`hidden` <> 'Visible'), `ts`.`se_private_data`,
                             coalesce(`stat`.`data_free`, 0),
                             coalesce(cast(`stat`.`cached_time` as unsigned), 0)))                                    AS `DATA_FREE`,
       if((`tbl`.`type` = 'VIEW'), NULL,
          internal_auto_increment(`sch`.`name`, `tbl`.`name`, if((`tbl`.`partition_type` is null), `tbl`.`engine`, ''),
                                  `tbl`.`se_private_id`,
                                  ((0 <> is_visible_dd_object(`tbl`.`hidden`, false, `tbl`.`options`)) is false),
                                  `ts`.`se_private_data`, coalesce(`stat`.`auto_increment`, 0),
                                  coalesce(cast(`stat`.`cached_time` as unsigned), 0),
                                  `tbl`.`se_private_data`))                                                           AS `AUTO_INCREMENT`,
       `tbl`.`created`                                                                                                AS `CREATE_TIME`,
       if((`tbl`.`type` = 'VIEW'), NULL,
          internal_update_time(`sch`.`name`, `tbl`.`name`, if((`tbl`.`partition_type` is null), `tbl`.`engine`, ''),
                               `tbl`.`se_private_id`, (`tbl`.`hidden` <> 'Visible'), `ts`.`se_private_data`,
                               coalesce(cast(`stat`.`update_time` as unsigned), 0),
                               coalesce(cast(`stat`.`cached_time` as unsigned), 0)))                                  AS `UPDATE_TIME`,
       if((`tbl`.`type` = 'VIEW'), NULL,
          internal_check_time(`sch`.`name`, `tbl`.`name`, if((`tbl`.`partition_type` is null), `tbl`.`engine`, ''),
                              `tbl`.`se_private_id`, (`tbl`.`hidden` <> 'Visible'), `ts`.`se_private_data`,
                              coalesce(cast(`stat`.`check_time` as unsigned), 0),
                              coalesce(cast(`stat`.`cached_time` as unsigned), 0)))                                   AS `CHECK_TIME`,
       `col`.`name`                                                                                                   AS `TABLE_COLLATION`,
       if((`tbl`.`type` = 'VIEW'), NULL,
          internal_checksum(`sch`.`name`, `tbl`.`name`, if((`tbl`.`partition_type` is null), `tbl`.`engine`, ''),
                            `tbl`.`se_private_id`, (`tbl`.`hidden` <> 'Visible'), `ts`.`se_private_data`,
                            coalesce(`stat`.`checksum`, 0),
                            coalesce(cast(`stat`.`cached_time` as unsigned), 0)))                                     AS `CHECKSUM`,
       if((`tbl`.`type` = 'VIEW'), NULL, get_dd_create_options(`tbl`.`options`, if(
               (ifnull(`tbl`.`partition_expression`, 'NOT_PART_TBL') = 'NOT_PART_TBL'), 0, 1),
                                                               if((`sch`.`default_encryption` = 'YES'), 1, 0)))       AS `CREATE_OPTIONS`,
       internal_get_comment_or_error(`sch`.`name`, `tbl`.`name`, `tbl`.`type`, `tbl`.`options`,
                                     `tbl`.`comment`)                                                                 AS `TABLE_COMMENT`
from (((((`mysql`.`tables` `tbl` join `mysql`.`schemata` `sch`
          on ((`tbl`.`schema_id` = `sch`.`id`))) join `mysql`.`catalogs` `cat`
         on ((`cat`.`id` = `sch`.`catalog_id`))) left join `mysql`.`collations` `col`
        on ((`tbl`.`collation_id` = `col`.`id`))) left join `mysql`.`tablespaces` `ts`
       on ((`tbl`.`tablespace_id` = `ts`.`id`))) left join `mysql`.`table_stats` `stat`
      on (((`tbl`.`name` = `stat`.`table_name`) and (`sch`.`name` = `stat`.`schema_name`))))
where ((0 <> can_access_table(`sch`.`name`, `tbl`.`name`)) and (0 <> is_visible_dd_object(`tbl`.`hidden`)));

