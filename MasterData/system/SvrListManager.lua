-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/System\\SvrListManager.lua

local UrlConfig = require("Network/UrlConfig")
local AccountManager = require("System/AccountManager")
local UserData = require("Helper/UserData")
local OpenServerConst = require("Network/OpenServerConst")
local EventConst = require("EventConst")
local ServerInfo = require("Network/ServerInfo")
local NetService = require("Network/NetService")
local OpenServerHelper = require("Network/OpenServerHelper")
local Analytics = require("SDK/Analytics")
local HttpUtils = Framework.Network.HttpUtils
local ClientUtils = ClientUtils
local IS_PUBLISH_VERSION = IS_PUBLISH_VERSION
local LuaToolkit = Framework.Tools.LuaToolkit
local Const = Const
local SvrListManager = {}
local self = SvrListManager
local REQ_TYPE = {
	ENTRY = 1,
	FULL = 2
}
local DATA_AES_KEY = "asdf1234qwer7894"
local UD_KEY_MAP = {
	[REQ_TYPE.ENTRY] = Const.UD_KEY_SVRLIST_ENTRY,
	[REQ_TYPE.FULL] = Const.UD_KEY_SVRLIST_FULL
}
local PRIORITY_NET = 2
local PRIORITY_LOCAL = 1

self.FALLBACK_CHAT_SERVER = "ws://127.0.0.1"
self.FALLBACK_FILE_SERVER = "http://127.0.0.1"
self.FALLBACK_SURVEY_SERVER = "https://survey.xgjoy.com/"
self.REQ_TYPE = REQ_TYPE
self.MAX_FAIL_COUNT = 3
self.REQUEST_CD = {
	0,
	4,
	8,
	16,
	32,
	32
}
self.SINGLE_FAIL_TIP = {
	[REQ_TYPE.ENTRY] = Lang.get(30055),
	[REQ_TYPE.FULL] = Lang.get(30056)
}
self.PRIORITY_SEVER_RECOMMEND = 1
self.PRIORITY_DEBUG_SAVE = 2
self.PRIORITY_USER = 10

function SvrListManager.init()
	self._chatSvr = nil
	self._raiders = nil
	self._fileSvr = nil
	self._surveySvr = nil
	self._ossUpdSvr = nil
	self._ossUpdPort = nil
	self._ossHttp = nil
	self._ossJson = nil
	self._localData = {}
	self._localDataPriority = {}
	self._cdIndexDict = {}
	self._requestTickDict = {}
	self._requestTimerDict = {}
	self._httpRespDict = {}
	self._failCountDict = {}
	self._urlDict = {}
	self._svrDict = {}
	self._fullList = {}
	self._recommendList = {}
	self._recentList = {}
	self._recommendSvrID = nil
	self._lastLoginSvrID = nil
	self._roleDict = {}
	self._selectedSvrID = nil
	self._selectedPriority = -10000

	self._initTimer()
	self._initSlot()
	self._initUrl()
	EventCenter.addEventListener(EventConst.ACCOUNT_LOGIN_FINISH, self._onLoginAccount)

	for name, reqType in pairs(REQ_TYPE) do
		self._loadData(reqType)
	end
end

function SvrListManager.destroy()
	EventCenter.removeEventListener(EventConst.ACCOUNT_LOGIN_FINISH, self._onLoginAccount)
end

function SvrListManager.requestUpdate(reqType)
	self._initUrl()

	local timer = self._requestTimerDict[reqType]

	if self.isRequestRunning(reqType) or timer == nil then
		return
	end

	timer:Restart()
	timer.func()
end

function SvrListManager.stopRequest(reqType)
	if self.isRequestRunning(reqType) then
		self._onRequestFinish(reqType, false)
	end
end

function SvrListManager.isRequestRunning(reqType)
	local timer = self._requestTimerDict[reqType]

	if timer then
		return timer:IsRunning()
	else
		return false
	end
end

function SvrListManager.getRecentList()
	return self._recentList
end

function SvrListManager.getRecommendList()
	return self._recommendList
end

function SvrListManager.getFullList()
	return self._fullList
end

function SvrListManager.getServerInfo(id)
	return id and self._svrDict[id] or nil
end

function SvrListManager.setServerInfo(info)
	if info and info.id then
		self._svrDict[info.id] = info
	end
end

function SvrListManager.getRoleInfo(id)
	return self._roleDict[id]
end

function SvrListManager.getRoleInfoFull()
	return self._roleDict
end

function SvrListManager.getServerName(id)
	local info = self._svrDict[id]

	return info and info.name
end

function SvrListManager.getCurServerName()
	return self.getServerName(self._selectedSvrID) or ""
end

function SvrListManager.getSelectedSvrID()
	return self._selectedSvrID
end

function SvrListManager.getSelectedSvrInfo()
	return self.getServerInfo(self._selectedSvrID)
end

function SvrListManager.isSelectedSvrValid()
	local svrInfo = self.getSelectedSvrInfo()

	return svrInfo ~= nil and svrInfo.isValid
end

function SvrListManager.getLastLoginSvrID()
	return self._lastLoginSvrID
end

function SvrListManager.getChatSvr()
	return self._chatSvr
end

function SvrListManager.getFileSvr()
	return self._fileSvr
end

function SvrListManager.getSurvey()
	return self._surveySvr
end

function SvrListManager.getOSSSvrs()
	return self._ossHttp, self._ossUpdSvr, self._ossUpdPort
end

function SvrListManager.getOSSSvrJson()
	return self._ossJson
end

function SvrListManager.getRaidersSvr()
	return self._raiders
end

function SvrListManager.getAccountSeverAndRoleInfo()
	local roleInfo = self.getRoleInfoFull()
	local currentServerInfo = self.getSelectedSvrInfo()
	local currentRoleInfo

	if currentServerInfo ~= nil then
		currentRoleInfo = self.getRoleInfo(currentServerInfo.id)
	end

	local resInfo = {}

	resInfo.allInfo = {}

	local currentRoleName = ""

	if currentRoleInfo ~= nil then
		currentRoleName = utils.splitString(currentRoleInfo.name, "-")[2]

		if currentRoleName == "" then
			currentRoleName = Lang.get(655)
		end
	end

	if currentServerInfo == nil then
		resInfo.currentInfo = {
			server_name = "",
			role_name = currentRoleName
		}
	else
		resInfo.currentInfo = {
			role_name = currentRoleName,
			server_name = currentServerInfo.name
		}
	end

	for key, value in pairs(roleInfo) do
		local roleName = utils.splitString(value.name, "-")[2]
		local severName = self.getServerInfo(key).name

		if roleName == "" then
			roleName = Lang.get(655)
		end

		local tempdic = {
			role_name = roleName,
			role_level = value.level,
			server_name = severName
		}

		table.insert(resInfo.allInfo, tempdic)
	end

	local resInfoJson = ClientUtils.table2String(resInfo)

	return resInfoJson
end

function SvrListManager.onPreConnect()
	local serverInfo = self.getSelectedSvrInfo()
	local msg

	if serverInfo then
		local maintainFinishTime = serverInfo.maintainFinishTime

		if serverInfo.state == Const.SERVER_STATE_MAINTAIN and maintainFinishTime and maintainFinishTime ~= 0 then
			msg = serverInfo.msg

			if msg == nil or msg == "" then
				local timeNow = os.time()
				local date = os.date("!*t", maintainFinishTime + os.difftime(timeNow, os.time(os.date("!*t", timeNow))))
				local timeStr = date and utils.format(Lang.get(30053), date.month, date.day, date.hour, date.min)

				msg = string.format(Lang.get(30054), timeStr)
			end
		end
	end

	NetService.connectFailedMsg = msg
end

function SvrListManager._initTimer()
	for name, reqType in pairs(REQ_TYPE) do
		self._requestTimerDict[reqType] = Timer.New(Slot(self._onTimerTick, reqType), 1, -1)
	end
end

function SvrListManager._initUrl()
	self._urlDict[REQ_TYPE.ENTRY] = UrlConfig.ServerListEntryUrl
	self._urlDict[REQ_TYPE.FULL] = UrlConfig.ServerListUrl
end

function SvrListManager._initSlot()
	for name, reqType in pairs(REQ_TYPE) do
		self._httpRespDict[reqType] = Slot(self._onHttpResponse, reqType)
	end
end

function SvrListManager._getReqData(reqType)
	local openId, token = self._getAccountInfo()
	local url = self._urlDict[reqType]
	local localData = self._localData[reqType]
	local timestamp = localData and localData.timestamp
	local params = {
		[OpenServerConst.OPEN_ID] = openId,
		[OpenServerConst.OPEN_TOKEN] = token,
		timestamp = timestamp
	}

	return url, params
end

function SvrListManager._getAccountInfo()
	local openId, token = AccountManager.getOpenID(), AccountManager.getToken()

	if openId == nil and not IS_PUBLISH_VERSION then
		local savedOpenId = UserData.loadCommonData(Const.UD_KEY_DEBUG_OPENID)
		local savedToken = UserData.loadCommonData(Const.UD_KEY_DEBUG_TOKEN)

		openId = savedOpenId ~= nil and savedOpenId ~= "" and savedOpenId or nil
		token = savedToken ~= nil and savedToken ~= "" and savedToken or nil
	end

	if openId == nil then
		openId = 0
	end

	return openId, token
end

function SvrListManager._onLoginAccount(succ)
	if succ then
		self._clearAllCD()
		self._loadData(REQ_TYPE.ENTRY)
	end
end

function SvrListManager._onTimerTick(reqType)
	if self._canSendRequestNow(reqType) then
		self._doSendRequest(reqType)
	end
end

function SvrListManager._onSingleRequestFailed(reqType)
	local cd = self._getCD(reqType)
	local failCount = (self._failCountDict[reqType] or 0) + 1

	self._failCountDict[reqType] = failCount

	if failCount >= self.MAX_FAIL_COUNT then
		self._onRequestFinish(reqType, false)
	elseif self.isRequestRunning(reqType) then
		local tip = self.SINGLE_FAIL_TIP[reqType]

		if tip then
			MsgManager.notice(tip)
		end
	end
end

function SvrListManager._onSingleRequestSucc(reqType)
	self._onRequestFinish(reqType, true)
end

function SvrListManager._onRequestFinish(reqType, succ)
	self._requestTimerDict[reqType]:Stop()

	self._failCountDict[reqType] = 0
end

function SvrListManager._doSendRequest(reqType)
	self._updateCDOnSendRequest(reqType)

	local url, params = self._getReqData(reqType)

	OpenServerHelper.httpGet(url, params, self._httpRespDict[reqType], 1)
end

function SvrListManager._onHttpResponse(reqType, succ, strData)
	local realSucc = false

	if succ then
		local data = ClientUtils.string2Table(strData)

		if not next(data) then
			local strData2 = Framework.Tools.AES.AESDecryptStringFromBase64StrKey(strData, DATA_AES_KEY)

			data = ClientUtils.string2Table(strData2)

			if not next(data) and reqType == REQ_TYPE.FULL then
				Analytics.logClientError("full_svrlist_error", strData, strData2)
			end
		end

		if self._checkDataValid(reqType, data) then
			if self._isSteamVersionServer() then
				if reqType == REQ_TYPE.ENTRY then
					data.node.n = "S-" .. data.node.i - Const.STEAM_SERVER_START + 1

					local splitted = utils.splitString(data.nodeidname, "|")
					local tempServerDataString

					for i = 1, #splitted - 1, 2 do
						local id = tonumber(splitted[i])

						if id >= Const.STEAM_SERVER_START then
							local tempString = id .. "|" .. "S-" .. id - Const.STEAM_SERVER_START + 1

							if tempServerDataString == nil then
								tempServerDataString = tempString
							else
								tempServerDataString = tempServerDataString .. "|" .. tempString
							end
						end
					end

					data.nodeidname = tempServerDataString
				elseif reqType == REQ_TYPE.FULL then
					local index = 1
					local toDelete = {}

					for key, value in pairs(data.node) do
						if value.i < Const.STEAM_SERVER_START then
							toDelete[index] = key
							index = index + 1
						end
					end

					for key, value in pairs(toDelete) do
						if key == 1 then
							table.remove(data.node, value)
						elseif data.node[value - key + 1] ~= nil then
							table.remove(data.node, value - key + 1)
						end
					end

					for key, value in pairs(data.node) do
						value.n = "S-" .. value.i - Const.STEAM_SERVER_START + 1
					end
				end
			end

			realSucc = true

			local old = self._localData[reqType]
			local oldTimestamp = old and old.timestamp
			local svrListChanged = false

			if oldTimestamp ~= nil and oldTimestamp == data.timestamp then
				-- block empty
			else
				self._localData[reqType] = data

				self._setLocalData(reqType, data, PRIORITY_NET, true)

				if not self._deepCompareWithoutTimestamp(old, data) then
					self._onGetNewData(reqType)

					svrListChanged = true
				end
			end

			if svrListChanged and EventCenter then
				EventCenter.sendEvent(EventConst.SERVER_LIST_CHANGED)
			end
		end
	end

	if realSucc then
		self._onSingleRequestSucc(reqType)
	else
		self._onSingleRequestFailed(reqType)
	end
end

function SvrListManager._setLocalData(reqType, data, priority, save)
	local old = self._localData[reqType]
	local oldPriority = self._localDataPriority[reqType] or -1

	if oldPriority <= priority then
		self._localData[reqType] = data
		self._localDataPriority[reqType] = priority

		if save then
			self._saveData(reqType)
		end
	end
end

function SvrListManager._onGetNewData(reqType)
	local data = self._localData[reqType]

	if data then
		if reqType == REQ_TYPE.ENTRY then
			self._handleDataEntry(data)
		elseif reqType == REQ_TYPE.FULL then
			self._handleDataFull(data)
		end

		self._refreshFullList()
	end
end

function SvrListManager._handleDataEntry(data)
	self._chatSvr = self._handleUrl(data.chatsvr or self.FALLBACK_CHAT_SERVER)

	self._chatSvr:Concat("/ws")

	self._fileSvr = self._handleUrl(data.filesvr or self.FALLBACK_FILE_SERVER)
	self._surveySvr = self._handleUrl(data.survey or self.FALLBACK_SURVEY_SERVER)
	self._raiders = self._handleUrl(data.discuss or self.FALLBACK_CHAT_SERVER)

	if data.flowdata_udp then
		self._ossUpdSvr, self._ossUpdPort = string.match(data.flowdata_udp, "udp://([%d%S.]+):(%d+)")
	end

	if data.flowdata_http then
		self._ossHttp = self._handleUrl(data.flowdata_http)

		self._ossHttp:Concat("/flowdata/client")
	end

	if data.flowdata_json then
		self._ossJson = data.flowdata_json .. "/flowdata"
	end

	local svrDict = self._svrDict
	local nameData = data.nodeidname

	self._handleDataName(nameData)

	local recentList = self._recentList

	for i, _ in ipairs(recentList) do
		recentList[i] = nil
	end

	local roleDict = self._roleDict

	for k, v in pairs(roleDict) do
		roleDict[k] = nil
	end

	local recentData = data.recent

	if recentData then
		for i = #recentData, 1, -1 do
			local curNodeID = recentData[i].nodeid

			if svrDict[curNodeID] == nil then
				table.remove(recentData, i)
			end
		end

		local roleCount = #recentData

		for i, roleInfo in ipairs(recentData) do
			local id = roleInfo.nodeid

			roleDict[id] = roleInfo
			recentList[roleCount - i + 1] = id
		end

		self._lastLoginSvrID = #recentList > 0 and recentList[1] or nil
	end

	local node = data.node

	if node then
		local nodeInfo = ServerInfo.createWith(node)

		if svrDict[nodeInfo.id] ~= nil then
			svrDict[nodeInfo.id] = nodeInfo
			self._recommendSvrID = nodeInfo.id
		end
	end

	if self._recommendSvrID then
		local recommendInfo = self.getServerInfo(self._recommendSvrID)

		if recommendInfo and recommendInfo.isValid then
			self.selectWithPriority(self._recommendSvrID, self.PRIORITY_SEVER_RECOMMEND)
		end
	end
end

function SvrListManager._handleUrl(urlData)
	local dataType = type(urlData)

	if dataType == "string" then
		return HttpHelper.createUrlGroup({
			urlData
		})
	elseif dataType == "table" then
		return HttpHelper.createUrlGroup(dataType)
	else
		return nil
	end
end

function SvrListManager._handleDataName(data)
	if not data then
		return
	end

	local svrDict = self._svrDict
	local splitted = utils.splitString(data, "|")
	local tempData = {}

	for i = 1, #splitted - 1, 2 do
		local id = tonumber(splitted[i])

		if id ~= nil then
			tempData.i = id
			tempData.n = splitted[i + 1]

			local oldInfo = svrDict[id]

			if oldInfo then
				ServerInfo.fillName(oldInfo, tempData)
			else
				svrDict[id] = ServerInfo.createWith(tempData)
			end
		end
	end
end

function SvrListManager._handleDataFull(data)
	local nodeList = data.node
	local recommendList = data.recommend
	local svrDict = self._svrDict
	local toRemove = {}

	if nodeList then
		for k, v in pairs(svrDict) do
			toRemove[k] = true
		end

		for i, data in ipairs(nodeList) do
			local id = data.i

			if id then
				local oldInfo = svrDict[id]

				if oldInfo then
					ServerInfo.fillWith(oldInfo, data)

					toRemove[id] = nil
				else
					svrDict[id] = ServerInfo.createWith(data)
				end
			end
		end
	end

	for k, _ in pairs(toRemove) do
		svrDict[k] = nil
	end

	if recommendList then
		table.sort(recommendList, function(a, b)
			return b < a
		end)

		self._recommendList = recommendList
	end
end

function SvrListManager.selectWithPriority(id, priority)
	if id and priority ~= nil and priority >= self._selectedPriority then
		self._selectedPriority = priority

		if self._selectedSvrID ~= id then
			self._selectedSvrID = id

			if EventCenter then
				EventCenter.sendEvent(EventConst.SELECTED_SERVER_CHANGED)
			end
		end
	end
end

function SvrListManager._refreshFullList()
	local fullList = self._fullList

	for i, _ in ipairs(fullList) do
		fullList[i] = nil
	end

	for id, _ in pairs(self._svrDict) do
		table.insert(fullList, id)
	end

	table.sort(fullList)
end

function SvrListManager._getCD(reqType)
	local lastReqTime = self._requestTickDict[reqType]

	if not lastReqTime then
		return 0
	end

	local maxIndex = #self.REQUEST_CD
	local index

	index = self._isLastRequstCooldown(reqType) and 1 or (self._cdIndexDict[reqType] or 0) + 1

	if maxIndex < index then
		index = maxIndex
	end

	local cd = self.REQUEST_CD[index]

	return cd
end

function SvrListManager._isLastRequstCooldown(reqType)
	local timeNow = os.time()
	local lastReqTime = self._requestTickDict[reqType]

	if lastReqTime == nil then
		return true
	end

	local resetTime = 2 * self.REQUEST_CD[#self.REQUEST_CD]

	return timeNow > lastReqTime + resetTime
end

function SvrListManager._canSendRequestNow(reqType, cd)
	if cd == nil then
		cd = self._getCD(reqType)
	end

	if cd == 0 then
		return true
	else
		local timeNow = os.time()
		local lastReqTime = self._requestTickDict[reqType]

		return timeNow > lastReqTime + cd
	end
end

function SvrListManager._updateCDOnSendRequest(reqType)
	if self._isLastRequstCooldown(reqType) then
		self._cdIndexDict[reqType] = 1
	else
		self._cdIndexDict[reqType] = (self._cdIndexDict[reqType] or 0) + 1
	end

	local timeNow = os.time()

	self._requestTickDict[reqType] = timeNow
end

function SvrListManager._clearAllCD()
	self._requestTickDict[REQ_TYPE.FULL] = 0
	self._requestTickDict[REQ_TYPE.ENTRY] = 0
end

function SvrListManager.clearServerList()
	self._recentList = {}
	self._recommendList = {}
	self._fullList = {}
	self._localData = {}

	local openID = self._getAccountInfo()
	local useBy = UrlConfig.useBy

	for i, v in pairs(UD_KEY_MAP) do
		if useBy then
			v = v .. "_" .. useBy
		end

		if openID then
			v = v .. "_" .. openID
		end

		UserData.clearCommonData(v)
	end
end

function SvrListManager._saveTable(reqType, useBy, openID)
	local data = self._localData[reqType]
	local key = UD_KEY_MAP[reqType]

	if data then
		local realKey = key

		if useBy then
			realKey = realKey .. "_" .. useBy
		end

		if openID then
			realKey = realKey .. "_" .. openID
		end

		local str = ClientUtils.table2String(data)

		UserData.saveCommonData(realKey, str)
	end
end

function SvrListManager._loadTable(reqType, useBy, openID)
	local key = UD_KEY_MAP[reqType]
	local realKey = key

	if useBy then
		realKey = realKey .. "_" .. useBy
	end

	if openID then
		realKey = realKey .. "_" .. openID
	end

	local str = UserData.loadCommonData(realKey)

	if str and str ~= "" then
		self._setLocalData(reqType, ClientUtils.string2Table(str), PRIORITY_LOCAL, false)
	end
end

function SvrListManager._loadData(reqType)
	local useBy = UrlConfig.useBy

	if reqType == REQ_TYPE.ENTRY then
		local openID = self._getAccountInfo()

		if openID then
			self._loadTable(reqType, Const.UD_KEY_SVRLIST_ENTRY, useBy, openID)
		end
	else
		self._loadTable(reqType, Const.UD_KEY_SVRLIST_ENTRY, useBy, nil)
	end

	self._onGetNewData(reqType)
end

function SvrListManager.changedLvOrHeadId(lv, headId)
	local data = self._localData[REQ_TYPE.ENTRY]
	local currServerNodeId = self.getSelectedSvrID()

	if data and data.recent then
		for i, v in ipairs(data.recent) do
			if v.nodeid == currServerNodeId then
				if lv ~= nil and lv > 0 then
					data.recent[i].level = lv

					break
				end

				if headId ~= nil then
					data.recent[i].head = headId
				end

				break
			end
		end
	end

	self._saveData(data)
end

function SvrListManager._saveData(reqType)
	local useBy = UrlConfig.useBy

	if reqType == REQ_TYPE.ENTRY then
		local openID = self._getAccountInfo()

		if openID then
			self._saveTable(reqType, Const.UD_KEY_SVRLIST_ENTRY, useBy, openID)
		end
	else
		self._saveTable(reqType, Const.UD_KEY_SVRLIST_ENTRY, useBy, nil)
	end
end

function SvrListManager._deepCompareWithoutTimestamp(x, y)
	local xTimestamp = x and x.timestamp
	local yTimestamp = y and y.timestamp

	if xTimestamp then
		x.timestamp = nil
	end

	if yTimestamp then
		y.timestamp = nil
	end

	local same = utils.deepcompare(x, y)

	if xTimestamp then
		x.timestamp = xTimestamp
	end

	if yTimestamp then
		y.timestamp = yTimestamp
	end

	return same
end

function SvrListManager._checkDataValid(reqType, data)
	local succ = false

	if data then
		if reqType == REQ_TYPE.ENTRY then
			succ = data.timestamp ~= nil
		elseif reqType == REQ_TYPE.FULL then
			succ = data.timestamp ~= nil
		end
	end

	return succ
end

function SvrListManager._isSteamVersionServer()
	local result = false

	if ChannelUtil.isSteam() and not IS_EDITOR and UrlConfig.postfix ~= "qa" and UrlConfig.postfix ~= "pre" and not VersionUtils.IsReviewVersion() then
		result = true
	end

	return result
end

return self
