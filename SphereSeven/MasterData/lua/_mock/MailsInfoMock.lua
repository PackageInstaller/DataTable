local MailsInfoMock = BaseClass("MailsInfoMock", Singleton);

local function MailsInfo(reqMsg)
    local rspMsg = 
    {
        RpcId = reqMsg.RpcId,
        Error = 0,
        MailInfoList = 
        {
        }
    }
    return rspMsg
end

local function __init(self)
    MockManager:GetInstance():RegisterMsgHandler(OuterOpcode.Name2Code.ETModel_C2M_MailsInfo, MailsInfo)
end

local function __delete(self)
end

MailsInfoMock.__init = __init
MailsInfoMock.__delete = __delete


return MailsInfoMock;