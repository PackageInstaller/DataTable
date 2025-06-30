local MailMock = BaseClass("MailMock", Singleton);

local function mailInfo(reqMsg)
    local rspMsg = 
    {
        RpcId = reqMsg.RpcId,
        Error = 0,
        mailbox = 
        {
            mails = {}
        }
    }
    return rspMsg
end

local function __init(self)
    MockManager:GetInstance():RegisterMsgHandler(PROTOCOL.MailboxInfoReq, mailInfo)
end

local function __delete(self)
end

MailMock.__init = __init
MailMock.__delete = __delete


return MailMock;