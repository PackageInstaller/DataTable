
local _M = class("XipuMiniWrapSdk")
local cjson = require("cjson")
local md5Lua = require "md5Lua"
local System_Array = System.Array

--xipu绑定手机号配置
local xipuCfg =
{
    url = "https://x-api.kuaigames.com",
    path_send = "/api/sms/send",
    path_bind = "/api/role/bind/phone",
    get_path = "/api/role/bind/info",

    sms_app_id = "34b4b803224c9e2c4f486c3f42c354b1",
    sms_secret_key = "014963a153270c191b2b1e95d661d850",
}

function _M:_loginSuccessCallback(userInfo)
	LuaLogger.ds("on XipuMiniWrapSdk loginSuccessCallback")

	local host_id = nil
	if EngineUtil.GetWebGLPlatform() == GE.WebGLMiniPlatform.TikTokMini then
		local sceneId = WebGLManager.GetWxSceneId()
		local config = Config.GetTiktokSceneVInfo(sceneId)
		host_id = config and config.hostID or nil
	end
	local tb = {
		sign = userInfo.sign,
		openid = userInfo.openid,
		timestamp = userInfo.timestamp,
		mobile = userInfo.mobile, -- 绑定手机号
		open_pay = userInfo.open_pay, -- 是否开启支付 （1 是 0 否）
		wx_open_id = userInfo.wx_open_id, --小程序用户的微信openId
		wx_session_key = userInfo.wx_session_key,  --小程序用户的sessionKey
		attached_account = userInfo.attached_account, --关联账号 （迁移用户时可用）
		third_info = userInfo.third_info,
		third_openid = userInfo.third_openid,
		dy_open_id = userInfo.dy_open_id,
		dy_host_id = host_id,
	}

	if not self.loginCallbackTemp then
		return
	end

	self.loginCallbackTemp(true, {
		uuid = tb.openid,
		token = cjson.encode(tb),
	})
	self.loginCallbackTemp = nil
end

function _M:_loginFailedCallback(errMsg)
	if not self.loginCallbackTemp then
		return
	end

	self.loginCallbackTemp(false, {
		loginType = GE.LoginType.XipuMiniWrap,
		sdkErrorCode = nil,
		sdkErrorMsg = errMsg,
	})
	self.loginCallbackTemp = nil
end

function _M:ctor(urlroot)
	LuaLogger.ds("XipuMiniWrapSdk ctor")
	self:init()
	self.urlroot = urlroot
	LuaLogger.ds("XipuMiniWrapSdk ctor end")
end

function _M:init()
	if GV.IsWebGL then
		if self.sdkInitSuccess then
			return
		end
		self.initType = {
			Wechat = 1,
			Douyin = 2,
			Alipay = 3,
			QQ = 4
		}
		LuaLogger.ds("XipuMiniWrapSdk init2")

		local curWebPlatform = EngineUtil.GetWebGLPlatform()

		if curWebPlatform == GE.WebGLMiniPlatform.WxWebMini then
			local app_id_android = "d9bbc0ac3699bc2f57b5345e5cae8f2b"
			local app_id_ios = "1ae4b6df517e16f333680e9872d7c912"
			local isDebug = true
			local isDevelop = false
			DXipuMiniSdk.DoInit(app_id_android, app_id_ios, isDebug, isDevelop, self.initType.Wechat)
		elseif curWebPlatform == GE.WebGLMiniPlatform.AliWebMini then
			
			local app_id_android = "95b915bb9673444a894d8aa755379291"
			local app_id_ios = "a313ace73a50638f5d67e0f353298583"
			local isDebug = true
			local isDevelop = false
			DXipuMiniSdk.DoInit(app_id_android, app_id_ios, isDebug, isDevelop, self.initType.Alipay)
		elseif curWebPlatform == GE.WebGLMiniPlatform.TikTokMini then
			local app_id_android = "6fc7dc333d8be7d62c2d872e81b6273a"
			local app_id_ios = "baa39f1ca098942849fbe88dd051426a"
			local isDebug = true
			local isDevelop = false
			DXipuMiniSdk.DoInit(app_id_android, app_id_ios, isDebug, isDevelop, self.initType.Douyin)
		end
		
		self.sdkInitSuccess = true
	end
end

function _M:Login(callBack)
	LuaLogger.ws("Set xipuMini Login callback", callBack)
	WXLuaManager:PlatformLogined(false)
	self.loginCallbackTemp = callBack
	self:checkSDKInit(function(success)
		if success then
			local OnLoginSuccess = function (res)
				WXLuaManager:PlatformLogined(true)
				self:_loginSuccessCallback(res)
			end
			local OnLoginFailed = function (res)
				WXLuaManager:PlatformLogined(false)
				self:_loginFailedCallback(res)
			end
			DXipuMiniSdk.Login(OnLoginSuccess, OnLoginFailed)
		end
	end)
end

function _M:RequestSubscribeMessage(tmplIds)
	local H5SubscribePanel = UIMgr:GetUI("H5SubscribePanel")
	local success = function (res)
		local infoList = res:ToTable()
		-- LuaLogger.ds("微信信息成功订阅:"..tablex.dump(infoList))
		if H5SubscribePanel then
			H5SubscribePanel:RefreshPage()
			H5SubscribePanel:RefreshPageRedPoint()
		end
	end
	local failed = function (res)
		-- LuaLogger.ds("微信信息订阅失败："..res)
		if H5SubscribePanel then
			H5SubscribePanel:RefreshPage()
			H5SubscribePanel:RefreshPageRedPoint()
		end
	end
	DXipuMiniSdk.RequestSubscribeMessage(tmplIds, success, failed)
end

function _M:canLargePay()
	local result = DXipuMiniSdk.CheckOpenLargeAmount()
	return result == 1
end

function _M:getPlatform()
	local result = DXipuMiniSdk.GetPlatform()
	return result
end

function _M:needHidePay()
	local result = self:getPlatform()
	local isHide = result == "ios"
	return isHide
end

function _M:ShareAppMessage(title, imageUrl, imageUrlId, query)
	local info = DXipuMiniSdk.XipMinShareData.New()
	info.title = title
	info.imageUrl = imageUrl
	info.imageUrlId = imageUrlId
	info.query = query
	DXipuMiniSdk.ShareAppMessage(info)
end

function _M:ShowShareMenu()
	LuaLogger.ds("执行lua ShowShareMenu")
	local succ = function()
		-- LuaLogger.ds("打开微信分享菜单成功")
	end
	local fail = function(res)
		-- LuaLogger.ds("打开微信分享菜单失败："..res)
	end
	DXipuMiniSdk.ShowShareMenu(succ, fail)
end

function _M:OnShareAppMessage(title, imageUrl, imageUrlId, query, path)
	local info = DXipuMiniSdk.XipMinShareData.New()
	info.title = title
	info.query = query
	info.imageUrl = imageUrl
	info.imageUrlId = imageUrlId
	info.path = path
	DXipuMiniSdk.OnShareAppMessage(info)
end

function _M:OpenCustomerServiceConversation()
	local info = DXipuMiniSdk.XipMinCustomerServiceData.New()
	info.showMessageCard = true
	info.sendMessageTitle = ""
	-- info.sendMessagePath = ""
	-- info.sendMessageImg = ""
	local succ = function (res)
		-- LuaLogger.ds("lua回调打开客服成功:"..res)
	end
	local fail = function (res)
		-- LuaLogger.ds("lua回调打开客服失败:"..res)
	end
	DXipuMiniSdk.OpenCustomerService(succ, fail, info)
end

function _M:getChannel()
	if EngineUtil.GetWebGLPlatform() == GE.WebGLMiniPlatform.WxWebMini then
		return GE.Channel.Channel_Xipu_Mini_WX
	elseif EngineUtil.GetWebGLPlatform() == GE.WebGLMiniPlatform.AliWebMini then
		return GE.Channel.Channel_Xipu_Mini_ZFB
	elseif EngineUtil.GetWebGLPlatform() == GE.WebGLMiniPlatform.TikTokMini then
		return GE.Channel.Channel_Xipu_Mini_DY
	end
end

-- 有初始化成功与否概念的需要加这个函数
function _M:isInited()
	return self.sdkInitSuccess
end

function _M:checkSDKInit(callBack)
	if self:isInited() then
		callBack(true)
		return
	end

	self:init()
	callBack(true)
end

function _M:GetVerifyPhoneCode(data, callBack)
	self:send_sms(data.phone, callBack)
end

function _M:Passport(path, HTTP_Verb, headData, data, callBack)
    local url = path
    local reqbody = cjson.encode(data)
    local dict = headData or {}
    local loaderTime = 1
    local loaderId = UIMgr:startLoad(loaderTime)
    local timeout = 20000 --20秒超时时间，由于第三方身份证验证可能比较慢，之前5秒不够
    HttpUtil.HttpRequest(url, reqbody, timeout, dict, function(respcode, responseJson)
        UIMgr:endLoad(loaderId)
        LuaLogger.ds(respcode, responseJson)
		local info = cjson.decode(responseJson)
        local success = self:dealReturnCode(info.code)
        local response
        if responseJson and success then
            response = cjson.decode(responseJson)
            if response.error then
                success = false
            end
        elseif respcode == 404 then
            response = {error = GE.PassportErrorCode.ServerConnectFailed}
        else
            response = {error = GE.PassportErrorCode.ResponseError}
        end

        callBack(success, response)
    end)
end

--打包请求头
local function pack_header()
	local header =
    {
        ContentType = "application/json",
    }
	return header
end

local stringCmpFunc = function(a, b)
	return a.key < b.key
end

--格式化数据
--@param {table} data
--@return {string}
local function formatDataSkipFields(data)
	local seq = {}
	for k, v in pairs(data) do
        v = tostring(v)
        local ev = stringx.urlEncode(v)
        local value = string.format("%s=%s", tostring(k), ev)
        table.insert(seq, { key = tostring(k), value = value })
	end

	table.sort(seq, stringCmpFunc)

	local str_arr = {}
	for k, v in pairs(seq) do
		table.insert(str_arr, v.value)
	end
	return table.concat(str_arr, "&")
end

--发送验证码
function  _M:send_sms(phone_num, callBack)
    local host = xipuCfg.url
    local path = xipuCfg.path_send
    local param =
    {
        app_id = xipuCfg.sms_app_id,
        timestamp = os.time(),
        phone_num = phone_num,
    }
    local strparam = formatDataSkipFields(param)
    param.sign = md5Lua.sumhexa(strparam .. xipuCfg.sms_secret_key)
    self:Passport(
        host..path,
		"POST",
		pack_header(),
		param,
		callBack
	)
end

function _M:dealReturnCode(respcode)
    if respcode == 200000 then
        return true
    else
        return false
    end
end

function _M.GenSdkRoleDataFromData(data)
	local gameRoleInfo = DXipuMiniSdk.XipuMiniRoleData.New()
	gameRoleInfo.server_id = data.serverID;
	gameRoleInfo.server_name = data.serverName;
	gameRoleInfo.role_id = data.gameRoleID;
	gameRoleInfo.role_name = data.gameRoleName;
	gameRoleInfo.role_level = data.gameRoleLevel;
	gameRoleInfo.vip_level = data.vipLevel;
	gameRoleInfo.remainder = data.gameRoleBalance;
	return gameRoleInfo
end

function _M:createRole(data)
	--LuaLogger.ds("createRole", tablex.dump(data))
	local success = function (res)
	end
	local failed = function (res)
	end
	DXipuMiniSdk.RoleCreate(self.GenSdkRoleDataFromData(data), success, failed); -- 创建角色
end

function _M:enterGame(data)
	--LuaLogger.ds("enterGame", tablex.dump(data))
	local success = function (res)
	end
	local failed = function (res)
	end
	DXipuMiniSdk.RoleLogin(self.GenSdkRoleDataFromData(data), success, failed); -- 进入游戏
end

function _M:updateRole(data)
	--LuaLogger.ds("updateRole", tablex.dump(data))
	local success = function (res)
	end
	local failed = function (res)
	end
	DXipuMiniSdk.RoleUpgrade(self.GenSdkRoleDataFromData(data), success, failed); -- 角色升级
end

function _M:GetGameClubData(targetList, callback)
	if DXipuMiniSdk.GetGameClubData == nil then
		return
	end
	local succCallBack = function(str)
		LuaLogger.ds("获取游戏圈数据成功")
		local temp = cjson.decode(str)
		-- LuaLogger.ds(tablex.dump(temp))

		--temp为null则证明玩家未授权
		if temp and temp.dataList then
			WXLuaManager:updateWechatGameClubInfo(temp.dataList)
		else
			WXLuaManager:updateWechatGameClubInfo()
		end
		-- LuaLogger.ds("游戏圈总数据", tablex.dump(WXLuaManager:getWechatGameClubInfo()))
		if callback then
			callback(WXLuaManager:getWechatGameClubInfo())
		end
	end
	local failCallBack = function(str)
		LuaLogger.ds("获取游戏圈数据失败")
		local temp = cjson.decode(str)
		-- LuaLogger.ds(tablex.dump(temp))
	end
	--封装属性
	local array = System_Array.CreateInstance(typeof(System.String), #targetList)
	local num = 0
	for _, v in pairs(targetList) do
		local temp = cjson.encode(v)
		array[num] = temp
		num = num + 1
	end
	DXipuMiniSdk.GetGameClubData(array, succCallBack, failCallBack)
end

return _M
