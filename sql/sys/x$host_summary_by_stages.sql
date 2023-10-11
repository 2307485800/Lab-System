create definer = `mysql.sys`@localhost view sys.x$host_summary_by_stages as
select if((`performance_schema`.`events_stages_summary_by_host_by_event_name`.`HOST` is null), 'background',
          `performance_schema`.`events_stages_summary_by_host_by_event_name`.`HOST`)       AS `host`,
       `performance_schema`.`events_stages_summary_by_host_by_event_name`.`EVENT_NAME`     AS `event_name`,
       `performance_schema`.`events_stages_summary_by_host_by_event_name`.`COUNT_STAR`     AS `total`,
       `performance_schema`.`events_stages_summary_by_host_by_event_name`.`SUM_TIMER_WAIT` AS `total_latency`,
       `performance_schema`.`events_stages_summary_by_host_by_event_name`.`AVG_TIMER_WAIT` AS `avg_latency`
from `performance_schema`.`events_stages_summary_by_host_by_event_name`
where (`performance_schema`.`events_stages_summary_by_host_by_event_name`.`SUM_TIMER_WAIT` <> 0)
order by if((`performance_schema`.`events_stages_summary_by_host_by_event_name`.`HOST` is null), 'background',
            `performance_schema`.`events_stages_summary_by_host_by_event_name`.`HOST`),
         `performance_schema`.`events_stages_summary_by_host_by_event_name`.`SUM_TIMER_WAIT` desc;

