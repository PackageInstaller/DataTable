local AsiaChannel = BaseClass("AsiaChannel", BaseChannel)
local base = BaseChannel

-- 构造函数
local function __init(self)
    base.__init(self, ChannelType.Asia)
    base.OnInit(self, "com.highlight.sevenshpere.", 4, ChannelCurrency.US, true)
end

-- 聚美登录成功解析数据
local function OnLoginSuccess(self, json)
    local login = UIManager:GetInstance():GetWindow(UIWindowNames.UISsLogin)
    if login == nil or login.View == nil then
        return
    end
    local tab = cjson.decode(json)
    local uid = "1100"
    local password = tab["token"]
    local username = tab["openId"]
    login.View:OnLoginSuccess(uid, password, username)
end

-- 进入游戏后补单
local function OnEnterGame(self)
    if ClientData:GetInstance().app_version == "1.0.0" then
        Logger.AuthLog("OnEnterGame"..ClientData:GetInstance().app_version)
        local params = {}
        params.game_role_id = tostring(ClientData:GetInstance().uid)
        params.game_role_name = Game.Scene.Player.Nickname
        CS.GameChannel.ChannelManager.instance:StartSDK(cjson.encode(params))
    end
end

-- 支付
local function Purchase(self, productId)
    coroutine.start(function ()
        local request = coroutine.yieldstart(Game.Scene.Session.CoCall,nil, Game.Scene.Session,
                OuterOpcode.Name2Code.ETModel_C2M_CreatOrder, {ProductId = productId, Platform = self.PlatformNo})
        if request.Error == ErrorCode.ERR_Success then
            local product_id = self:GetFullId(productId)
            local order_no = request.OrderNo
            local buy_price = tostring(Z_StarLightStoneShop[productId].Dollar)
            local game_level = tostring(Game.Scene.Player.Level)
            local game_role_id = tostring(ClientData:GetInstance().uid)
            local game_role_name = Game.Scene.Player.Nickname
            CS.GameChannel.ChannelManager.instance:Purchase(product_id, order_no, buy_price, game_level, game_role_id, game_role_name)
        end
    end)
end

AsiaChannel.Purchase = Purchase
AsiaChannel.OnLoginSuccess = OnLoginSuccess
AsiaChannel.OnEnterGame = OnEnterGame
AsiaChannel.__init = __init

return AsiaChannel