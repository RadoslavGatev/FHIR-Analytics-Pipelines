CREATE EXTERNAL TABLE [fhir].[ResearchSubject] (
    [resourceType] NVARCHAR(4000),
    [id] VARCHAR(64),
    [meta.id] NVARCHAR(4000),
    [meta.extension] NVARCHAR(MAX),
    [meta.versionId] VARCHAR(64),
    [meta.lastUpdated] VARCHAR(64),
    [meta.source] VARCHAR(256),
    [meta.profile] VARCHAR(MAX),
    [meta.security] VARCHAR(MAX),
    [meta.tag] VARCHAR(MAX),
    [implicitRules] VARCHAR(256),
    [language] NVARCHAR(4000),
    [text.id] NVARCHAR(4000),
    [text.extension] NVARCHAR(MAX),
    [text.status] NVARCHAR(64),
    [text.div] NVARCHAR(MAX),
    [extension] NVARCHAR(MAX),
    [modifierExtension] NVARCHAR(MAX),
    [identifier] VARCHAR(MAX),
    [status] NVARCHAR(64),
    [period.id] NVARCHAR(4000),
    [period.extension] NVARCHAR(MAX),
    [period.start] VARCHAR(64),
    [period.end] VARCHAR(64),
    [study.id] NVARCHAR(4000),
    [study.extension] NVARCHAR(MAX),
    [study.reference] NVARCHAR(4000),
    [study.type] VARCHAR(256),
    [study.identifier.id] NVARCHAR(4000),
    [study.identifier.extension] NVARCHAR(MAX),
    [study.identifier.use] NVARCHAR(64),
    [study.identifier.type] NVARCHAR(MAX),
    [study.identifier.system] VARCHAR(256),
    [study.identifier.value] NVARCHAR(4000),
    [study.identifier.period] NVARCHAR(MAX),
    [study.identifier.assigner] NVARCHAR(MAX),
    [study.display] NVARCHAR(4000),
    [individual.id] NVARCHAR(4000),
    [individual.extension] NVARCHAR(MAX),
    [individual.reference] NVARCHAR(4000),
    [individual.type] VARCHAR(256),
    [individual.identifier.id] NVARCHAR(4000),
    [individual.identifier.extension] NVARCHAR(MAX),
    [individual.identifier.use] NVARCHAR(64),
    [individual.identifier.type] NVARCHAR(MAX),
    [individual.identifier.system] VARCHAR(256),
    [individual.identifier.value] NVARCHAR(4000),
    [individual.identifier.period] NVARCHAR(MAX),
    [individual.identifier.assigner] NVARCHAR(MAX),
    [individual.display] NVARCHAR(4000),
    [assignedArm] NVARCHAR(4000),
    [actualArm] NVARCHAR(4000),
    [consent.id] NVARCHAR(4000),
    [consent.extension] NVARCHAR(MAX),
    [consent.reference] NVARCHAR(4000),
    [consent.type] VARCHAR(256),
    [consent.identifier.id] NVARCHAR(4000),
    [consent.identifier.extension] NVARCHAR(MAX),
    [consent.identifier.use] NVARCHAR(64),
    [consent.identifier.type] NVARCHAR(MAX),
    [consent.identifier.system] VARCHAR(256),
    [consent.identifier.value] NVARCHAR(4000),
    [consent.identifier.period] NVARCHAR(MAX),
    [consent.identifier.assigner] NVARCHAR(MAX),
    [consent.display] NVARCHAR(4000),
) WITH (
    LOCATION='/ResearchSubject/**',
    DATA_SOURCE = ParquetSource,
    FILE_FORMAT = ParquetFormat
);

GO

CREATE VIEW fhir.ResearchSubjectIdentifier AS
SELECT
    [id],
    [identifier.JSON],
    [identifier.id],
    [identifier.extension],
    [identifier.use],
    [identifier.type.id],
    [identifier.type.extension],
    [identifier.type.coding],
    [identifier.type.text],
    [identifier.system],
    [identifier.value],
    [identifier.period.id],
    [identifier.period.extension],
    [identifier.period.start],
    [identifier.period.end],
    [identifier.assigner.id],
    [identifier.assigner.extension],
    [identifier.assigner.reference],
    [identifier.assigner.type],
    [identifier.assigner.identifier],
    [identifier.assigner.display]
FROM openrowset (
        BULK 'ResearchSubject/**',
        DATA_SOURCE = 'ParquetSource',
        FORMAT = 'PARQUET'
    ) WITH (
        [id]   VARCHAR(64),
       [identifier.JSON]  VARCHAR(MAX) '$.identifier'
    ) AS rowset
    CROSS APPLY openjson (rowset.[identifier.JSON]) with (
        [identifier.id]                NVARCHAR(4000)      '$.id',
        [identifier.extension]         NVARCHAR(MAX)       '$.extension',
        [identifier.use]               NVARCHAR(64)        '$.use',
        [identifier.type.id]           NVARCHAR(4000)      '$.type.id',
        [identifier.type.extension]    NVARCHAR(MAX)       '$.type.extension',
        [identifier.type.coding]       NVARCHAR(MAX)       '$.type.coding',
        [identifier.type.text]         NVARCHAR(4000)      '$.type.text',
        [identifier.system]            VARCHAR(256)        '$.system',
        [identifier.value]             NVARCHAR(4000)      '$.value',
        [identifier.period.id]         NVARCHAR(4000)      '$.period.id',
        [identifier.period.extension]  NVARCHAR(MAX)       '$.period.extension',
        [identifier.period.start]      VARCHAR(64)         '$.period.start',
        [identifier.period.end]        VARCHAR(64)         '$.period.end',
        [identifier.assigner.id]       NVARCHAR(4000)      '$.assigner.id',
        [identifier.assigner.extension] NVARCHAR(MAX)       '$.assigner.extension',
        [identifier.assigner.reference] NVARCHAR(4000)      '$.assigner.reference',
        [identifier.assigner.type]     VARCHAR(256)        '$.assigner.type',
        [identifier.assigner.identifier] NVARCHAR(MAX)       '$.assigner.identifier',
        [identifier.assigner.display]  NVARCHAR(4000)      '$.assigner.display'
    ) j
