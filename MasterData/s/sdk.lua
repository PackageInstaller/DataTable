---@class SDK
local SDK = class("SDK")
local cjson = require "cjson"
require "PassportDef"

local _emailAccoutKey = "EmailAccount"
local _emailPasswordKey = "EmailPassword"
local _accoutKey = "Account"
local _passwordKey = "Password"
local _quickAccoutKey = "QuickAccount"
local _quickPasswordKey = "QuickPassword"
local _loginTypeKey = "LoginType"
local _QuickLoginKey = "QuickLogin" -- LoginType是Official的情况，是否是游客登录
local _userIdKey = "UserId" -- firebase userId
local _tokenKey = "token" -- firebase token

function SDK:ctor(passport, url)
	self.uuid = ""
	self.token = ""
	self.platform = 0 -- 目前只有0
	self.lastLoginZone = nil
	self.loginIn = nil
	self.dPassport = require(passport):new(url)
	self.IsAutoLogin = nil
	self.lastLoginData = {} -- 上次登录数据
	self.fireLastLoginResult = nil -- firebase 上次成功登录获得的对象
	self.isMaintaning = nil -- 是否在维护
	self.loginType = GE.LoginType.Official

	local platform = require "platform"
	self.passporturl = platform.passporturl
	self.loginip = platform.loginip
	self.loginport = platform.loginport
	self.datalogip = platform.datalogip
	
	local testAdmobRewardAdUnit = "ca-app-pub-3940256099942544/5224354917"
	self.AdUnitIOS = testAdmobRewardAdUnit
	self.AdUnitAndroid = testAdmobRewardAdUnit

	self.platformSubid = GE.DeviceSubType.Windows_Editor
	self:initPlatformSubid()
end

function SDK:getRewardAdUnit()
	if UnityEngine.Application.platform == UnityEngine.RuntimePlatform.IPhonePlayer then
		return self.AdUnitIOS
	else
		--elseif UnityEngine.Application.platform == UnityEngine.RuntimePlatform.Android then
		return self.AdUnitAndroid
	end
end

function SDK:changeUrlRoot(url)
	self.passporturl = url
	self.dPassport.urlroot = url
end

function SDK:Clear()
	self:clear()
	self.loginSuccessCallBack = nil
	self.fastLoginSuccessCallBack = nil
	self.registerSuccessCallBack = nil
	self.quickRegisterSuccessCallBack = nil
	self.bindAccountCallBack = nil
	self.modifyPasswordCallBack = nil
	self.swtichAccountCallBack = nil
	self.errorCallback = nil
	self.logoutCallBack = nil
	self.ChangePasswordCallBack = nil
end

function SDK:GetUUID()
	if self.platform == 0 then
	end
	return self.uuid
end

function SDK:GetToken()
	if self.platform == 0 then
		return self.token
	end
	return ""
end

function SDK:isloginIn()
	return self.loginIn
end

function SDK:IsMaintaning()
	return self.isMaintaning
end

function SDK:getAccountPasswordData()
	local account, password = "", ""
	if UnityEngine.PlayerPrefs.HasKey(_accoutKey) then
		account = UnityEngine.PlayerPrefs.GetString(_accoutKey)
		password = UnityEngine.PlayerPrefs.GetString(_passwordKey)

		if SDK.IsQuickAccount(account) then
			account, password = "", ""
		end
	end
	
	return {account = account, password = password, loginType = GE.LoginType.Official}
end

function SDK:getEmailPasswordData()
	local emailAccount, emailPassword = "", ""
	if UnityEngine.PlayerPrefs.HasKey(_emailAccoutKey) then
		emailAccount = UnityEngine.PlayerPrefs.GetString(_emailAccoutKey)
		emailPassword = UnityEngine.PlayerPrefs.GetString(_emailPasswordKey)
	end
	
	return {emailAccount = emailAccount, emailPassword = emailPassword, loginType = GE.LoginType.Firebase_Email}
end

-- 始终传回account和password，上次的登录方式用loginType判断
function SDK:getLastLoginData()
	local account = ""
	local password = ""
	local emailAccount = ""
	local emailPassword = ""
	local loginType

	if UnityEngine.PlayerPrefs.HasKey(_accoutKey) then
		account = UnityEngine.PlayerPrefs.GetString(_accoutKey)
	end

	if UnityEngine.PlayerPrefs.HasKey(_passwordKey) then
		password = UnityEngine.PlayerPrefs.GetString(_passwordKey)
	end

	if UnityEngine.PlayerPrefs.HasKey(_loginTypeKey) then
		loginType = UnityEngine.PlayerPrefs.GetInt(_loginTypeKey)

		if loginType == GE.LoginType.Official then
			if UnityEngine.PlayerPrefs.HasKey(_QuickLoginKey) then
				account = UnityEngine.PlayerPrefs.GetString(_quickAccoutKey)
				password = UnityEngine.PlayerPrefs.GetString(_quickPasswordKey)
			end
		end
	else -- 没有登录过，或者是老版本还没记录这个值
		-- 如果登录过，那一定是老版本（新版本只要登录就有loginType，且老版本只有账号密码登录）
		if account ~= "" then
			if SDK.IsQuickAccount(account) then -- 游客账号
			else -- 非游客账号
			end
		end
	end
	
	if UnityEngine.PlayerPrefs.HasKey(_emailAccoutKey) then
		emailAccount = UnityEngine.PlayerPrefs.GetString(_emailAccoutKey)
	end
	
	if UnityEngine.PlayerPrefs.HasKey(_emailPasswordKey) then
		emailPassword = UnityEngine.PlayerPrefs.GetString(_emailPasswordKey)
	end

	if Standalone == nil then
	    Standalone = UnityEngine.PlayerPrefs.GetInt("Standalone", 0) == 1
	end

	return {account = account, password = password, loginType = loginType,
			emailAccount = emailAccount, emailPassword = emailPassword}
end

function SDK:getQuickLoginData()
	if UnityEngine.PlayerPrefs.HasKey(_QuickLoginKey) then
		local account = UnityEngine.PlayerPrefs.GetString(_quickAccoutKey)
		local password = UnityEngine.PlayerPrefs.GetString(_quickPasswordKey)

		return {account = account, password = password, loginType = GE.LoginType.Official}
	elseif not UnityEngine.PlayerPrefs.HasKey(_loginTypeKey) then -- 是老版本，游客登录还没有记录_QuickLoginKey
		if UnityEngine.PlayerPrefs.HasKey(_accoutKey) then -- 登录过
			local account = UnityEngine.PlayerPrefs.GetString(_accoutKey)
			local password = UnityEngine.PlayerPrefs.GetString(_passwordKey)
			if SDK.IsQuickAccount(account) then -- 是用的游客账号登录
				return {account = account, password = password, loginType = GE.LoginType.Official}
			end
		end
	end

	return
end

-- 账号密码登录数据
function SDK:getFormalAccountLoginData()
	if UnityEngine.PlayerPrefs.HasKey(_accoutKey) then -- 登录过
		local account = UnityEngine.PlayerPrefs.GetString(_accoutKey)
		local password = UnityEngine.PlayerPrefs.GetString(_passwordKey)
		if not SDK.IsQuickAccount(account) then -- 老版本可能是游客账号登录
			return {account = account, password = password, loginType = GE.LoginType.Official}
		end
	end
end

function SDK:removeQuickAccountCache()
	UnityEngine.PlayerPrefs.DeleteKey(_QuickLoginKey)
	UnityEngine.PlayerPrefs.DeleteKey(_quickAccoutKey)
	UnityEngine.PlayerPrefs.DeleteKey(_quickPasswordKey)
end

function SDK:saveLoginData(toSaveData)
	local account = toSaveData.account
	local password = toSaveData.password
	local loginType = toSaveData.loginType
	
	UnityEngine.PlayerPrefs.SetInt(_loginTypeKey, loginType or GE.LoginType.Official)
	UnityEngine.PlayerPrefs.SetInt("Standalone", Standalone and 1 or 0)
	if loginType == GE.LoginType.Official then
		if SDK.IsQuickAccount(account) then -- 游客账号 like Guestrdm_00d8ae4cf661bbc6985269ac727f2f8f
			UnityEngine.PlayerPrefs.SetString(_quickAccoutKey, account)
			UnityEngine.PlayerPrefs.SetString(_quickPasswordKey, password)
			UnityEngine.PlayerPrefs.SetInt(_QuickLoginKey, 1)
		else
			UnityEngine.PlayerPrefs.SetString(_accoutKey, account)
			UnityEngine.PlayerPrefs.SetString(_passwordKey, password)
			UnityEngine.PlayerPrefs.DeleteKey(_QuickLoginKey)
		end
	elseif loginType == GE.LoginType.Huawei then
	elseif loginType == GE.LoginType.QuickWrap then
	else
		UnityEngine.PlayerPrefs.DeleteKey(_QuickLoginKey)
		if loginType == GE.LoginType.Firebase_Email then
			UnityEngine.PlayerPrefs.SetString(_emailAccoutKey, account)
			UnityEngine.PlayerPrefs.SetString(_emailPasswordKey, password)
		else -- firebase password is token
			UnityEngine.PlayerPrefs.SetString(_userIdKey, account)
			UnityEngine.PlayerPrefs.SetString(_tokenKey, password)
		end
	end
	
    UnityEngine.PlayerPrefs.Save()
end

function SDK:getLastLoginZone()
	if self.lastLoginZone then
		return self.lastLoginZone
	end

	if not AccountPrefs then
		return
	end

	local lastServerInfo = AccountPrefs:GetString("lastServer")
	if lastServerInfo then
		if lastServerInfo ~= "" then
	        self.lastLoginZone = cjson.decode(lastServerInfo)
	    end
	end

    return self.lastLoginZone
end

function SDK:setLastLoginZone(zone)
	self.lastLoginZone = zone
	AccountPrefs:SetString("lastServer", cjson.encode(zone))
end

function SDK:updateLoginData(loginData)
	self.uuid = loginData.uuid
	self.token = loginData.token
	self.account = loginData.account
	self.lastLoginData = loginData
	self:SetIsNeedAuth(loginData.idcard_auth)
end

--获取是否需要实名认证
function SDK:GetIsNeedAuth()
	return self.isNeedAuth
end

--设置是否需要实名认证
function SDK:SetIsNeedAuth(bool)
	self.isNeedAuth = bool
end

function SDK:LoginSuccess(loginData)

	-- LuaLogger.ds(debug.traceback(),"===============================测试测试")

	self:updateLoginData(loginData)
	self.loginIn = true -- todo:没有地方设为false
	if self.loginSuccessCallBack then
		self.loginSuccessCallBack()
	end
end

function SDK:LoginSuccessCallBack(func)
	self.loginSuccessCallBack = func
end

function SDK:FastLoginSuccess(token)
	self.token = token
	if self.fastLoginSuccessCallBack then
		self.fastLoginSuccessCallBack()
	end
end

function SDK:FastLoginSuccessCallBack(func)
	self.fastLoginSuccessCallBack = func
end

--注册成功
function SDK:RegisterSuccess(data)
	if self.registerSuccessCallBack then
		self.registerSuccessCallBack()
	end
end

function SDK:RegisterSuccessCallBack(func)
	self.registerSuccessCallBack = func
end

--修改密码成功
function SDK:ChangePasswordSuccess(data)
	if self.ChangePasswordCallBack then
		self.ChangePasswordCallBack()
	end
end

function SDK:ChangePasswordCallBack(func)
	self.ChangePasswordCallBack = func
end

function SDK:QuickRegisterSuccess(account, password)
	--self.token = token
	if self.quickRegisterSuccessCallBack then
		self.quickRegisterSuccessCallBack(account, password)
	end
end

function SDK:QuickRegisterSuccessCallBack(func)
	self.quickRegisterSuccessCallBack = func
end

function SDK:SetErrorCallback(callback)
	self.errorCallback = callback
end

function SDK:ErrorCallback(response)
	if response.error == GE.PassportErrorCode.Maintaining then
		self.isMaintaning = true
	end
	
	if self.errorCallback then
		self.errorCallback(response)
	end
end

function SDK:SetLogoutCallBack(func)
	self.logoutCallBack = func
	local beLogoutFunc = self.dPassport and self.dPassport.setBeLogout
	if beLogoutFunc then
		beLogoutFunc(self.dPassport, func)
	end
end

function SDK:BindAccount()
	if self.bindAccountCallBack then
		self.bindAccountCallBack()
	end
end

function SDK:BindAccountCallBack(func)
	self.bindAccountCallBack = func
end

function SDK:ModifyPassword()
	if self.modifyPasswordCallBack then
		self.modifyPasswordCallBack()
	end
end

function SDK:ModifyPasswordCallBack(func)
	self.modifyPasswordCallBack = func
end

function SDK:SwtichAccount()
	if self.swtichAccountCallBack then
		self.swtichAccountCallBack()
	end
end

function SDK:SwtichAccountCallBack(func)
	self.swtichAccountCallBack = func
end

function SDK:PopLogin()
	UIMgr:popUICover("WinSDK", {funcType = GE.SDKFuncType.Login})
	--if Application.platform == UnityEngine.RuntimePlatform.WindowsPlayer or Application.platform == UnityEngine.RuntimePlatform.WindowsEditor or Application.platform == UnityEngine.RuntimePlatform.OSXEditor then
	--	UIMgr:popUI("WinSDK")
	--else
	--	UIMgr:popUI("WinSDK")
	--end
end

function SDK:OpenPersonalCenter()
	if Application.platform == UnityEngine.RuntimePlatform.WindowsPlayer or Application.platform == UnityEngine.RuntimePlatform.WindowsEditor or Application.platform == UnityEngine.RuntimePlatform.OSXEditor then

	else
		
	end
end

function SDK:GetUserInfo()
	
end

function SDK:doRegister(loginData, callback)
	self:doRegisterFormal(loginData, callback)
end

-- true为login
function SDK:dealFirebaseLoginCallback(taskResult, callback, loginOrReg)
	local data = {}
	if taskResult.Code == 0 then -- Firebase.Auth.AuthError.None
		SignInManager.GetUserToken(function (taskResult2)
			if taskResult2.Code == 0 then
				self.fireLastLoginResult = taskResult
				
				if self.loginType == GE.LoginType.Firebase_Email then
					data.account = self.tempEmailAccount
					data.password = self.tempEmailPassword
				else
					data.account = taskResult.LoginData.UserId
					data.password = SignInManager.Token
				end

				data.loginType = self.loginType
				data.token = SignInManager.Token
				data.uuid = taskResult.LoginData.UserId
				
				if loginOrReg then
					self:LoginSuccess(data)
				else
					self:RegisterSuccess(data)
				end

				callback(true, data)
			else
				callback(false, taskResult)
				self:ErrorCallback(taskResult)
			end
		end)
	else
		callback(false, taskResult)
		self:ErrorCallback(taskResult)
	end
end

-- id:身份证号
-- name:名字
-- 只有 账号注册/邮箱注册 会调到这里
function SDK:doRegisterFormal(loginData, callback)
	self.loginType = loginData.loginType
	self.isMaintaning = nil
	self:getLoginInfo(function ()
		if loginData.loginType == GE.LoginType.Official then
			self.dPassport:RegisterFormal(loginData, function(bSucces,data)
				if bSucces == true then
					data.account = loginData.account
					data.password = loginData.password
					data.loginType = loginData.loginType

					self.uuid = data.uuid
					self.token = data.token
					self:RegisterSuccess(data)
				else
					LuaLogger.w(string.format("Register error!  = %s", data))
					self:ErrorCallback(data)
				end
				callback(bSucces, data)
			end)
		elseif loginData.loginType == GE.LoginType.Firebase_Email then
			SignInManager.Init(function (initResult)
				if initResult.Code == 0 then
					SignInManager.CreateUserWithEmailAsync(loginData.emailAccount, loginData.emailPassword, function (taskResult)
						self.tempEmailAccount = loginData.emailAccount
						self.tempEmailPassword = loginData.emailPassword
						--self:dealFirebaseLoginCallback(taskResult, callback, false)
						if taskResult.Code == 0 then
							SignInManager.VerifyEmailAsync(function (verifyResult) -- 邮箱注册需要验证邮箱才能登录
								if verifyResult.Code == 0 then
									local data = {}
									data.account = loginData.emailAccount
									data.password = loginData.emailPassword
									data.loginType = loginData.loginType
									data.uuid = taskResult.LoginData.UserId
									callback(true, data)
								else
									callback(false, verifyResult)
									self:ErrorCallback(verifyResult)
								end
							end)
						else
							callback(false, taskResult)
							self:ErrorCallback(taskResult)
						end
					end)
				else
					callback(false, initResult)
					self:ErrorCallback(initResult)
				end
			end)
		end
	end, callback)
end

-- 修改密码
function SDK:doChangePassword(loginData, callback)
	self.loginType = loginData.loginType
	self.isMaintaning = nil
	if loginData.loginType == GE.LoginType.Official then
		self.dPassport:ChangePassword(loginData, function(bSucces,data)
			-- if bSucces == true then
			-- 	self:ChangePasswordSuccess()
			-- else
			-- 	LuaLogger.w(string.format("ChangePassword error!  = %s", data))
			-- 	self:ErrorCallback(data)
			-- end
			callback(bSucces, data)
		end)
	end
end

function SDK:doFastRegister(callback)
	if self.platform == 0 then
		self.isMaintaning = nil
		self:getLoginInfo(function ()
			self.dPassport:FastRegister(function(bSucces, data)
				if bSucces == true then
					self.account = data.account
					self.password = data.password
					self:QuickRegisterSuccess(self.account, self.password)
				else
					LuaLogger.es("FastRegister error", tablex.dump(data))
					self:ErrorCallback(data)
				end
				callback(bSucces, data)
			end)
		end, callback)
	else
		callback(false, "")
	end
end

function SDK:getDataFromCosData(data)
	--self.datalogip = data.datalogip
	--self.IOSReview = data.iosreview
	--self.iosCanvasPercent = data.iosCanvasPercent
	--self.passporturl = data.passporturl
	--self.loginip = data.loginip
	--self.loginport = data.loginport
	--self.AdUnitIOS = data.AdUnitIOS
	--self.AdUnitAndroid = data.AdUnitAndroid
	LuaLogger.ds("getDataFromCosData serverDat数据", tablex.dump(data))
	for k, v in pairs(data) do
		self[k] = v
	end
	self:changeUrlRoot(self.passporturl)
	if self.IOSReview and GV.GlobalConfig.IsInternalFormal() then
		GV.GlobalConfig.VerifyPhoneCode = false
		GV.GlobalConfig.ValidateID = false
	end
end

function SDK:getGameOpenLoginInfo(callback)
	if GV.GlobalConfig.LocalServerTest then
		callback(true)
		return
	end
	local url = EngineGlobal.resDir .. GlobalInfo.ResConfig.loginUrl
	local url_qa = string.gsub(url, "%.txt$", "_QA.txt")  -- .../serverdata.txt → .../serverdata_QA.txt

	local targetUrl
	if EngineGlobal.mode == "release" then
		targetUrl = url
	else
		targetUrl = url_qa
	end
	self:getCosContent(targetUrl, function (success, newResponse)
		if success then
			-- local key
			-- if GV.IsIOSLogic then
			-- 	key = "ios"
			-- else
			-- 	key = "android"
			-- end
			-- --安卓/Ios[模式]
			-- local response = newResponse[key][EngineGlobal.mode]
			local response = newResponse
			LuaLogger.ds("getLoginInfo serverdata", tablex.dump(response))
			self:getDataFromCosData(response)
			callback(true)
		else
			UICommonUtils.PopPromptOkCancelBox(LocalStrEnum.NetworkFailedRetry, function ()
				self:getGameOpenLoginInfo(callback)
			end, function ()
				UnityEngine.Application.Quit()
			end)
		end
	end)
end

--获取角色评论内容
---@param url string 存储桶路径
---@param callback function 回调函数
function SDK:getRoleCommentContent(data, callback)
	data.player_id = 4294967298
	data.domain = "battle"
	data.subdomain = cjson.encode(data.subdomain)
	local url = string.format("http://192.168.1.176:8000/api/v1/dialogue?player_id=%d&role_id=%d&domain=%s&subdomain=%s", data.player_id, data.role_id, data.domain, data.subdomain)
    local timeout = 20000
    local dict = {}
    HttpUtil.HttpGetInLua(url, timeout, dict, function(respcode, responseJson)
		LuaLogger.ds(respcode, responseJson)
        if respcode == 200 then
			local responseData = cjson.decode(responseJson)
			--LuaLogger.ds(">>>>>getRoleCommentContent<<<<<", tablex.dump(responseData))
			callback(true,responseData)
		else
			callback(false)
		end
	end)
	
end

---获取存储桶玩家记录的数据
---@param url string 存储桶路径
---@param callback function 回调函数
function SDK:getUserCosLog(url, callback)
	local dict = {}
	local loaderId = UIMgr:startLoad(1)
	local timeout = 10000
	HttpUtil.HttpGetInLua(url, timeout, dict, function(respcode, response)
		UIMgr:endLoad(loaderId)
		if respcode == 200 then
			local responseData = luautil.unserialize(response)
			callback(true,responseData)
		else
			callback(false, respcode)
		end
	end)
end

function SDK:getCosContent(url, callback)
	local CosTen = require "CosTen"
	local host = GlobalInfo.ResConfig.resHost
	local Authorization = CosTen.GetHostUrlAuthWithKey(host, url, GlobalInfo.ResConfig.secretId, GlobalInfo.ResConfig.secretKey)

	local dict = {}
	table.insert(dict, "authorization")
	table.insert(dict, Authorization)
	local loaderId = UIMgr:startLoad(1)
	-- for i = 1, 10, 1 do
	-- 	local id = UIMgr:startLoad(1)
	-- 	UIMgr:endLoad(id)
	-- end
	local timeout = 10000
	LuaLogger.ds("getCosContent path", "http://"..host..url)
	HttpUtil.HttpGetInLua("http://"..host..url, timeout, dict, function(respcode, responseJson)
		UIMgr:endLoad(loaderId)
		--LuaLogger.ws(respcode, responseJson)
		if respcode == 200 then
			if responseJson and not stringx.isNilOrEmpty(responseJson) then
				local response = cjson.decode(responseJson)
				callback(true, response)
			else
				LuaLogger.ws("response_body error")
				callback(false, {error = GE.PassportErrorCode.GetLoginInfoFailed})
				self:ErrorCallback({error = GE.PassportErrorCode.GetLoginInfoFailed})
			end
		else
			callback(false, {error = GE.PassportErrorCode.GetLoginInfoFailed})
			self:ErrorCallback({error = GE.PassportErrorCode.GetLoginInfoFailed})
		end
	end)
end

-- 只有获得成功才会调用sdkLoginCallback
-- 如果出现错误，则会调用callback
function SDK:getLoginInfo(sdkLoginCallback, callback)
	LuaLogger.ds("getLoginInfo")
	if not GV.GlobalConfig.LocalServerTest then
	-- if true then
		local maintenancefile = self.maintenancefile or "new_maintenance.txt"
		LuaLogger.ds("getLoginInfo maintenancefile", EngineGlobal.resDir.."/" ..maintenancefile)
		--保底维护控制
		self:getCosContent(EngineGlobal.resDir.."/" ..maintenancefile, function (success, response)
			if success then
				if response.maintaining and response.maintaining > 0 then
					---维护中
					response.error = GE.PassportErrorCode.Maintaining
					LuaLogger.ds("getLoginInfo维护信息", tablex.dump(response))
					callback(false, response)
				else
					--保底维护控制结束，继续获取登录信息
					local url = EngineGlobal.resDir..GlobalInfo.ResConfig.loginUrl
					local url_qa = string.gsub(url, "%.txt$", "_QA.txt")  -- .../serverdata.txt → .../serverdata_QA.txt
					local targetUrl
					if EngineGlobal.mode == "release" then
						targetUrl = url
					else
						targetUrl = url_qa
					end
					self:getCosContent(targetUrl, function (success, newResponse)
						-- local key
						-- if GV.IsIOSLogic then
						-- 	key = "ios"
						-- else
						-- 	key = "android"
						-- end
						-- --安卓/Ios[模式]
						-- local response = newResponse[key][EngineGlobal.mode]
						local response = newResponse
						LuaLogger.ds("getLoginInfo serverdata", tablex.dump(response))
						local successFunc = function()
							self:getDataFromCosData(response)
							self:changeUrlRoot(response.passporturl)
							sdkLoginCallback()
						end
						if success then
							ClientData:NoticeDataReq(function()
								--非release模式下不检测维护状态
								local isMaintaining = ClientData:IsMaintaning()
								if EngineGlobal.isAudit then
									isMaintaining = false
									LuaLogger.ds("getLoginInfo 审核模式，不检测维护状态")
								end
								if isMaintaining then
									UIMgr:popUICover("NoticePanel", {index = GE.NoticePage.System})
								end
								-- --维护中 需要检测白名单
								-- if isMaintaining then
								-- 	LuaLogger.ds("getLoginInfo维护中，继续检测白名单")
								-- 	--ip白名单开启
								-- 	local whiteList = ClientData:GetWhiteList()
								-- 	-- whiteList = {}
								-- 	-- -- local locationInfo = ThinkingAnalytics:getLocationInfo()
								-- 	-- local ip = locationInfo.ip
								-- 	local ip = GameObject.Find("LuaManager"):GetComponent("LocationInfo").ip
								-- 	LuaLogger.ds("getLoginInfo 检测的本地i为p", ip)
								-- 	local exist = false
								-- 	for k, v in pairs(whiteList) do
								-- 		if v == tostring(ip) then
								-- 			exist = true
								-- 			break
								-- 		end
								-- 	end
								-- 	--在白名单中
								-- 	if exist then
								-- 		LuaLogger.ds("getLoginInfo 在白名单中")
								-- 		successFunc()
								-- 	else
								-- 		LuaLogger.ds("getLoginInfo 不在白名单中")
								-- 		response.error = GE.PassportErrorCode.Maintaining
								-- 		callback(false, response)
								-- 	end
								-- else
								-- 	--不在维护中
								-- 	LuaLogger.ds("getLoginInfo不在维护中")
								-- 	if sdkLoginCallback then
								-- 		sdkLoginCallback()
								-- 	end
								-- end
							end)
							successFunc()
						else
							callback(false, response)
						end
					end)
				end
			else
				response.error = GE.PassportErrorCode.MaintenanceError
				LuaLogger.ds(tablex.dump(response))
				if callback then
					callback(false, response)
				end
			end
		end)
	else
		LuaLogger.ds("LocalServerTest, skip getLoginInfo")
		sdkLoginCallback()
	end
end

local _loginTypeProviderId = {
	[GE.LoginType.Firebase_Email] = "password",
	[GE.LoginType.Firebase_Google] = "google.com",
	[GE.LoginType.Firebase_Facebook] = "facebook.com",
	[GE.LoginType.Firebase_Twitter] = "twitter.com", -- guess
	[GE.LoginType.Firebase_Phone] = "phone",
	[GE.LoginType.Firebase_Apple] = "apple.com", -- todo:
}

local function _isFirebaseUserLogin(taskResult, loginData)
	if taskResult.LoginData then
		local signInProviderId = taskResult.LoginData.SignInProviderId
		return signInProviderId == _loginTypeProviderId[loginData.loginType]
	end
end

-- bindData={
-- account,password,bindEmail,
-- emailAccount,emailPassword
-- loginType
--}
function SDK:doBind(bindData, callback)
	local bindType = bindData.loginType
	local tempTaskResult
	
	local bindLogic = function (bindLogicData)
		self.dPassport:BindAccount(bindLogicData, function (bSuccess, data)
			if bSuccess then
				if bindType == GE.LoginType.Official then
					data.account = bindData.account
				else
					data.uuid = tempTaskResult.LoginData.UserId
					data.token = SignInManager.Token
					self.fireLastLoginResult = tempTaskResult

					if bindType == GE.LoginType.Firebase_Email then
						data.account = self.tempEmailAccount
					else
						data.account = self.uuid
					end
				end
				
				self.loginType = bindType
				data.loginType = bindType
				data.password = bindData.password or bindData.emailPassword
				self:updateLoginData(data)
				self:saveLoginData(data)
				self:removeQuickAccountCache()
			end
			callback(bSuccess, data)
		end)
	end

	if bindType == GE.LoginType.Official then
		self.dPassport:RegisterFormal(bindData, function(bSucces, data)
			if bSucces then
				self.dPassport:Login(bindData.account, bindData.password, function (bSucces2, data2) -- 需要登录一下
					if bSucces2 then
						bindLogic({token = self.token, newToken = data2.token, bindType = bindType}, callback)
					else
						callback(false, data2)
					end
				end)
			else
				LuaLogger.ws("For bind register error", tablex.dump(data))
				self:ErrorCallback(data)
				callback(false, data)
			end
		end)
	else
		SignInManager.Init(function (initResult)
			if initResult.Code == 0 then
				local firebaseCallbackForBind = function (taskResult)
					if taskResult.Code == 0 then -- Firebase.Auth.AuthError.None
						SignInManager.GetUserToken(function (taskResult2)
							if taskResult2.Code == 0 then
								tempTaskResult = taskResult
								bindLogic({token = self.token, newToken = SignInManager.Token, bindType = bindType}, callback)
							else
								callback(false, taskResult)
								self:ErrorCallback(taskResult)
							end
						end)
					else
						callback(false, taskResult)
						self:ErrorCallback(taskResult)
					end
				end
				
				if bindType == GE.LoginType.Firebase_Email then
					local bindEmailBeforeLogic = function (emailResult)
						if emailResult.Code == 0 then
							if emailResult.LoginData.IsEmailVerified then
								firebaseCallbackForBind(emailResult)
							else
								SignInManager.VerifyEmailAsync(function (verifyResult) -- 邮箱注册需要验证邮箱才能登录
									if verifyResult.Code == 0 then
										local data = {waitForEmailToVerify = true}
										callback(true, data)
									else
										callback(false, verifyResult)
										self:ErrorCallback(verifyResult)
									end
								end)
							end
						else
							callback(false, emailResult)
							self:ErrorCallback(emailResult)
						end
					end
					
					SignInManager.SigninWithEmailAsync(bindData.emailAccount, bindData.emailPassword, function (emailCreateResult)
						self.tempEmailAccount = bindData.emailAccount
						self.tempEmailPassword = bindData.emailPassword
						if emailCreateResult.Code == GE.FireBaseCode.None then
							--firebaseCallbackForBind(emailCreateResult)
							bindEmailBeforeLogic(emailCreateResult)
						elseif emailCreateResult.Code == GE.FireBaseCode.UserNotFound then
							SignInManager.CreateUserWithEmailAsync(bindData.emailAccount, bindData.emailPassword, function (taskResult)
								--firebaseCallbackForBind(taskResult)
								bindEmailBeforeLogic(taskResult)
							end)
						else
							firebaseCallbackForBind(emailCreateResult)
						end
					end)
					
				elseif bindType == GE.LoginType.Firebase_Google then
					SignInManager.SigninWithGoogleAsync(firebaseCallbackForBind)
				elseif bindType == GE.LoginType.Firebase_Apple then
					SignInManager.SigninWithAppleAsync(firebaseCallbackForBind)
				elseif bindType == GE.LoginType.Firebase_Facebook then
					SignInManager.SigninWithFacebookAsync(firebaseCallbackForBind)
				elseif bindType == GE.LoginType.Firebase_Twitter then
					SignInManager.SigninWithTwitterAsync(firebaseCallbackForBind)
				end
			else
				callback(false, initResult)
			end
		end)
	end
end

function SDK:resetEmailPassword(email, callback)
	SignInManager.Init(function (initResult)
		if initResult.Code == 0 then
			SignInManager.SendPasswordResetEmail(email, function (resetTask)
				callback(resetTask.Code == 0, resetTask)
			end)
		else
			callback(false, initResult)
		end
	end)
end

-- callback(bool, data)
-- 其中的data参考对应sdk中的格式，如OfficialPassport,HuaweiSdk
function SDK:doLogin(loginData, callback)
	LuaLogger.ds("SDK doLogin", debug.traceback())
	self.loginType = loginData.loginType
	local account, password = loginData.account, loginData.password
	
	--本地模式
	if Standalone then
		self:getLoginInfo(function ()
			local md5Lua = require "md5Lua"
			self.token = account .. "@" .. 0 .. ":" .. md5Lua.sumhexa(password)
			self:LoginSuccess(loginData)
			callback(true, loginData)
			return true
		end, callback
		)
		return
	end
	
	local continueFunc = function()
		self.isMaintaning = nil
		self:getLoginInfo(function ()
			if loginData.loginType == GE.LoginType.Official then
				self.dPassport:Login(account, password, function (bSuccess, data)
					if bSuccess then
						LuaLogger.ds("official data", tablex.dump(data))
						data.account = account
						data.password = password
						data.loginType = self.loginType
						self:LoginSuccess(data)
					else
						LuaLogger.ws("Login error", tablex.dump(data))
						self:ErrorCallback(data)
					end
					callback(bSuccess, data)
				end)
			elseif loginData.loginType == GE.LoginType.TapTap then
				local tapWrapSdk = self:getTapWrapSdk()
				tapWrapSdk:Login(function (bSuccess, data)
					if bSuccess then
						LuaLogger.ds("tap login data", tablex.dump(data))
						data.loginType = self.loginType
						self:LoginSuccess(data)
					else
						LuaLogger.ws("tap login error", tablex.dump(data))
						self:ErrorCallback(data)
					end
					callback(bSuccess, data)
				end)
			elseif loginData.loginType == GE.LoginType.Huawei then
				self.dPassport:Login(function (bSuccess, data)
					if bSuccess then
						LuaLogger.ds("huawei dPassport:Login success", tablex.dump(data))
						data.loginType = self.loginType
						self:LoginSuccess(data)
					else
						-- data:{sdkErrorCode=x,sdkErrorMsg=y,loginType=z}
						LuaLogger.ws("Login error", tablex.dump(data))
						self:ErrorCallback(data)
					end
					callback(bSuccess, data)
				end)
			elseif loginData.loginType == GE.LoginType.QuickWrap then
				self.dPassport:Login(function (bSuccess, data)
					if bSuccess then
						LuaLogger.ds("quicksdk dPassport:Login success", tablex.dump(data))
						data.loginType = self.loginType
						self.uuid = data.uid
						self:LoginSuccess(data)
					else
						LuaLogger.ws("Login error", tablex.dump(data))
						self:ErrorCallback(data)
					end
					callback(bSuccess, data)
				end)
			else
				local loaderId = UIMgr:startLoad(1)
				local cb = function (bSuccess, data)
					UIMgr:endLoad(loaderId)
					callback(bSuccess, data)
				end
				
				SignInManager.Init(function (initResult)
					LuaLogger.ds("firebase inited", initResult.Code)
					if initResult.Code == 0 then
						local firebaseCallback = function (taskResult)
							self:dealFirebaseLoginCallback(taskResult, cb, true)
						end
	
						if self.lastLoginData.loginType == loginData.loginType then
							if loginData.loginType ~= GE.LoginType.Firebase_Email then
								firebaseCallback(self.fireLastLoginResult)
								return
							else
								--self.tempEmailAccount = loginData.emailAccount
								--self.tempEmailPassword = loginData.emailPassword
								---- 如果上次邮箱登录成功后，可能后台删了账号或者改了密码，所以需要重新验证
								---- 如果是换了账号登录，就不能用reauth了，会报UserMismatch——The supplied credentials do not correspond to the previously signed in user
								--SignInManager.SigninWithEmailAsync(loginData.emailAccount, loginData.emailPassword, function (authResult)
								--	if authResult.Code == 0 then
								--		firebaseCallback(self.fireLastLoginResult)
								--	else
								--		cb(false, authResult)
								--	end
								--end)
							end
						end
	
						if loginData.loginType ~= GE.LoginType.Firebase_Email and _isFirebaseUserLogin(initResult, loginData) then
							firebaseCallback(initResult)
							return
						end
						
						if loginData.loginType == GE.LoginType.Firebase_Email then
							self.tempEmailAccount = loginData.emailAccount
							self.tempEmailPassword = loginData.emailPassword
							--SignInManager.SigninWithEmailAsync(loginData.emailAccount, loginData.emailPassword, firebaseCallback)
							SignInManager.SigninWithEmailAsync(loginData.emailAccount, loginData.emailPassword, function (emailTaskResult)
								if emailTaskResult.Code == 0 then
									if emailTaskResult.LoginData.IsEmailVerified then
										firebaseCallback(emailTaskResult)
									else
										emailTaskResult.Code = GE.FireBaseCode.UnverifiedEmail
										cb(false, emailTaskResult)
									end
								else
									cb(false, emailTaskResult)
								end
							end)
						elseif loginData.loginType == GE.LoginType.Firebase_Google then
							SignInManager.SigninWithGoogleAsync(firebaseCallback)
						elseif loginData.loginType == GE.LoginType.Firebase_Apple then
							SignInManager.SigninWithAppleAsync(firebaseCallback)
						elseif loginData.loginType == GE.LoginType.Firebase_Facebook then
							SignInManager.SigninWithFacebookAsync(firebaseCallback)
						elseif loginData.loginType == GE.LoginType.Firebase_Twitter then
							SignInManager.SigninWithTwitterAsync(firebaseCallback)
						end
					else
						cb(false, initResult)
					end
				end)
			end
		end, callback)
	end
	continueFunc()
end

function SDK:doLogout()
	self.loginIn = false
	UnityEngine.PlayerPrefs.DeleteKey(_loginTypeKey)

	local logoutFunc = self.dPassport.Logout
	if logoutFunc then
		logoutFunc(self.dPassport)
	end

	if self.loginType == GE.LoginType.TapTap then
		local tapWrapSdk = self:getTapWrapSdk()
		tapWrapSdk:Logout()
	end

	if self.logoutCallBack then
		self.logoutCallBack()
	end
end

function SDK:getLoginType()
	return self.loginType
end

function SDK:getSaveID()
	if self.loginType == GE.LoginType.Official then
		return self.account
	else
		return self.uuid
	end
end

function SDK.IsQuickAccount(account)
	return GF.IsQuickAccount(account)
end

-- 当前是否游客登录
function SDK:isQuickAccount()
	return SDK.IsQuickAccount(self.account)
end

function SDK:getChannel()
	if self.loginType == GE.LoginType.QuickWrap then
		return self.dPassport:getChannel()
	end
	
	return UpdateManager.Instance.Code5
end

function SDK:doLoginSuccess(data)
	GlobalInfo.account = data.account -- 渠道登录目前没有这个字段，只有authCode
	self:saveLoginData(data)
end

-- 是否显示删除账号按钮，来自cos中配置的字段
function SDK:isShowDeleteAccount()
	--return true
	return self.showDeleteAccount
end

function SDK:GetVerifyPhoneCode(data, callback)
	local getVerifyPhoneCodeFunc = self.dPassport.GetVerifyPhoneCode
	if not getVerifyPhoneCodeFunc then
		callback(false, {noFunc = true})
		return
	end

	getVerifyPhoneCodeFunc(self.dPassport, data, callback)
end

function SDK:isInited()
	local isInitedFunc = self.dPassport.isInited
	return not isInitedFunc or isInitedFunc(self.dPassport)
end

function SDK:init()  -- 暂时没有被调用
	--local initFunc = self.dPassport.init
	--return not initFunc or initFunc(self.dPassport)
end

function SDK:genSdkRoleDataFromData(data)
	local genSdkRoleDataFunc = self.dPassport.genSdkRoleData
	return not genSdkRoleDataFunc or genSdkRoleDataFunc(self.dPassport, data)
end

function SDK:createRole(data)
	--LuaLogger.ds("createRole", tablex.dump(data))
	local createRoleFunc = self.dPassport.createRole
	return not createRoleFunc or createRoleFunc(self.dPassport)
end

function SDK:enterGame(data)
	LuaLogger.ds("enterGame", tablex.dump(data))
	local enterGameFunc = self.dPassport.enterGame
	return not enterGameFunc or enterGameFunc(self.dPassport)
end

function SDK:updateHero(data)
	--LuaLogger.ds("updateRole", tablex.dump(data))
	local updateRoleFunc = self.dPassport.updateRole
	return not updateRoleFunc or updateRoleFunc(self.dPassport)
end

--实名认证
function SDK:GetVerifyAuthentication(data, callBack)
	--LuaLogger.ds("updateRole", tablex.dump(data))
	local authFunc = self.dPassport.GetVerifyAuthentication
	return not authFunc or authFunc(self.dPassport, data, callBack)
end

function SDK:isUserProtocolAgreed()
	return UnityEngine.PlayerPrefs.GetInt("__IsAgreeUserProtocol__", 0) == 1
end

function SDK:exit()
	if self.loginType == GE.LoginType.QuickWrap then
		if quicksdk.QuickSDK.getInstance():isChannelHasExitDialog() then
			quicksdk.QuickSDK.getInstance():exit()
		else
			UICommonUtils.PopPromptOkCancelBox(LocalStrEnum.UI_EscapeQuickGame, function ()
				Application.Quit()
			end)
		end
	end
end

function SDK:getTapWrapSdk()
	if not self.tapWrapSdk then
		self.tapWrapSdk = require "TapWrapSdk":new()
	end
	
	return self.tapWrapSdk
end

function SDK:startAntiAddiction()
	if self.loginType == GE.LoginType.TapTap then
		local tapWrapSdk = self:getTapWrapSdk()
		if tapWrapSdk.startAntiAddiction then
			tapWrapSdk:startAntiAddiction()
		end
	end
end

-- code == 500;   // 登录成功
-- code == 1000;  // 用户登出
-- code == 1001;  // 切换账号
-- code == 1030;  // 用户当前无法进行游戏
-- code == 1050;  // 时长限制
-- code == 9002;  // 实名过程中点击了关闭实名窗
function SDK:getTapAntiAddictionCallback()
	return function (code, string)
		LuaLogger.ws(code, string)
		if code == 1030 or code == 1050 or code == 9002 then
			GlobalInfo.AntiAddictionCantLogin = code
		elseif code == 500 then
			-- LuaLogger.ds("self.uuid", self.uuid)
			--self:getTapWrapSdk():setAntiAddictionAlready()
			GlobalInfo.AntiAddictionCantLogin = nil
		end
	end
end

-- 获取唯一id
---@return distinctId string 唯一id
function SDK:getDistinctId()
	return DUtil.GenerateDistinctId()
end

function SDK:initPlatformSubid()
	if UnityEngine.Application.platform == UnityEngine.RuntimePlatform.Android then
		self.platformSubid = GE.DeviceSubType.Android_Native
	elseif UnityEngine.Application.platform == UnityEngine.RuntimePlatform.IPhonePlayer then
		self.platformSubid = GE.DeviceSubType.iOS_Native
	elseif UnityEngine.Application.platform == UnityEngine.RuntimePlatform.WebGLPlayer then
		--TODO: 区分WebGL平台的subid
		self.platformSubid = GE.DeviceSubType.Windows_WebGL
	else
		self.platformSubid = GE.DeviceSubType.Windows_Editor
	end
end

function SDK:getPlatformSubid()
	-- LuaLogger.ds("SDK:getPlatformSubid", self.platformSubid)
	return self.platformSubid
end

return SDK