local GuiedMock = BaseClass("GuiedMock", Singleton);

local function Guied(reqMsg)
    local rspMsg = 
    {
        RpcId = reqMsg.RpcId,
        Error = 0,
        GuideInfoList = 
        {
        }
    }
    return rspMsg
end

local function GuideSaveReq(req)

    return req
end

local function __init(self)
    MockManager:GetInstance():RegisterMsgHandler(OuterOpcode.Name2Code.ETModel_C2M_Guided, Guied)
    MockManager:GetInstance():RegisterMsgHandler(PROTOCOL.GuideSaveReq, GuideSaveReq)
end

local function __delete(self)
end

GuiedMock.__init = __init
GuiedMock.__delete = __delete


return GuiedMock;