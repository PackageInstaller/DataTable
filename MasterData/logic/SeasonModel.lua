-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/model/SeasonModel.lua

module("logic.extensions.season.model.SeasonModel", package.seeall)

local SeasonModel = class("SeasonModel", BaseModel)

SeasonModel.GVE_GROUP_STATE_NOT_INIT = -1
SeasonModel.GVE_GROUP_STATE_FREE = 0
SeasonModel.GVE_GROUP_STATE_PVE = 1
SeasonModel.GVE_GROUP_STATE_GROUPING = 2
SeasonModel.GVE_GROUP_STATE_GVE = 3
SeasonModel.PVE_GAME_MODE_NONE = 0
SeasonModel.PVE_GAME_MODE_PVE = 1
SeasonModel.PVE_GAME_MODE_GVE = 2

function SeasonModel:ctor()
	return
end

function SeasonModel:onInit()
	self:onReset()
end

function SeasonModel:onReset()
	self.seasonId = 0
	self.bossMo = SeasonBossMO.New()
	self._mapInfo = {}
	self.bubbleTimes = 0
	self._seasonInfoDataMap = {}
	self._seasonFragmentMap = {}
	self.serverMapVersion = nil
	self._latestOccupiedList = nil
	self._pathFindingGridDataOccupied = nil
	self._markPointIds = {}
	self._groupState = SeasonModel.GVE_GROUP_STATE_NOT_INIT
end

function SeasonModel:beforeEnter()
	self.seasonId = 0

	self:getSeasonId()
end

function SeasonModel:getSeasonId()
	if self.seasonId == 0 then
		self.seasonId = SeasonConfig.instance:getSeasonId()
	end

	return self.seasonId
end

function SeasonModel:addBubbleTimes()
	self.bubbleTimes = self.bubbleTimes + 1
end

function SeasonModel:getBubbleTimes()
	return self.bubbleTimes
end

function SeasonModel:setOpViewShowing(gridX, gridY)
	self._lastOpGridX = gridX
	self._lastOpGridY = gridY
end

function SeasonModel:isOpViewShowing(gridX, gridY)
	return gridX == self._lastOpGridX and gridY == self._lastOpGridY
end

function SeasonModel:getMarkPoints()
	return self._markPointIds
end

function SeasonModel:appendMarkPoints(ids, isMark)
	if isMark then
		for i, v in ipairs(ids) do
			table.insert(self._markPointIds, v)
		end
	else
		for i, v in ipairs(ids) do
			local idx = table.indexof(self._markPointIds, v)

			if idx ~= false then
				table.remove(self._markPointIds, idx)
			end
		end
	end
end

function SeasonModel:handleInit(params)
	if not params.markPointIds then
		local markPointIds = {}

		self._markPointIds = markPointIds

		for i = 1, #markPointIds do
			local id = markPointIds[i]
			local mapMo = self:getMapInfoById(id)

			self:setMarkState(id, true)
		end

		if not params.unlockedFog then
			local configInstance = SeasonConfig.instance

			for _, gridId in ipairs(params.unlockedFog) do
				local evtConfig = configInstance:getMapEvtTypeAndId(self:getSeasonId(), gridId)

				if evtConfig then
					local fogObjIds = string.splitToNumber(evtConfig.fogObjIds or "", ",")

					for _, linkElementId in ipairs(fogObjIds) do
						local linkGrid = SeasonPathFindingDataModel.instance:getGridIdByElementId(linkElementId)

						self:setMapInfoFogState(linkGrid, SeasonMapDataMO.Fog_Without)
					end
				end
			end

			if not params.danceLionUnlock then
				for _, v in ipairs(params.danceLionUnlock) do
					local gridId = v.pointId

					if not v.unlockedPointId then
						self:setMapInfoDanceLionState(gridId, v.unlockedPointId)
					end
				end

				SeasonBadgeModel.instance:setPresetBudgeList(params.medals)
				self:updateBossInfo(params.bossInfo)
			end
		end
	end
end

function SeasonModel:updateBossInfo(params)
	self.bossMo:update(params)
end

function SeasonModel:updateResetBossLockTeam(teamId)
	self.bossMo:updateResetBossLockTeam(teamId)
end

function SeasonModel:updateBossLockTeam(params)
	self.bossMo:updateBossLockTeam(params.doppelgangerPhaseInfo)
end

function SeasonModel:testPrintInfo()
	if self._cacheReqMap then
		local arr = {}

		for k, v in pairs(self._cacheReqMap) do
			table.insert(arr, k)
		end

		if #arr > 0 then
			printError(">>>>>>>>> 还有这么多格子数据对不上！>>>len: ", #arr, "[", table.concat(arr, ","), "]")
		end
	end
end

function SeasonModel:setReqMapInfoRecordMap(map)
	self._cacheReqMap = map
end

function SeasonModel:isLoadAllMapServerInfo()
	if self._cacheReqMap then
		for k, v in pairs(self._cacheReqMap) do
			return false
		end

		return true
	end

	return false
end

function SeasonModel:updateMapInfo(params)
	if not params.points then
		local points = {}

		for i = 1, #points do
			local id = points[i].pointId
			local mapMo = self:getMapInfoById(id)

			if self._cacheReqMap then
				self._cacheReqMap[id] = nil
			end

			mapMo:update(points[i])
		end
	end
end

function SeasonModel:updatePointsOccupiedInfo(params)
	local pointIds = params.pointIds
	local list = {}

	for _, gridId in ipairs(pointIds) do
		local evtConfig = SeasonConfig.instance:getMapEvtTypeAndId(self:getSeasonId(), gridId)

		if evtConfig then
			SeasonController.instance:recordRecentlyUnlockedFogsGrid(gridId)
			table.insert(list, gridId)
		end

		self:setOccupied(gridId)
		GlobalDispatcher:dispatch(GlobalNotify.SeasonServerNotifyOccupiedGrid, gridId)
	end

	if #list > 0 then
		self._latestOccupiedList = list
	end
end

function SeasonModel:getLatestOccupiedListAndClear()
	self._latestOccupiedList = nil

	return self._latestOccupiedList
end

function SeasonModel:updateOneMapEventInfo(id, params)
	if id ~= nil then
		self:setMapInfoIfEmptyGrid(id)

		local mo = self:getMapInfoById(id)

		mo:updateEventInfo(params)
	end
end

function SeasonModel:setMapInfoIfEmptyGrid(id, bNeedInitServerData)
	if not self._mapInfo[id] then
		local mapMo = SeasonMapDataMO.New()

		self._mapInfo[id] = mapMo

		if bNeedInitServerData then
			mapMo:setGridIdAndInit(id)
		else
			mapMo:setGridId(id)
		end
	end

	if bNeedInitServerData and self._cacheReqMap then
		self._cacheReqMap[id] = nil
	end
end

function SeasonModel:setMapInfoFogState(id, state)
	local mapMo = self:getMapInfoById(id)

	if mapMo then
		mapMo:updateFogState(state)
	end

	GlobalDispatcher:dispatch(GlobalNotify.SeasonFogStateUpdated, id)
end

function SeasonModel:setMapInfoDanceLionState(id, unlockedPointId)
	local mapMo = self:getMapInfoById(id)

	if mapMo then
		mapMo:updateDanceLionState(unlockedPointId)
	end

	GlobalDispatcher:dispatch(GlobalNotify.SeasonDanceLionUpdated, id)
end

function SeasonModel:getAllMapInfo()
	return self._mapInfo
end

function SeasonModel:getMapInfoById(id)
	self:setMapInfoIfEmptyGrid(id)

	return self._mapInfo[id]
end

function SeasonModel:updatePathGridDataOccupied()
	if self._mapInfo then
		for id, mo in pairs(self._mapInfo) do
			local isOccupied = mo:isOccupied()

			SeasonPathFindingDataModel.instance:setPathDataGridCanMoveById(id, isOccupied, mo:getFindWayWeight())
		end
	end
end

function SeasonModel:isOccupied(id)
	local mo = self:getMapInfoById(id)

	if mo then
		return mo:isOccupied()
	end
end

function SeasonModel:setOccupied(id)
	local mo = self:getMapInfoById(id)

	self:setMapInfoIfEmptyGrid(id)

	if mo then
		mo:_setOccupied(true)
		SeasonPathFindingDataModel.instance:setPathDataGridCanMoveById(id, mo:isOccupied(), mo:getFindWayWeight())
	end

	local configInstance = SeasonConfig.instance
	local evtConfig = configInstance:getMapEvtTypeAndId(self:getSeasonId(), id)

	if evtConfig then
		local fogObjIds = string.splitToNumber(evtConfig.fogObjIds or "", ",")

		for _, linkElementId in ipairs(fogObjIds) do
			local linkGrid = SeasonPathFindingDataModel.instance:getGridIdByElementId(linkElementId)

			self:setMapInfoFogState(linkGrid, SeasonMapDataMO.Fog_Without)
		end
	end

	GlobalDispatcher:dispatch(GlobalNotify.SeasonOccupiedGrid, id)
end

function SeasonModel:isMark(id)
	local mapMo = self._mapInfo[id]

	if mapMo then
		return mapMo:isMark()
	end
end

function SeasonModel:setMarkState(id, value)
	local mapMo = self._mapInfo[id]

	if mapMo then
		mapMo:_setMarkState(value)
	end

	GlobalDispatcher:dispatch(GlobalNotify.SeasonMarkGrid, id, value)
end

function SeasonModel:_updateOneMapWeight(id)
	return
end

function SeasonModel:handleSeasonInfoData(msg)
	local data = {}

	data.seasonId = msg.seasonId
	data.isFirstTime = msg.isFirstTime
	data.gamePercent = msg.gamePercent
	data.isFinish = msg.isFinish
	data.emakiFragmentIds = GameUtil.pbToTable(msg.emakiFragmentIds) or {}
	data.rank = msg.rank
	data.gameMode = msg.gameMode
	data.teammateIsFinish = checkbool(msg.teammateIsFinish)
	data.teamate = msg.teamate
	data.occupied = {}

	for _, v in ipairs(msg.occupied) do
		data.occupied[v.level] = v.num
	end

	local receiveArray = string.split(msg.alreadyGainKeyPrize, "#")
	local receiveMap = {}

	for _, v in pairs(receiveArray) do
		receiveMap[v] = true
	end

	data.nowFragmentNum = 0

	for _, v in ipairs(data.emakiFragmentIds) do
		data.nowFragmentNum = data.nowFragmentNum + 1
	end

	data.maxFragmentNum = 0

	local cfg = SeasonConfig.instance:getSeasonFragmentConfigBySeasonId(data.seasonId)

	for _, v in pairs(cfg) do
		data.maxFragmentNum = data.maxFragmentNum + 1
	end

	data.rewardData = {}

	local rewardCfg = SeasonConfig.instance:getSeasonModeMainRewardBySeasonId(data.seasonId)

	if rewardCfg then
		local prizeArray = string.split(rewardCfg.keyPrize, "#")

		for _, v in pairs(prizeArray) do
			if not string.nilorempty(v) then
				local param = {}

				param.reward = v
				param.isReceive = receiveMap[v]

				table.insert(data.rewardData, param)
			end
		end
	end

	data.seasonModeCfg = SeasonConfig.instance:getSeasonConfigBySeasonId(data.seasonId)
	self._seasonInfoDataMap = self._seasonInfoDataMap or {}
	self._seasonInfoDataMap[data.seasonId] = data

	GlobalDispatcher:dispatch(GlobalNotify.SeasonInfoUpdate)
end

function SeasonModel:getSeasonInfoData(seasonId)
	return self._seasonInfoDataMap[seasonId]
end

function SeasonModel:addFragment(seasonId, fragmentId)
	local data = self:getSeasonInfoData(seasonId)

	if data then
		local value = table.indexof(data.emakiFragmentIds, fragmentId)

		if not value then
			table.insert(data.emakiFragmentIds, fragmentId)
		end

		data.nowFragmentNum = data.nowFragmentNum + 1
		self._seasonInfoDataMap[data.seasonId] = data
	end
end

function SeasonModel:handleAllFragment(msg)
	local infos = msg.infos

	self._seasonFragmentMap = self._seasonFragmentMap or {}

	for i, v in ipairs(infos) do
		local seasonId = v.seasonId

		self._seasonFragmentMap[seasonId] = v
	end

	GlobalDispatcher:dispatch(GlobalNotify.SeasonFragmentUpdate)
end

function SeasonModel:getFragmentInfo(seasonId)
	return self._seasonFragmentMap[seasonId]
end

function SeasonModel:handleFindKeyInfo(msg)
	local infos = GameUtil.pbToTable(msg)

	self._seasonFindKey = {}

	if infos.findKey then
		for i, v in ipairs(infos.findKey) do
			self._seasonFindKey[v.keyGroupId] = v.teamId
		end
	end
end

function SeasonModel:isGetKeyTeam(keyGroupId, teamId)
	if self._seasonFindKey[keyGroupId] and self._seasonFindKey[keyGroupId] == teamId then
		return true
	end

	return false
end

function SeasonModel:isGetKey(keyGroupId)
	if self._seasonFindKey[keyGroupId] then
		return true
	end

	return false
end

function SeasonModel:getGainKeyTeam(keyGroupId)
	return self._seasonFindKey[keyGroupId]
end

function SeasonModel:handleMapBuffInfo(msg)
	local infos = msg.mapBuffs

	self._mapBuffInfo = {}

	for i, v in ipairs(infos) do
		if v.teamId then
			self._mapBuffInfo[v.teamId] = self._mapBuffInfo[v.teamId] or {}

			if checknumber(v.num) > 0 then
				table.insert(self._mapBuffInfo[v.teamId], v)
			end
		else
			self._mapBuffInfo.total = self._mapBuffInfo.total or {}

			if checknumber(v.num) > 0 then
				table.insert(self._mapBuffInfo.total, v)
			end
		end
	end
end

function SeasonModel:getMapBuffInfoByTeam(teamId)
	if self._mapBuffInfo then
		return self._mapBuffInfo[teamId] or {}
	end

	return {}
end

function SeasonModel:getTotalMapBuffInfo()
	if self._mapBuffInfo then
		return self._mapBuffInfo.total or {}
	end

	return {}
end

function SeasonModel:handleGroupInfoAndState(msg)
	self._groupState = msg.state
	self._groupInfo = msg.groupInfo
end

function SeasonModel:handleGroupInfo(groupInfo)
	self._groupInfo = groupInfo
end

function SeasonModel:handleGroupState(state)
	self._groupState = state
end

function SeasonModel:getGroupState()
	return checknumber(self._groupState)
end

function SeasonModel:getGroupInfo()
	return self._groupInfo
end

function SeasonModel:handleGroupInviteList(msg)
	self._groupInviteList = GameUtil.pbToTable(msg.inviteList) or {}
end

function SeasonModel:getGroupInviteList()
	return self._groupInviteList
end

function SeasonModel:clearGroupInviteList()
	self._groupInviteList = nil
end

function SeasonModel:handleTeammateInfo(msg)
	self._shareMaterialPackage = msg.shareMaterialPackage
	self.teammateId = RoleModel.instance:getUserId() == msg.memberUserId and msg.captainUserId or msg.memberUserId
end

function SeasonModel:getTeammateId()
	return checknumber(self.teammateId)
end

function SeasonModel:handleShareMaterial(msg)
	self._shareMaterialPackage = msg.shareMaterialPackage
end

function SeasonModel:getShareMaterialPackage()
	return self._shareMaterialPackage
end

SeasonModel.instance = SeasonModel.New()

return SeasonModel
