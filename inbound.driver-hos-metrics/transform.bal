
function transform(Input input) returns Output => {
    dtos: from var inputItem in input.input

        select {
            'type: inputItem.MessageProperties.EventType,
            data: {
                MessageContent: {
                    HeaderInformation: {
                        CreateDateUtc: inputItem.Content.HeaderInformation.CreateDateUtc
                    },
                    TripInformation: {
                        Assets: from var AssetsItem in inputItem.Assets
                            select {
                                Type: AssetsItem.Type,
                                Id: AssetsItem.Id,
                                Confirmed: AssetsItem.Confirmed ?: false
                            },
                        OrderHeader: inputItem.Content.TripInformation.OrderHeader ?: 0.0,
                        Stop: inputItem.Content.TripInformation.Stop ?: 0.0,
                        Leg: inputItem.Content.TripInformation.Leg ?: 0.0,
                        Move: inputItem.Content.TripInformation.Move ?: 0.0,
                        TripName: inputItem.Content.TripInformation.TripName
                    },
                    Metrics: inputItem.Content.Metrics,
                    AdditionalDataElements: from var AdditionalDataElementsItem in inputItem.Content.AdditionalDataElements

                        select {
                            Label: AdditionalDataElementsItem.Label,
                            Value: AdditionalDataElementsItem.Value
                        }
                },
                ParentMessageGuid: inputItem.MessageProperties.AuditId,
                MessageContentType: inputItem.MessageProperties.EventType,
                MessageGuid: inputItem.MessageProperties.MessageId
            }
        }

};

type Output record {
    record {
        string 'type;
        record {
            string MessageGuid;
            string ParentMessageGuid;
            string MessageContentType;
            record {
                record {
                    string Label;
                    string Value;
                }[] AdditionalDataElements;
                record {
                    decimal DayDrive;
                    decimal DayOnDuty;
                    decimal DayOffDuty;
                    decimal DaySleeperBerth;
                    decimal WorkDayDriveRemaining?;
                    decimal WorkDayOnDutyRemaining?;
                    decimal CycleDutyRemaining?;
                } Metrics;
                record {
                    string TripName;
                    decimal Move;
                    decimal Leg;
                    decimal Stop;
                    decimal OrderHeader;
                    record {
                        int Type;
                        string Id;
                        boolean Confirmed;
                    }[] Assets;
                } TripInformation;
                record {
                    string CreateDateUtc;
                } HeaderInformation;
            } MessageContent;
        } data;
    }[] dtos;
};

type Input record {
    record {
        record {
            int Type;
            string Id;
            boolean Confirmed?;
        }[] Assets;
        string CreateDate;
        string ContentType;
        record {
            record {
                decimal DayDrive;
                decimal DayOnDuty;
                decimal DayOffDuty;
                decimal DaySleeperBerth;
                decimal WorkDayDriveRemaining?;
                decimal WorkDayOnDutyRemaining?;
                decimal CycleDutyRemaining?;
            } Metrics;
            record {
                string Label;
                string Value;
            }[] AdditionalDataElements;
            record {
                string TripName;
                record {
                    string Label;
                    string Value;
                }[] AdditionalDataElements;
                decimal Move?;
                decimal Leg?;
                decimal Stop?;
                decimal OrderHeader?;
            } TripInformation;
            record {
                string CreateDateUtc;
            } HeaderInformation;
        } Content;
        record {
            string EventType;
            string AuditId;
            string MessageId;
        } MessageProperties;
    }[] input;
};
