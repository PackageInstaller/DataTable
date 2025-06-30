local ServersMock = BaseClass("ServersMock", Singleton);

local function LoginInfo(reqMsg)
    local rspMsg = 
    {
        RpcId = reqMsg.RpcId,
        Error = 0,
        ServerInfoList = 
        {
            {
                ServerId = 1001,
                IP = "192.168.31.225",
                Port = "19001",
                StateInfo = 2,
                DateTime = os.time()
            }
        },
        AccountSrvInfoList = 
        {
            {
                ServerId = 1001,
                PlayerNickname = "Ame",
                PlayerLevel = 2,
            }
        },
    }
    return rspMsg
end

local function __init(self)
    MockManager:GetInstance():RegisterMsgHandler(OuterOpcode.Name2Code.ETModel_C2R_Servers, LoginInfo)
end

local function __delete(self)
end

ServersMock.__init = __init
ServersMock.__delete = __delete


return ServersMock;