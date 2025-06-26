local ServersStateMock = BaseClass("ServersStateMock", Singleton);

local function ServersState(reqMsg)
    local rspMsg = 
    {
        RpcId = reqMsg.RpcId,
        Error = 0,
        ServerInfoList = 
        {
            {
                ServerId = 1001,
                IP = "127.0.0.1",
                Port = "10001",
                StateInfo = 2,
                DateTime = os.time()
            }
        },
    }
    return rspMsg
end

local function __init(self)
    MockManager:GetInstance():RegisterMsgHandler(OuterOpcode.Name2Code.ETModel_C2R_ServersState, ServersState)
end

local function __delete(self)
end

ServersStateMock.__init = __init
ServersStateMock.__delete = __delete


return ServersStateMock;