
function transform(Input input) returns Output => {
    dtos: [
        {
            data: {
                MessageContent: {
                    CreateDate: input.CreateDate,
                    Coordinates: {
                        Longitude: input.Content.Data.taskData.startedLocation.lon,
                        Latitude: input.Content.Data.taskData.startedLocation.lat
                    },
                    Assets: from var AssetsItem in input.Assets
                        select {
                            Type: AssetsItem.Type,
                            Id: idLookup(AssetsItem.Id),
                            Confirmed: false
                        },

                    Content: [],
                    FormId: input.FormId
                },
                MessageContentType: input.MessageProperties.EventType,
                MessageGuid: input.MessageProperties.MessageId,
                ParentMessageGuid: input.MessageProperties.AuditId
            },
            'type: input.MessageProperties.EventType
        },
        {
            data: {
                MessageContent: {
                    HeaderInformation: {
                        CreateDateUtc: input.CreateDate
                    },
                    TripInformation: {
                        AdditionalDataElements: [],
                        Assets: [],
                        OrderHeader: 0.0,
                        Stop: 1,
                        Leg: 8440,
                        Move: null,
                        TripName: null
                    },
                    Odometer: 0.0,
                    Location: {
                        Longitude: input.Content.Data.taskData.startedLocation.lon,
                        Latitude: input.Content.Data.taskData.startedLocation.lat
                    },
                    TripStatusReason: 0,
                    TripStatusType: 3
                },
                MessageContentType: input.MessageProperties.EventType,
                ParentMessageGuid: input.MessageProperties.AuditId,
                MessageGuid: reverseMessageId(input.MessageProperties.MessageId)
            },
            'type: input.MessageProperties.EventType
        }
    ]

};

type Output record {
    record {
        string 'type;
        record {
            string MessageGuid;
            string ParentMessageGuid;
            string MessageContentType;
            record {
                string FormId?;
                anydata[] Content?;
                record {
                    decimal Latitude;
                    decimal Longitude;
                } Coordinates?;
                record {
                    int Type;
                    string Id;
                    boolean Confirmed;
                }[] Assets?;
                string CreateDate?;
                int TripStatusType?;
                int TripStatusReason?;
                record {
                    decimal Latitude;
                    decimal Longitude;
                } Location?;
                decimal Odometer?;
                record {
                    anydata TripName;
                    anydata Move;
                    int Leg;
                    int Stop;
                    decimal OrderHeader;
                    record {
                        int Type;
                        string Id;
                        boolean Confirmed;
                    }[] Assets;
                    anydata[] AdditionalDataElements;
                } TripInformation?;
                record {
                    string CreateDateUtc;
                } HeaderInformation?;
            } MessageContent;
        } data;
    }[] dtos;
};

type Input record {
    record {
        int Type;
        string Id;
    }[] Assets;
    string FormId;
    string CreateDate;
    record {
        string DriverId;
        string MobileID;
        string IntEventType;
        record {
            record {
                string startedAtUtc;
                record {
                    decimal lat;
                    decimal lon;
                } startedLocation;
                record {
                } odometer;
                string startedDriverId;
                string arrivedAtText;
                string arrivedAtUtc;
                string confirmArrivedAtUtc;
                anydata customLocation;
                record {
                    string currentStatus;
                    string currentSpecialDrivingCondition;
                    anydata updatedStatus;
                    anydata updatedSpecialDrivingCondition;
                    string logNotation;
                } hosStatus;
                string completedAtUtc;
                record {
                    decimal lat;
                    decimal lon;
                } completedLocation;
                string completedDriverId;
                string baseTaskType;
                boolean isFirstTask;
                boolean isLastTask;
            } taskData;
            string stopKey;
            string tripKey;
            string stopExternalKey;
            string tripExternalKey;
        } Data;
        string triggeredAtUtc;
        string _id;
        string TransId;
        string TenantId;
        string SubType;
        string ProcessedAtUtc;
        string TractorId;
        anydata ConnectedTractorId;
    } Content;
    record {
        string EventType;
        string AuditId;
        string MessageId;
    } MessageProperties;
};
