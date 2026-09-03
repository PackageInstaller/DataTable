-- chunkname: @/tmp/or_script/lua_compile/dm/launch/login/LoginSystem.lua

EVT_LOGIN_REFRESH_SERVER = "EVT_LOGIN_REFRESH_SERVER"
EVT_ANNOUNCE_REFRESH_SERVER = "EVT_ANNOUNCE_REFRESH_SERVER"
EVT_PATFACE_REFRESH_SERVER = "EVT_PATFACE_REFRESH_SERVER"
EVT_PV_REFRESH_SERVER = "EVT_PV_REFRESH_SERVER"
EVT_REQUEST_LOGIN_SUCC = "EVT_REQUEST_LOGIN_SUCC"
LoginSystem = class("LoginSystem", Facade, _M)

LoginSystem:has("_curServer", {
	is = "rw"
})
LoginSystem:has("_loginService", {
	is = "r"
}):injectWith("LoginService")
LoginSystem:has("_gameServer", {
	is = "r"
}):injectWith("GameServerAgent")
LoginSystem:has("_login", {
	is = "r"
})
LoginSystem:has("_loginUrl", {
	is = "r"
})
LoginSystem:has("_playerRid", {
	is = "rw"
})
LoginSystem:has("_patFaceSaveData", {
	is = "rw"
})
LoginSystem:has("_announceSaveData", {
	is = "rw"
})
LoginSystem:has("_language", {
	is = "rw"
})
LoginSystem:has("_pvSaveData", {
	is = "rw"
})
LoginSystem:has("_logoPvName", {
	is = "rw"
})
LoginSystem:has("_logoSize", {
	is = "rw"
})
LoginSystem:has("_isShowAnnounce", {
	is = "rw"
})

local cjson = require("cjson.safe")

function LoginSystem:initialize()
	super.initialize(self)

	self._login = Login:new()
	self._loginUrl = nil
	self._isShowAnnounce = true
	self._announceSaveData = nil
	self._patFaceSaveData = nil
	self._language = GameLanguageTypeForGmPlatform[getCurrentLanguage()]
	self._pvSaveData = nil
end

function LoginSystem:vmsRequest(url, version, callback)
	if LOGIN_DEBUG then
		dump(url, "vms url")
		dump(version, "vms version")
	end

	self._loginService:vmsRequest(url, version, function(errorCode, response)
		local data = cjson.decode(response)
		local vmsInfo = data and data.data

		if vmsInfo and vmsInfo.data then
			if vmsInfo.data.webApiRoot then
				GameConfigs.webApiRoot = vmsInfo.data.webApiRoot
			elseif LOGIN_DEBUG then
				dump("vmsInfo.data.webApiRoot is nil")
			end

			if vmsInfo.data.switchConfig and type(vmsInfo.data.switchConfig) == "table" then
				for k, v in pairs(vmsInfo.data.switchConfig) do
					GameConfigs[tostring(k)] = v
				end
			end

			if callback then
				callback(errorCode, vmsInfo)
			end
		else
			DpsLogger:info("rtpvp", "vmsRequest: {}", response)
			self:dispatch(ShowTipEvent({
				tip = Strings:get("LOGIN_UI9") .. "vmsRequest"
			}))

			return
		end
	end)
end

function LoginSystem:getLoginUrl()
	return self._loginUrl
end

function LoginSystem:requestLogin(url, info, callback)
	info.did = PlatformHelper:getSdkDid()
	info.version = app:getAssetsManager():getCurrentVersion()
	info.baseversion = app.pkgConfig.packJobId

	if SDKUtils then
		info.pass = SDKUtils.getGamePass()
	end

	if LOGIN_DEBUG then
		dump(url, "login url")
		dump(info, "login info")
	end

	self._loginUrl = url

	self._loginService:requestLogin(url, info, function(errorCode, response)
		local responseData = cjson.decode(response)

		if errorCode == 200 and responseData and responseData.status == 0 then
			self._login:sync(responseData.data)

			if SDKHelper and SDKHelper:isEnableSdk() then
				SDKHelper:setOpenId(responseData.data.openid or "")
			end

			self._user_type = responseData.data.user_type or 0

			self:dispatch(Event:new(EVT_REQUEST_LOGIN_SUCC))

			if SDKHelper and SDKHelper:isEnableSdk() then
				SDKHelper:reportByServerList("gameGetServerListSuccess", url)
			end

			if SDKHelper and SDKHelper:isEnableSdk() then
				local serverInfo = self:getCurServer()

				if serverInfo then
					local setId = serverInfo:getSecId()
					local var_6_1 = {
						roleCombat = 0,
						roleId = 0
					}

					var_6_1.roleName = serverInfo:getNickName() or 0
					var_6_1.roleLevel = serverInfo:getLevel() or 0
					var_6_1.serverId = serverInfo:getSecId()
					var_6_1.vipLevel = serverInfo:getVipLevel() or 0
					var_6_1.serverName = serverInfo:getName()
					var_6_1.createTime = serverInfo:getCreateTime() or 0
					var_6_1.ip = tostring(serverInfo:getIp())
					var_6_1.port = tostring(serverInfo:getPort())

					SDKHelper:getServerListSuccess(var_6_1)
				end
			end
		else
			if SDKHelper and SDKHelper:isEnableSdk() then
				SDKHelper:reportLoginError()
				SDKHelper:reportByServerList("gameGetServerListError", url)
			end

			self:dispatch(ShowTipEvent({
				tip = Strings:get("LOGIN_UI9")
			}))

			if LOGIN_DEBUG then
				dump(errorCode, "login errorCode: ")
				dump(responseData, "login response: ")
			end
		end

		if callback then
			callback(errorCode, responseData)
		end
	end)
end

function LoginSystem:iOSAccount(url, callback)
	self._loginService:iOSAccount(url, function(errorCode, response)
		local responseData = cjson.decode(response)

		if errorCode == 200 and responseData and responseData.status == 0 then
			if callback then
				callback(errorCode, responseData)
			end
		else
			self:dispatch(ShowTipEvent({
				tip = string.format("iOSAccount error,errorCode:%s", errorCode)
			}))
		end
	end)
end

function LoginSystem:getAnnounceData(data)
	local params = {
		sdkId = self._login:getSdkIdForAnnounce(),
		language = self._language
	}

	self._loginService:getAnnounceData(self._loginUrl, params, true, function(errorCode, response)
		self._announceSaveData = cjson.decode(response)

		self:dispatch(Event:new(EVT_ANNOUNCE_REFRESH_SERVER, {}))
	end)
end

function LoginSystem:getZhengeSdkId()
	return self._login:getZhengeSdkId()
end

function LoginSystem:getZhengeChannelId()
	return self._login:getZhengeChannel()
end

function LoginSystem:getPatFaceData(data)
	local params = {
		language = self._language,
		isDeductTime = data.isDeductTime
	}

	self._loginService:getPatFaceData(params, false, function(response)
		self:syncPatFaceData(response)
		self:dispatch(Event:new(EVT_PATFACE_REFRESH_SERVER, {}))
	end)
end

function LoginSystem:getPatFaceDataToSave(callback)
	local params = {
		isDeductTime = 1,
		language = self._language
	}

	self._loginService:getPatFaceData(params, false, function(response)
		self:syncPatFaceData(response)

		if callback then
			callback()
		end
	end)
end

function LoginSystem:getAnnounceDataToSave(callback)
	local params = {
		sdkId = self._login:getSdkIdForAnnounce(),
		language = self._language
	}

	self._loginService:getAnnounceData(self._loginUrl, params, true, function(errorCode, response)
		self._announceSaveData = cjson.decode(response)

		if callback then
			callback()
		end
	end)
end

function LoginSystem:requestPlayerInfo(callback)
	local playerRid = self._playerRid
	local info = {}

	if SDKHelper then
		info = SDKHelper:getStatisticsBaseInfo()
	end

	info.user_type = self._user_type
	info.channel = self:getZhengeChannelId() or 0

	local params = {
		rid = playerRid,
		token = self._login:getGameServerToken(),
		baseInfo = info
	}
	local serverInfo = self:getCurServer()
	local developSystem = self:getInjector():getInstance(DevelopSystem)

	developSystem:setServerInfo(serverInfo:getSecId(), serverInfo:getIp(), serverInfo:getPort(), serverInfo:getName())
	self._loginService:requestPlayerInfo(params, true, function(response)
		if response.resCode == 10012 then
			REBOOT("REBOOT_NOUPDATE")
		end

		if response.resCode == GS_SUCCESS then
			local developSystem = self:getInjector():getInstance(DevelopSystem)

			if response.data.extra then
				if response.data.extra.timeOffset then
					self._gameServer:setTimeOffset(response.data.extra.timeOffset)
				end

				if response.data.extra.serverOpenTime then
					developSystem:setServerOpenTime(response.data.extra.serverOpenTime)
				end

				if response.data.extra.mergeTs then
					developSystem:setServerMergeTime(response.data.extra.mergeTs)
				end

				if response.data.extra.cBrideReward and response.data.extra.cBrideReward.battleFieldId then
					local worldPeaceSystem = self:getInjector():getInstance(WorldPeaceSystem)

					worldPeaceSystem:getWorldPeace():setBattleFieldId(response.data.extra.cBrideReward.battleFieldId)

					local groups = {}

					for k, v in pairs(response.data.extra.cBrideReward.groupMap or {}) do
						groups[#groups + 1] = {
							gId = k,
							gName = v
						}
					end

					worldPeaceSystem:getWorldPeace():setMatchGroupChat(groups)
				end

				if response.data.extra.timeZone then
					local serverTimeZone = response.data.extra.timeZone / 1000 / 3600

					developSystem:setTimeZone(serverTimeZone)
				end
			end

			developSystem:syncPlayer(response.data.player)

			if SDKHelper and SDKHelper:isEnableSdk() then
				local isnew = response.data.is_new

				if isnew == 1 then
					local player = developSystem:getPlayer()

					SDKHelper:reportCreate({
						roleName = tostring(player:getNickName()),
						roleId = tostring(player:getRid()),
						roleLevel = tostring(player:getLevel()),
						roleCombat = checkint(developSystem:getCombat()),
						serverId = serverInfo:getSecId(),
						vipLevel = tostring(player:getVipLevel()),
						serverName = serverInfo:getName(),
						createTime = tostring(player:getCreateTime()),
						ip = tostring(serverInfo:getIp()),
						port = tostring(serverInfo:getPort())
					})
				end
			end

			local pushSystem = self:getInjector():getInstance(PushSystem)

			pushSystem:listen()

			local resetSystem = self:getInjector():getInstance(ResetSystem)

			resetSystem:listenResetPush()

			if response.data.player.shops then
				local shopSystem = self:getInjector():getInstance(ShopSystem)

				shopSystem:initSync(response.data.player.shops)
			end

			if response.data.player.playerClub and response.data.player.playerClub.playerBSInfo then
				local clubBashenSystem = self:getInjector():getInstance(ClubBashenSystem)

				clubBashenSystem:synchronize(response.data.player.playerClub.playerBSInfo)

				if response.data.player.playerClub.playerBSInfo.manualFinish ~= nil then
					clubBashenSystem:synchronizeManualFinish(response.data.player.playerClub.playerBSInfo.manualFinish)
				end

				if response.data.player.playerClub.playerBSInfo.bigPrize then
					clubBashenSystem:synchronizeBigPrize(response.data.player.playerClub.playerBSInfo.bigPrize)
				end
			end

			if response.data.extra and response.data.extra.friendApplyCount then
				local friendSystem = self:getInjector():getInstance(FriendSystem)

				friendSystem:getFriendModel():setFriendApplyCount(response.data.extra.friendApplyCount)
			end

			if response.data.player.customData then
				local customDataSystem = self:getInjector():getInstance(CustomDataSystem)

				customDataSystem:sync(response.data.player.customData)

				local monthSignInSystem = self:getInjector():getInstance(MonthSignInSystem)

				monthSignInSystem:syncTodayReward()

				local surfaceSystem = self:getInjector():getInstance(SurfaceSystem)

				surfaceSystem:initSurfaceCustomData()
			else
				local customDataSystem = self:getInjector():getInstance(CustomDataSystem)

				customDataSystem:requestGetData(true)
			end

			if callback then
				callback()
			end

			StatisticSystem:setRid(playerRid)
		end
	end)
end

function LoginSystem:getServerList()
	return self._login:getServerList()
end

function LoginSystem:setCurServer(server)
	self._curServer = server
end

function LoginSystem:getCurServer()
	if self._curServer == nil then
		local lastServerId = self._login:getLastLoginSec()

		if lastServerId then
			self._curServer = self._login:getServerBySec(lastServerId)
		end

		self._curServer = self._curServer or self._login:getRandomServer()
	end

	return self._curServer
end

function LoginSystem:getUid()
	return self._login:getUid()
end

function LoginSystem:getAnnounce()
	return self._login:getAnnounce()
end

function LoginSystem:randomLoadingView()
	local config

	do
		local loadingIdList = ConfigReader:getDataByNameIdAndKey("ConfigValue", "LoadingConfigDefault", "content")

		if loadingIdList and #loadingIdList > 0 then
			local index = math.random(1, #loadingIdList)

			config = ConfigReader:getRecordById("Loading", loadingIdList[index])
		end

		return config
	end

	local serverInfo = self:getCurServer()
	local maxTimes = ConfigReader:getDataByNameIdAndKey("ConfigValue", "LoadingTime", "content")
	local loginTimes = serverInfo:getDailyLoginTimes()

	if maxTimes < loginTimes or loginTimes == 0 then
		local loadingIdList = ConfigReader:getDataByNameIdAndKey("ConfigValue", "LoadingConfigDefault", "content")

		if loadingIdList and #loadingIdList > 0 then
			local index = math.random(1, #loadingIdList)

			config = ConfigReader:getRecordById("Loading", loadingIdList[index])
		end
	else
		local loginDays = serverInfo:getLoginDays()
		local vipLevel = serverInfo:getVipLevel()
		local specialConfig = ConfigReader:getDataByNameIdAndKey("ConfigValue", "LoadingConfig", "content")

		if specialConfig then
			local idList = {}

			for _, value in pairs(specialConfig) do
				local condition = value.condition

				if condition then
					local isDay = false
					local isVip = false

					isDay = condition.day and loginDays == condition.day or true
					isVip = condition.vip and vipLevel == condition.vip or true

					if isDay and isVip then
						idList = value.loading

						break
					end
				end
			end

			if not idList or #idList < 1 then
				idList = ConfigReader:getDataByNameIdAndKey("ConfigValue", "LoadingConfigDefault", "content")
			end

			if idList and #idList > 0 then
				local index = math.random(1, #idList)

				config = ConfigReader:getRecordById("Loading", idList[index])
			end
		end
	end

	return config
end

function LoginSystem:getLimitTimeBg()
	local allBg = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Newyear_MainLoginScene", "content")

	if allBg then
		for i, v in pairs(allBg) do
			if v.time then
				local startDate = TimeUtil:parseDateTime(nil, v.time.start)
				local curTime = self:getInjector():getInstance(GameServerAgent):remoteTimestamp()
				local startTs = TimeUtil:timeByRemoteDate(startDate)
				local endDate = TimeUtil:parseDateTime(nil, v.time["end"])
				local endTs = TimeUtil:timeByRemoteDate(endDate)

				if startTs < curTime and curTime < endTs then
					return v.id
				end
			end
		end
	end
end

function LoginSystem:getIsNewLoading()
	local loadingTime = ConfigReader:getDataByNameIdAndKey("ConfigValue", "AnniversaryLoading", "content")

	if loadingTime and loadingTime.start then
		local startDate = TimeUtil:parseDateTime(nil, loadingTime.start[1])
		local curTime = self:getInjector():getInstance(GameServerAgent):remoteTimestamp()
		local startTs = TimeUtil:timeByRemoteDate(startDate)
		local endDate = TimeUtil:parseDateTime(nil, loadingTime.start[2])
		local endTs = TimeUtil:timeByRemoteDate(endDate)

		if startTs < curTime and curTime < endTs then
			return true
		end
	end

	return false
end

function LoginSystem:syncPatFaceData(response)
	self._patFaceSaveData = {}
	self._pvSaveData = {}

	if response.data then
		for i, v in pairs(response.data) do
			if v.type == 1 then
				self._patFaceSaveData[#self._patFaceSaveData + 1] = v
			elseif v.type == 2 then
				self._pvSaveData[#self._pvSaveData + 1] = v
			end
		end

		self:downloadPVFile()
	end
end

function LoginSystem:downloadPVFile()
	local data = self:getPvSaveData()
	local loadTaskTable = {}
	local downloader = Downloader:getInstance()
	local fileUtils = cc.FileUtils:getInstance()
	local pvDir = fileUtils:getWritablePath() .. "PVDir"

	if not fileUtils:isDirectoryExist(pvDir) then
		fileUtils:createDirectory(pvDir)
	end

	for i, v in pairs(data) do
		local function addTask(path)
			local storagePath = pvDir .. "/" .. path

			if fileUtils:isFileExist(storagePath) then
				return
			else
				loadTaskTable[#loadTaskTable + 1] = {
					urlPath = v.baseUrl .. path,
					storagePath = storagePath
				}
			end
		end

		local pvImgPath = v.mainbody.images[1]

		addTask(pvImgPath)

		local pvPath = v.pvvideo

		addTask(pvPath)
	end

	for i, params in pairs(loadTaskTable) do
		local storagePath = params.storagePath
		local url = params.urlPath

		local function onFileTaskSuccess(task)
			if fileUtils:isFileExist(storagePath) then
				self:dispatch(Event:new(EVT_PV_REFRESH_SERVER, {}))
			end
		end

		local function onTaskError(task, errorCode, errorCodeInternal, errorStr)
			return
		end

		local taskInfo = {
			type = "file",
			identifier = storagePath,
			srcUrl = url,
			storagePath = storagePath,
			onTaskError = onTaskError,
			onFileTaskSuccess = onFileTaskSuccess
		}

		downloader:addDownloadTask(taskInfo)
	end
end

function LoginSystem:addDownloadTask()
	return
end
