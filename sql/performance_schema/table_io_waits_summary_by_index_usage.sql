create table performance_schema.table_io_waits_summary_by_index_usage
(
    OBJECT_TYPE      varchar(64)     null,
    OBJECT_SCHEMA    varchar(64)     null,
    OBJECT_NAME      varchar(64)     null,
    INDEX_NAME       varchar(64)     null,
    COUNT_STAR       bigint unsigned not null,
    SUM_TIMER_WAIT   bigint unsigned not null,
    MIN_TIMER_WAIT   bigint unsigned not null,
    AVG_TIMER_WAIT   bigint unsigned not null,
    MAX_TIMER_WAIT   bigint unsigned not null,
    COUNT_READ       bigint unsigned not null,
    SUM_TIMER_READ   bigint unsigned not null,
    MIN_TIMER_READ   bigint unsigned not null,
    AVG_TIMER_READ   bigint unsigned not null,
    MAX_TIMER_READ   bigint unsigned not null,
    COUNT_WRITE      bigint unsigned not null,
    SUM_TIMER_WRITE  bigint unsigned not null,
    MIN_TIMER_WRITE  bigint unsigned not null,
    AVG_TIMER_WRITE  bigint unsigned not null,
    MAX_TIMER_WRITE  bigint unsigned not null,
    COUNT_FETCH      bigint unsigned not null,
    SUM_TIMER_FETCH  bigint unsigned not null,
    MIN_TIMER_FETCH  bigint unsigned not null,
    AVG_TIMER_FETCH  bigint unsigned not null,
    MAX_TIMER_FETCH  bigint unsigned not null,
    COUNT_INSERT     bigint unsigned not null,
    SUM_TIMER_INSERT bigint unsigned not null,
    MIN_TIMER_INSERT bigint unsigned not null,
    AVG_TIMER_INSERT bigint unsigned not null,
    MAX_TIMER_INSERT bigint unsigned not null,
    COUNT_UPDATE     bigint unsigned not null,
    SUM_TIMER_UPDATE bigint unsigned not null,
    MIN_TIMER_UPDATE bigint unsigned not null,
    AVG_TIMER_UPDATE bigint unsigned not null,
    MAX_TIMER_UPDATE bigint unsigned not null,
    COUNT_DELETE     bigint unsigned not null,
    SUM_TIMER_DELETE bigint unsigned not null,
    MIN_TIMER_DELETE bigint unsigned not null,
    AVG_TIMER_DELETE bigint unsigned not null,
    MAX_TIMER_DELETE bigint unsigned not null,
    constraint OBJECT
        unique (OBJECT_TYPE, OBJECT_SCHEMA, OBJECT_NAME, INDEX_NAME) using hash
)
    engine = PERFORMANCE_SCHEMA;

