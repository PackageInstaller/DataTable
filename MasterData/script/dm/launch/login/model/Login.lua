-- chunkname: @/tmp/or_script/lua_compile/dm/launch/login/model/Login.lua

loginTag = "/gsapi/game/login"
vmsDefaultUrl = ""
ServerMarkType = {
	kRecommend = 2,
	kHot = 3,
	kNew = 1,
	kClose = 4,
	kNone = 0
}
ServerMarkTagBgNames = {
	[ServerMarkType.kNew] = "asset/common/common_bg_xin.png",
	[ServerMarkType.kRecommend] = "asset/common/common_bg_tj.png",
	[ServerMarkType.kHot] = "asset/common/common_bg_man.png",
	[ServerMarkType.kClose] = "asset/common/common_bg_man.png"
}
ServerMarkTagStringNames = {
	[ServerMarkType.kNew] = "LOGIN_UI24",
	[ServerMarkType.kRecommend] = "LOGIN_UI25",
	[ServerMarkType.kHot] = "LOGIN_UI26",
	[ServerMarkType.kClose] = "LOGIN_UI23"
}
ServerMarkTagOutlineStyle = {
	[ServerMarkType.kNew] = cc.c4b(29, 87, 21, 255),
	[ServerMarkType.kRecommend] = cc.c4b(87, 63, 21, 255),
	[ServerMarkType.kHot] = cc.c4b(87, 29, 21, 255),
	[ServerMarkType.kClose] = cc.c4b(87, 29, 21, 255)
}
ServerState = {
	kClose = 4,
	kNew = 2,
	kMaintain = 3,
	kNormal = 1
}
ServerStateImgNames = {
	[ServerState.kNew] = "denglu_img_02.png",
	[ServerState.kNormal] = "denglu_img_02.png",
	[ServerState.kMaintain] = "denglu_img_03.png",
	[ServerState.kClose] = "denglu_img_01.png"
}
ServerInfo = class("ServerInfo")

ServerInfo:has("_secId", {
	is = "r"
})
ServerInfo:has("_secIdx", {
	is = "r"
})
ServerInfo:has("_name", {
	is = "r"
})
ServerInfo:has("_ip", {
	is = "r"
})
ServerInfo:has("_port", {
	is = "r"
})
ServerInfo:has("_version", {
	is = "r"
})
ServerInfo:has("_markType", {
	is = "rw"
})
ServerInfo:has("_state", {
	is = "rw"
})
ServerInfo:has("_dailyLoginTimes", {
	is = "rw"
})
ServerInfo:has("_loginDays", {
	is = "rw"
})
ServerInfo:has("_vipLevel", {
	is = "rw"
})
ServerInfo:has("_openTime", {
	is = "rw"
})
ServerInfo:has("_registerFull", {
	is = "r"
})
ServerInfo:has("_onlineFull", {
	is = "r"
})
ServerInfo:has("_registerRecommend", {
	is = "r"
})
ServerInfo:has("_recommend", {
	is = "r"
})
ServerInfo:has("_headId", {
	is = "r"
})
ServerInfo:has("_level", {
	is = "r"
})
ServerInfo:has("_nickName", {
	is = "r"
})
ServerInfo:has("_lastLoginTime", {
	is = "r"
})
ServerInfo:has("_createTime", {
	is = "r"
})
ServerInfo:has("_logoutTs", {
	is = "r"
})
ServerInfo:has("_diamond", {
	is = "r"
})
ServerInfo:has("_regLimit", {
	is = "r"
})
ServerInfo:has("_isNewRecommend", {
	is = "r"
})
ServerInfo:has("_tag", {
	is = "r"
})

function ServerInfo:initialize()
	super.initialize(self)

	self._dailyLoginTimes = 0
	self._loginDays = 0
	self._vipLevel = 0
	self._openTime = 0
	self._registerFull = 0
	self._onlineFull = 0
	self._registerRecommend = 0
	self._state = ServerState.kNormal
	self._recommend = 0
	self._nickName = ""
	self._lastLoginTime = 0
	self._createTime = 0
	self._logoutTs = 0
	self._diamond = 0
	self._regLimit = false
	self._isNewRecommend = 0
	self._tag = 0
end

function ServerInfo:sync(data)
	if data.sec then
		self._secId = data.sec
	end

	if data.secIndex then
		self._secIdx = data.secIndex
	end

	if data.name then
		self._name = data.name
	end

	if data.ip then
		self._ip = data.ip
	end

	if data.port then
		self._port = tonumber(data.port)
	end

	if data.headId then
		self._headId = data.headId
	end

	if data.level then
		self._level = data.level
	end

	if data.version then
		self._version = data.version
	end

	if data.maintain and data.maintain == 1 then
		self._state = ServerState.kClose
	elseif data.registerFull and data.registerFull == 2 then
		self._state = ServerState.kMaintain
	end

	if data.recommend then
		self._recommend = data.recommend
	end

	if data.recommend2 ~= nil then
		self._recommend = data.recommend2
	end

	if data.logoutTs then
		self._logoutTs = data.logoutTs
	end

	if data.dailyLoginTimes then
		self._dailyLoginTimes = data.dailyLoginTimes
	end

	if data.loginDays then
		self._loginDays = data.loginDays
	end

	if data.vip then
		self._vipLevel = data.vip
	end

	if data.open_time then
		self._openTime = data.open_time
	end

	if data.onlineFull then
		self._onlineFull = data.onlineFull
	end

	if data.registerRecommend then
		self._registerRecommend = data.registerRecommend
	end

	if data.nickname then
		self._nickName = data.nickname
	end

	if data.diamond then
		self._diamond = data.diamond
	end

	if data.lastLoginTime then
		self._lastLoginTime = data.lastLoginTime
	end

	if data.createTime then
		self._createTime = data.createTime
	end

	if data.logoutTs then
		self._logoutTs = data.logoutTs
	end

	if data.regLimit ~= nil then
		self._regLimit = data.regLimit
	end

	if data.isNewRecommend ~= nil then
		self._isNewRecommend = data.isNewRecommend
	end

	if data.tag then
		self._tag = data.tag
	end

	if self:getTag() == ServerMarkType.kNew then
		self._state = ServerState.kNew
	end

	if self:getRegLimit() then
		self._state = ServerState.kClose
	end
end

Login = class("Login", objectlua.Object)

Login:has("_uid", {
	is = "r"
})
Login:has("_isnew", {
	is = "r"
})
Login:has("_serverList", {
	is = "r"
})
Login:has("_recommendList", {
	is = "r"
})
Login:has("_recentlyList", {
	is = "r"
})
Login:has("_lastLoginSec", {
	is = "r"
})
Login:has("_announce", {
	is = "r"
})
Login:has("_serverGroup", {
	is = "r"
})
Login:has("_secNamesMap", {
	is = "r"
})
Login:has("_serverTime", {
	is = "r"
})
Login:has("_sdkIdForAnnounce", {
	is = "r"
})
Login:has("_zhengeSdkId", {
	is = "r"
})
Login:has("_zhengeChannel", {
	is = "r"
})

local var_0_0 = {}
local var_0_1 = {
	name = "服务器"
}

var_0_1.sec = GameConfigs.svid or 11
var_0_1.ip = GameConfigs.serverIP or "192.168.1.17"
var_0_1.port = GameConfigs.serverPort or 8888
var_0_1.registerFull = ServerState.kClose
var_0_0[1] = var_0_1
TEST_SERVER = var_0_0

function Login:initialize()
	super.initialize(self)

	self._uid = nil
	self._isnew = nil
	self._serverList = {}
	self._recommendList = {}
	self._recentlyList = {}
	self._lastLoginSec = nil
	self._gameServerToken = ""
	self._serverGroup = {}
	self._secNamesMap = nil
	self._serverTime = 0
	self._serverIndexArr = {}
	self._sdkIdForAnnounce = "dpstorm"
	self._zhengeSdkId = ""
	self._zhengeChannel = ""
end

function Login:sync(data)
	local uid = data and data.uid

	if uid then
		self._uid = uid
	end

	if data.sec_show_name then
		self._secNamesMap = data.sec_show_name
	end

	local is_new = data and data.is_new

	if is_new then
		self._isnew = is_new
	end

	local secListData = data and data.sec_list

	self._gameServerToken = data and data.token

	if data and data.sdkData and data.sdkData.sdkId then
		self._zhengeChannel = data.sdkData.sdkId
	end

	if data and data.sdkData and data.sdkData.extra and data.sdkData.extra.zhengeSdkId then
		self._zhengeSdkId = data.sdkData.extra.zhengeSdkId
	end

	if data.time then
		self._serverTime = data.time
	end

	if data and data.sdkData and data.sdkData.sdkId then
		self._sdkIdForAnnounce = data.sdkData.sdkId
	end

	if secListData then
		self._curServer = nil

		table.sort(secListData, function(a, b)
			if a.open_time == b.open_time then
				return a.sec < b.sec
			end

			return a.open_time < b.open_time
		end)

		self._serverList = {}
		self._recommendList = {}

		for index, serverData in ipairs(secListData) do
			local serverInfo = ServerInfo:new()

			serverInfo:sync(serverData)

			local serverIndex = #self._serverList + 1

			self._serverList[serverIndex] = serverInfo

			if not serverInfo:getRegLimit() and serverInfo:getIsNewRecommend() == 1 then
				table.insert(self._serverIndexArr, serverIndex)
			end

			serverInfo:setMarkType(serverInfo:getTag())

			local state = serverInfo:getState()

			if state ~= ServerState.kMaintain and state ~= ServerState.kClose and (serverInfo:getRecommend() == 1 or serverInfo:getTag() == ServerMarkType.kRecommend or serverInfo:getTag() == ServerMarkType.kNew or index == #secListData - 1 and serverInfo:getRegisterRecommend() == 1) then
				self._recommendList[#self._recommendList + 1] = serverInfo
			elseif serverInfo:getRegLimit() and not serverInfo:getHeadId() then
				serverInfo:setState(ServerState.kClose)
				serverInfo:setMarkType(ServerMarkType.kClose)
			end
		end

		table.sort(self._recommendList, function(a, b)
			return a:getOpenTime() > b:getOpenTime()
		end)
	end

	local recentlyListData

	if data and data.sec_role_info then
		recentlyListData = data.sec_role_info
	end

	if recentlyListData then
		for sec, serverData in pairs(recentlyListData) do
			local serverInfo = self:getServerBySec(sec)

			if serverInfo then
				serverInfo:sync(serverData)

				self._recentlyList[#self._recentlyList + 1] = serverInfo
			end
		end

		table.sort(self._recentlyList, function(a, b)
			return a:getLogoutTs() > b:getLogoutTs()
		end)
	end

	if data and data.player_info then
		self._lastLoginSec = data.player_info.last_login_sec
	end

	if data and data.announce then
		self._announce = data.announce
	end
end

function Login:getServerBySec(sec)
	for i, value in pairs(self._serverList) do
		if tostring(value:getSecId()) == tostring(sec) then
			return value
		end
	end

	return self._serverList[#self._serverList]
end

function Login:getGameServerToken()
	if self._gameServerToken == "" or not self._gameServerToken then
		return ""
	end

	return self._gameServerToken
end

function Login:getRandomServer()
	if not self._curServer then
		local length = #self._serverIndexArr

		if length == 0 then
			length = 1
		end

		local randomIndex = math.random(1, length)
		local index = self._serverIndexArr[randomIndex]

		self._curServer = self._serverList[index] or self._serverList[#self._serverList]
	end

	return self._curServer
end
