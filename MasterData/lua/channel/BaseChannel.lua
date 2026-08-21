local BaseChannel = BaseClass("BaseChannel")

local function __init(self, name)
    self.Id = CS.GameChannel.ChannelManager.instance:GetChannelId() -- 配置文件id
    self.Config = Z_ServerChannel[self.Id]
    self.Name = name -- 渠道名
    self:OnInit("", 0, ChannelCurrency.JA, false)
end

local function OnInit(self, productName, platformNo, currency, sdk)
    self.ProductName = productName -- 商品名前缀
    self.PlatformNo = platformNo -- 平台编号
    self.Currency = currency -- 渠道货币
    self.Sdk = sdk -- 是否用到登录和支付sdk
end

local function GetFullId(self, productId)
    return self.ProductName..productId
end

local function GetId(self, fullId)
    local id = string.gsub(fullId, self.ProductName, "")
    return id
end

local function GetPlatform(self)
    if self.PlatformNo >= 0 then
        return self.PlatformNo
    end
    -- 渠道没有设置编号就使用以下
    if UNITY_EDITOR then
        return 0
    end
    if PLATFORM_IPHONE then
        return 1
    end
    if PLATFORM_ANDROID then
        return 2
    end
    return 0
end

local function IsSdk(self)
    return self.Sdk
end

local function GetCurrencyType(self)
    return self.Currency
end

local function OnLoginSuccess(self, json)
    
end

local function OnEnterGame(self)
    CS.GameChannel.ChannelManager.instance:StartSDK(cjson.encode({}))
end

local function Purchase(self, productId)
    CS.GameChannel.ChannelManager.instance:Purchase(self:GetFullId(productId))
end

BaseChannel.OnInit = OnInit
BaseChannel.Purchase = Purchase
BaseChannel.GetId = GetId
BaseChannel.GetFullId = GetFullId
BaseChannel.GetPlatform = GetPlatform
BaseChannel.IsSdk = IsSdk
BaseChannel.GetCurrencyType = GetCurrencyType
BaseChannel.OnLoginSuccess = OnLoginSuccess
BaseChannel.OnEnterGame = OnEnterGame
BaseChannel.__init = __init

return BaseChannel