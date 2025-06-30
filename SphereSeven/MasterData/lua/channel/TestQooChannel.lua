local TestQooChannel = BaseClass("TestQooChannel", BaseChannel)
local base = BaseChannel

-- 构造函数
local function __init(self)
    base.__init(self, ChannelType.TestQoo)
    base.OnInit(self, "com.romanzone.ss", 99, ChannelCurrency.US, true)
end

-- Qoo登录成功解析数据
local function OnLoginSuccess(self, json)
    local login = UIManager:GetInstance():GetWindow(UIWindowNames.UISsLogin)
    if login == nil or login.View == nil then
        return
    end
    print(json)
    local tab = cjson.decode(json)
    local uid = tab["user_id"]
    local username = tab["name"]
    local password = nil
    print("Qoo user id:: " .. uid)
    print("Qoo user name: " .. username)
    login.View:OnLoginSuccess(uid, password, username)
end

local function Purchase(self, productId, orderId)
    print("TestQooInPurchase")
    coroutine.start(function ()
        local productId = productId
        local cpOrderId = orderId
        local developerPayload = ""

        CS.GameChannel.ChannelManager.instance:Purchase(
            productId, 
            cpOrderId, 
            developerPayload
        )
    end)
end

TestQooChannel.OnLoginSuccess = OnLoginSuccess
TestQooChannel.__init = __init
TestQooChannel.Purchase = Purchase

return TestQooChannel