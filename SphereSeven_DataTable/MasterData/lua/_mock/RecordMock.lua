local RecordMock = BaseClass("RecordMock", Singleton);

local function HandleLogin(reqMsg)
    local rspMsg = 
    {
        RpcId = reqMsg.RpcId,
        Error = 0,
        Captain = 0,
        RecordInfo = 
        {
            CardTypeList = {},
            EquipTypeList = {},
            SkinTypeList = {},
            FightSoulTypeList = {},
            MonsterTypeList = {},
            StoryTypeList = {},
        }
    }
    return rspMsg
end

local function __init(self)
    MockManager:GetInstance():RegisterMsgHandler(OuterOpcode.Name2Code.ETModel_C2M_RecordInfo, HandleLogin)
end

local function __delete(self)
end

RecordMock.__init = __init
RecordMock.__delete = __delete


return RecordMock;
    