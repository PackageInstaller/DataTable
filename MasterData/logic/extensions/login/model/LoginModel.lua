-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/login/model/LoginModel.lua

module("logic.extensions.login.model.LoginModel", package.seeall)

local M = class("LoginModel", BaseModel)
local json = require("cjson")

function M:onInit()
	self:onReset()
end

function M:onReset()
	self._userId = false
	self._socketPassword = false
	self._reason = false
	self._nickName = false
	self._serverIP = false
	self._serverPort = false
	self._serverName = false
	self._serverListData = BaseListModel.New()
	self._sessionId = false
	self._platformId = false
	self._isWebLogined = false
	self._logoutAndLoginAgain = false
	self._sdkNeedLogout = false
	self._account = false
	self._retryTime = 0
	self._cacheParam = false
	self._serverHostPorts = false
	self._isSyncServerTime = false
end

function M:syncServerTime(timestamp)
	ServerTime.init(0)
	ServerTime.sync(timestamp)

	self._isSyncServerTime = true

	local clockContext = ClockMgr.instance:getClockContext()

	clockContext._timestamp = ServerTime.now()
	clockContext._nextMinuteSecondDiff = 0
end

function M:getIsSyncServerTime()
	return self._isSyncServerTime
end

function M:setServerIPAndPort(ip, port)
	self._serverIP = ip
	self._serverPort = port
end

function M:getServerIPAndPort()
	return self._serverIP, self._serverPort
end

function M:getHostPorts()
	return self._serverHostPorts or {}
end

function M:getServerName()
	return self._serverName
end

function M:getServerIP()
	return self._serverIP
end

function M:addRetryTime()
	self._retryTime = self._retryTime + 1
end

function M:getRetryTime()
	return self._retryTime
end

function M:clearRetryTime()
	self._retryTime = 0
end

function M:setCacheParam(cacheParam)
	self._cacheParam = cacheParam
end

function M:getCacheParam()
	return self._cacheParam
end

function M:setUserId(userId)
	self._userId = tostring(userId)
end

function M:getUserId()
	return self._userId
end

function M:setSocketPassword(password)
	self._socketPassword = password
end

function M:setReason(reason)
	self._reason = reason
end

function M:isPolicyReason()
	if not SDKManager.getSDKInstacne():isPolicyVersion() then
		return false
	end

	local isPolicy = false

	if self._reason and string.find(self._reason, "userType") then
		isPolicy = true
	end

	return isPolicy
end

function M:getAccountAndSocketPassword()
	return self._account, self._userId .. "_" .. self._socketPassword
end

function M:getReason()
	return self._reason
end

function M:getReasonText()
	local reason = self._reason

	if self:isPolicyReason() then
		local policyStrArr = string.split(reason, "#")

		self.loginTimePolicy = policyStrArr[1]
		self.policyReason = policyStrArr[2]

		local realNameInfo = PlayerModel.instance:getRealNameInfo()

		if realNameInfo ~= nil then
			reason = self:isPolicyNight() and "根据未成年人保护政策，夜间22:00至次日8:00您不可在该时间段内进行游戏" or realNameInfo.userType == GameEnum.RealNameUserTypeEnum.Visitor and "游戏时长已达上限，冒险者升级账号后可继续体验" or "今日游戏时间已达上限，冒险者要注意休息哦"
		end
	end
end

function M:isPolicyNight()
	local isNight = false
	local serverTimeStrArr1 = string.split(self.loginTimePolicy, ":")
	local serverHour1 = tonumber(serverTimeStrArr1[1])
	local serverMin1 = tonumber(serverTimeStrArr1[2])
	local realNameInfo = PlayerModel.instance:getRealNameInfo()

	if realNameInfo ~= nil and realNameInfo and realNameInfo.onlineLimitTime ~= "" then
		local timeArr = string.split(realNameInfo.onlineLimitTime, "-")
		local beginArr = string.split(timeArr[1], ":")
		local beginHour = tonumber(beginArr[1])
		local beginMinute = tonumber(beginArr[2])
		local endArr = string.split(timeArr[2], ":")
		local endHour = tonumber(endArr[1])
		local endMinute = tonumber(endArr[2])
		local serverTimeStrArr = string.split(self.loginTimePolicy, ":")
		local serverHour = tonumber(serverTimeStrArr[1])
		local serverMin = tonumber(serverTimeStrArr[2])

		if beginHour < serverHour or serverHour == beginHour and beginMinute <= serverMin or serverHour < endHour or serverHour == endHour and serverMin <= endMinute then
			isNight = true
		end
	end

	return isNight
end

function M:setNickName(nickName)
	self._nickName = nickName
end

function M:getNickName()
	return self._nickName
end

function M:updateServerInfo(info)
	if info then
		local host = info.host
		local port = info.port

		self._serverHostPorts = {}

		if info.hostPorts and tostring(info.hostPorts) ~= "userdata: NULL" then
			for k, v in pairs(info.hostPorts) do
				local temp = string.split(info.hostPorts[k], ":")

				table.insert(self._serverHostPorts, {
					temp[1],
					temp[2]
				})

				if k == 1 then
					host = temp[1]
					port = temp[2]
				end
			end
		end

		self._userId = info.userId ~= json.null and tostring(info.userId) or "0"
		self._serverIP = host
		self._serverPort = port
		self._serverName = info.name

		BootstrapGameConfigMgr.setZoneId(info.zoneId)
	end
end

function M:getServerListData()
	return self._serverListData
end

local function isDevelopSharedServer(s)
	if s.hostPorts == json.null then
		return false
	end

	local maybe = {
		{
			2,
			"10.17.2.93:9333"
		},
		{
			2,
			"10.17.2.93:9334"
		},
		{
			2,
			"10.17.2.142:9333"
		}
	}

	for k, v in pairs(maybe) do
		if s.zoneId == v[1] and s.hostPorts[1] == v[2] then
			return true
		end
	end

	return false
end

local function compareServer(s1, s2)
	if isDevelopSharedServer(s1) then
		return true
	end

	if isDevelopSharedServer(s2) then
		return false
	end

	if s1.hostPorts ~= json.null and s2.hostPorts == json.null then
		return true
	end

	if s1.hostPorts == json.null and s2.hostPorts ~= json.null then
		return false
	end

	if s1.userId ~= json.null and s2.userId == json.null then
		return true
	end

	if s1.userId == json.null and s2.userId ~= json.null then
		return false
	end

	return false
end

function M:updateServerList(servers, lastZone)
	local l = self._serverListData

	l:clear()
	l:addMoList(servers or {})

	if enableDebug then
		l:sortMoList(compareServer)
	end

	if lastZone >= 0 then
		self:updateServerInfo(servers[lastZone + 1])

		return
	end

	for i = 1, l:getMoCount() do
		local s = l:getMoByIndex(i)

		if s.userId ~= json.null and s.hostPorts ~= json.null then
			self:updateServerInfo(s)

			return
		end
	end

	for i = 1, l:getMoCount() do
		local s = l:getMoByIndex(i)

		if s.hostPorts ~= json.null then
			self:updateServerInfo(s)

			return
		end
	end

	self:updateServerInfo(l:getMoByIndex(1))
end

function M:setSessionId(sessionId)
	self._sessionId = sessionId
end

function M:getSessionId()
	return self._sessionId
end

function M:setPlatformId(platformId)
	self._platformId = platformId
end

function M:getPlatformId()
	return self._platformId
end

function M:setIsWebLogined(isWebLogined)
	self._isWebLogined = isWebLogined
end

function M:getIsWebLogined()
	return self._isWebLogined
end

function M:setLogoutAndLoginAgain(isLoginAgain)
	self._logoutAndLoginAgain = isLoginAgain
end

function M:isLogoutAndLoginAgain()
	return self._logoutAndLoginAgain
end

function M:setSDKNeedLogout(isNeed)
	self._sdkNeedLogout = isNeed
end

function M:isSDKNeedLogout()
	return self._sdkNeedLogout
end

function M:setAccount(account)
	self._account = account
end

function M:getAccount()
	return self._account
end

function M:getCurServerState()
	local moList = self._serverListData:getMoList()
	local isOpen = false

	for k, v in pairs(moList or {}) do
		local host = v.host
		local port = v.port

		if v.hostPorts and tostring(v.hostPorts) ~= "userdata: NULL" then
			local info = string.split(v.hostPorts[1], ":")

			host = info[1]
			port = info[2]
		end

		if self._serverIP == host and self._serverPort == port then
			isOpen = v.state == 1

			break
		end
	end

	return isOpen
end

M.instance = M.New()

return M
