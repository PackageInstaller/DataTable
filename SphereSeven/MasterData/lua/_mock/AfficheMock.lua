local GetAfficheMock = BaseClass("Affiche", Singleton);

local function GetAffiche(reqMsg)
    local rspMsg = 
    {
        RpcId = reqMsg.RpcId,
        Error = 0,
        AfficheList = {},
    }
    return rspMsg
end

local function __init(self)
    MockManager:GetInstance():RegisterMsgHandler(OuterOpcode.Name2Code.ETModel_C2M_GetAffiche, GetAffiche)
end

local function __delete(self)
end

GetAfficheMock.__init = __init
GetAfficheMock.__delete = __delete


return GetAfficheMock;