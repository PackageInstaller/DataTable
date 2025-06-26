local FriendMock = BaseClass("FriendMock", Singleton);

local function FriendInfo(reqMsg)
    local rspMsg = 
    {
        RpcId = reqMsg.RpcId,
        Error = 0,
        FriendList = {},
        BlackList = {},
        FRequestList = {},
        FriendHotList = {},
    }
    return rspMsg
end

local function __init(self)
    MockManager:GetInstance():RegisterMsgHandler(OuterOpcode.Name2Code.ETModel_C2PF_FriendInfo, FriendInfo)
end

local function __delete(self)
end

FriendMock.__init = __init
FriendMock.__delete = __delete


return FriendMock;