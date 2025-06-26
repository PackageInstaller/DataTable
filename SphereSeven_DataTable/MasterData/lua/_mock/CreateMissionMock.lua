local CreateMissionMock = BaseClass("CreateMissionMock", Singleton);

local function CreateMission(reqMsg)
    local rspMsg = 
    {
        RpcId = reqMsg.RpcId,
        Error = 0,
        MissionInfoList = 
        {
            {
                MissionId = 1,
                TemplateId = 7001,
            }
        }
    }
    return rspMsg
end

local function __init(self)
    MockManager:GetInstance():RegisterMsgHandler(OuterOpcode.Name2Code.ETModel_C2M_CreatMission, CreateMission)
end

local function __delete(self)
end

CreateMissionMock.__init = __init
CreateMissionMock.__delete = __delete


return CreateMissionMock;