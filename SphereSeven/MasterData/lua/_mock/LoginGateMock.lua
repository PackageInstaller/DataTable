local LoginGateMock = BaseClass("LoginGateMock", Singleton);

local function LoginGate(reqMsg)
    local rspMsg = 
    {
        RpcId = reqMsg.RpcId,
        Error = 0,
        PlayerId = 1
    }
    return rspMsg
end

local function LoginReq(req)
    -- 获取当前时间戳
	local currentTimestamp = os.time()
	-- 获取UTC时间戳
	local utcTimestamp = os.time(os.date("!*t", currentTimestamp))
	-- 计算时区偏移量
	local timezoneOffsetSeconds = currentTimestamp - utcTimestamp

    return {
        account_id = req.account_id,
        role_id = 1,
        gmt_offset = timezoneOffsetSeconds,
    }
end

local function FirstCommunicate(reqMsg)
    local rspMsg = 
    {
        RpcId = reqMsg.RpcId,
        Error = 0,
        PlayerId = 1,
        magicalString = "1"
    }
    return rspMsg , ErrorCode.ERR_Success
end

local function __init(self)
    MockManager:GetInstance():RegisterMsgHandler(OuterOpcode.Name2Code.ETModel_C2G_LoginGate, LoginGate)
    MockManager:GetInstance():RegisterMsgHandler(PROTOCOL.LoginReq, LoginReq)
    MockManager:GetInstance():RegisterMsgHandler(PROTOCOL.ClientReadyReq, function() return {} end)
    MockManager:GetInstance():RegisterMsgHandler(PROTOCOL.FirstCommunicateReq, FirstCommunicate)
end

local function __delete(self)
end

LoginGateMock.__init = __init
LoginGateMock.__delete = __delete


return LoginGateMock;