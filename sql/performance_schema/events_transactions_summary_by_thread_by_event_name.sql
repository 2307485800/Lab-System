create table performance_schema.events_transactions_summary_by_thread_by_event_name
(
    THREAD_ID            bigint unsigned not null,
    EVENT_NAME           varchar(128)    not null,
    COUNT_STAR           bigint unsigned not null,
    SUM_TIMER_WAIT       bigint unsigned not null,
    MIN_TIMER_WAIT       bigint unsigned not null,
    AVG_TIMER_WAIT       bigint unsigned not null,
    MAX_TIMER_WAIT       bigint unsigned not null,
    COUNT_READ_WRITE     bigint unsigned not null,
    SUM_TIMER_READ_WRITE bigint unsigned not null,
    MIN_TIMER_READ_WRITE bigint unsigned not null,
    AVG_TIMER_READ_WRITE bigint unsigned not null,
    MAX_TIMER_READ_WRITE bigint unsigned not null,
    COUNT_READ_ONLY      bigint unsigned not null,
    SUM_TIMER_READ_ONLY  bigint unsigned not null,
    MIN_TIMER_READ_ONLY  bigint unsigned not null,
    AVG_TIMER_READ_ONLY  bigint unsigned not null,
    MAX_TIMER_READ_ONLY  bigint unsigned not null,
    primary key (THREAD_ID, EVENT_NAME) using hash
)
    engine = PERFORMANCE_SCHEMA;

