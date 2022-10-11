
function transform(Input input) returns Output => {
    dtos: [
        {
            data: {
                MessageContent: {
                    CreateDate: input.CreateDate,
                    Assets: from var AssetsItem in input.Assets
                        select {
                            Type: AssetsItem.Type,
                            Id: idLookup(AssetsItem.Id),
                            Confirmed: false
                        },
                    Coordinates: {
                        Longitude: input.Content.Data.taskData.completedLocation.lon,
                        Latitude: input.Content.Data.taskData.completedLocation.lat
                    },
                    Content: [
                        input.Content.Data.taskData.smartFormData.droppedTrailer,
                        input.Content.Data.taskData.smartFormData.pickupTrailer,
                        input.Content.Data.taskData.smartFormData.bol,
                        input.Content.Data.taskData.smartFormData.weight,
                        input.Content.Data.taskData.smartFormData.pieces,
                        input.Content.Data.taskData.smartFormData.seal,
                        input.Content.Data.taskData.smartFormData.driverUnload == "yes" ? "Y" : "N",
                        input.Content.Data.taskData.smartFormData.tankLevel
                    ],
                    FormId: input.FormId
                },
                MessageGuid: input.MessageProperties.MessageId,
                ParentMessageGuid: input.MessageProperties.AuditId,
                MessageContentType: input.MessageProperties.EventType
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
                string FormId;
                string[] Content;
                record {
                    decimal Latitude;
                    decimal Longitude;
                } Coordinates;
                record {
                    int Type;
                    string Id;
                    boolean Confirmed;
                }[] Assets;
                string CreateDate;
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
                boolean isSmart;
                record {
                    string droppedTrailer;
                    string pickupTrailer;
                    string bol;
                    string weight;
                    string pieces;
                    string seal;
                    string driverUnload;
                    string tankLevel;
                    string sendNextDispatch;
                } smartFormData;
                record {
                    string id;
                    int 'version;
                    string formType;
                    record {
                        string title;
                        record {
                            record {
                                string ctype;
                                string dtype;
                                record {
                                    boolean required;
                                    string label;
                                } attributes;
                            } droppedTrailer;
                            record {
                                string ctype;
                                string dtype;
                                record {
                                    boolean required;
                                    string label;
                                } attributes;
                            } pickupTrailer;
                            record {
                                string ctype;
                                string dtype;
                                record {
                                    boolean required;
                                    string label;
                                } attributes;
                            } bol;
                            record {
                                string ctype;
                                string dtype;
                                record {
                                    boolean required;
                                    string label;
                                    string sfType?;
                                } attributes;
                            } weight;
                            record {
                                string ctype;
                                string dtype;
                                record {
                                    boolean required;
                                    string label;
                                    string sfType?;
                                } attributes;
                            } pieces;
                            record {
                                string ctype;
                                string dtype;
                                record {
                                    boolean required;
                                    string label;
                                    string sfType?;
                                } attributes;
                            } seal;
                            record {
                                string ctype;
                                string dtype;
                                record {
                                    boolean required;
                                    string label;
                                    string sfType?;
                                    string positiveLabel?;
                                    string negativeLabel?;
                                } attributes;
                            } driverUnload;
                            record {
                                string ctype;
                                string dtype;
                                record {
                                    boolean required;
                                    string label?;
                                    string sfType?;
                                    string positiveLabel?;
                                    string negativeLabel?;
                                    string text?;
                                    string[] items?;
                                    string selectLabel?;
                                } attributes;
                            } tankLevel;
                            record {
                                string ctype;
                                string dtype;
                                record {
                                    boolean required;
                                    string label?;
                                    string positiveLabel?;
                                    string negativeLabel?;
                                    string sfType?;
                                    string text?;
                                    string[] items?;
                                    string selectLabel?;
                                } attributes;
                            } sendNextDispatch;
                        } fields;
                    } schema;
                } smartForm;
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
        string id;
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
