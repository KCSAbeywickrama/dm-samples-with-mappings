
function transform(Input input) returns Output => {
    dtos: [
        {
            'type: "com.trimble.transportation.telematics.outbound.text-message",
            data: {
                MessageId: "",
                Subject: input.TextMessage.Subject,
                Content: input.TextMessage.Message,
                CreateDate: input.TextMessage.HeaderInformation.CreateDateUtc,
                Assets: from var AssetsItem in input.Assets
                    where AssetsItem.Id != ""

                    select {
                        Type: typeLookup(AssetsItem.Type),
                        Id: idLookup(AssetsItem.Id),
                        Confirmed: true
                    }
            }
        }
    ]

};

type Output record {
    record {
        string 'type;
        record {
            record {
                int Type;
                string Id;
                boolean Confirmed;
            }[] Assets;
            string CreateDate;
            string Content;
            string Subject;
            string MessageId;
        } data;
    }[] dtos;
};

type Input record {
    record {
        string Type;
        string Id;
        boolean Confirmed;
    }[] Assets;
    record {
        string Priority;
        string Subject;
        string Message;
        record {
            string CreateDateUtc;
        } HeaderInformation;
    } TextMessage;
};
