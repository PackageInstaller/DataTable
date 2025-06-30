local HKQooChannel = BaseClass("HKQooChannel", BaseChannel)
local base = BaseChannel

-- 构造函数
local function __init(self)
    base.__init(self, ChannelType.HKQoo)
    base.OnInit(self, "com.romanzone.ss", 3, ChannelCurrency.US, true)
end

-- Qoo登录成功解析数据
local function OnLoginSuccess(self, json)
    local login = UIManager:GetInstance():GetWindow(UIWindowNames.UISsLogin)
    if login == nil or login.View == nil then
        return
    end
    
    local tab = cjson.decode(json)
    local uid = "999"
    local password = nil
    local username = tab["user_id"]
    print("Qoo登录成功解析数据,username:" .. username)
    print("json" .. json)
    login.View:OnLoginSuccess(uid, password, username)
end

local function Purchase(self, productId, orderId)
    print("HKqooInPurchase")
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

HKQooChannel.OnLoginSuccess = OnLoginSuccess
HKQooChannel.__init = __init
HKQooChannel.Purchase = Purchase

return HKQooChannel