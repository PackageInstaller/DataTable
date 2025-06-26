local ExampleMock = BaseClass("ExampleMock", Singleton);

local function HandleLogin(reqMsg)
    local rspMsg = 
    {
        RpcId = reqMsg.RpcId,
        Error = 0,
        Key = "key",
        UId = PlayerPrefs.GetString("uid"..ClientData:GetInstance().package_name),
        Password = PlayerPrefs.GetString("password"..ClientData:GetInstance().package_name),
        Permission = 0,
        State = 0,
    }
    return rspMsg
end

local function __init(self)
    MockManager:GetInstance():RegisterMsgHandler(OuterOpcode.Name2Code.ETModel_C2R_Login, HandleLogin)
end

local function __delete(self)
end

ExampleMock.__init = __init
ExampleMock.__delete = __delete


return ExampleMock;