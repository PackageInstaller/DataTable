local LuckCatMock = BaseClass("LuckCatMock", Singleton);

local function LuckCat(reqMsg)
    local rspMsg = 
    {
        RpcId = reqMsg.RpcId,
        Error = 0,
        MoveNum = 1,
        CurrentMap = 1,
        CurrentStep = 1,
        CatId = 1,
        NewMapNum = 1,
        NextTime = 1,
        SkinId = 1
    }
    return rspMsg
end

local function __init(self)
    MockManager:GetInstance():RegisterMsgHandler(OuterOpcode.Name2Code.ETModel_C2M_LuckCatInfo, LuckCat)
end

local function __delete(self)
end

LuckCatMock.__init = __init
LuckCatMock.__delete = __delete


return LuckCatMock;