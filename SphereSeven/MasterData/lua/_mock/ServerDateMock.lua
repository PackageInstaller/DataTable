local ServerDateMock = BaseClass("ServerDateMock", Singleton);

local function ServerDate(reqMsg)
    local rspMsg = 
    {
        RpcId = reqMsg.RpcId,
        Error = 0,
        Timestamp = os.time(),
        TimeZoneSeconds = 0
    }
    return rspMsg
end

local function __init(self)
    MockManager:GetInstance():RegisterMsgHandler(OuterOpcode.Name2Code.ETModel_C2G_ServerDate, ServerDate)
end

local function __delete(self)
end

ServerDateMock.__init = __init
ServerDateMock.__delete = __delete


return ServerDateMock;