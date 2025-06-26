local SkinInfoMock = BaseClass("SkinInfoMock", Singleton);

local function HandleLogin(reqMsg)
    local rspMsg = 
    {
        RpcId = reqMsg.RpcId,
        Error = 0,
        SkinInfoList = 
        {
            {
                SkinId = 1,
                TemplateId = 100101,
            }
        }
    }
    return rspMsg
end

local function __init(self)
    MockManager:GetInstance():RegisterMsgHandler(OuterOpcode.Name2Code.ETModel_C2M_SkinInfo, HandleLogin)
end

local function __delete(self)
end

SkinInfoMock.__init = __init
SkinInfoMock.__delete = __delete


return SkinInfoMock;