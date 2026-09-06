-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/controller/SeasonController.lua

module("logic.extensions.season.controller.SeasonController", package.seeall)

local SeasonController = class("SeasonController", BaseController)

SeasonController.RefreshViewData = "SeasonController.RefreshViewData"

function SeasonController:onInit()
	GlobalDispatcher:addListener(GlobalNotify.SeasonTeamClientPosUpdated, self._onClientLeaderPosChanged, self)
	GlobalDispatcher:addListener(GMAgent.PM_SeasonModePveMapJumpRes, self._onGMSetPos, self)
	GlobalDispatcher:addListener(GlobalNotify.SceneLoaded, self._onSceneLoadedFinish, self)
	GlobalDispatcher:addListener("guide_show_season_boss_first", self._onShowFirstBossAni, self)
	GlobalDispatcher:addListener(GlobalNotify.SeasonFirstEnterBossShowAnimDone, self._onShowFirstBossAniEnd, self)
	GlobalDispatcher:addListener(GlobalNotify.SeasonSelectGrid, self._onSelectGrid, self)
	GlobalDispatcher:addListener("enter_season_scene", self._onEnterSeasonScene, self)
	GlobalDispatcher:addListener(GlobalNotify.FriendInfoGeted, self._onGetFriendInfos, self)
	self:onReset()
end

function SeasonController:onReset()
	self._seasonSceneId = 0
	self._cacheSettingTeamId = 0
	self._gridOpContainer = nil
	self._viewPresentor = nil
	self._cacheMarkState = nil
	self._cacheSettingMarkPositionIds = {}
	self._maxRequestingMapPointOffset = 0
	self._requestingMapPointOffset = 0
	self._cacheSendGetEventInfoId = 0
	self._recentlyUnlockedFogsGridId = 0
	self._isMinimapOpened = false
	self.cameraPosList = {}
	self.curCameraIndex = 1
	self._isNeedRequestAll = false
	self._shouldShowPetIds = nil

	removetimer(self._stepReqAllMapInfo, self)
	removetimer(self._checkNeedReqAgain, self)
	SeasonPVEBossStoryHandler.instance:reset()
	removetimer(self._dispatchApplySeasonPlayOccupiedEffect, self)

	self._sendCdIds = {}
	self._beInvateMsgs = {}
	self._needBeInvateOnGetFriendMos = nil
	self.msgMap = {}
	self.msgCdMap = {}
end

function SeasonController:setOpViewContainer(container, presentor)
	self._gridOpContainer = container
	self._viewPresentor = presentor
end

function SeasonController:_onSelectGrid(gridX, gridY)
	if not self._gridOpContainer or not self._viewPresentor then
		return
	end

	local data = SeasonPathFindingDataModel.instance
	local id = data:grid2Id(gridX, gridY)
	local teamModel = SeasonTeamsModel.instance
	local teamId = teamModel:getCurrTeamId()
	local teamMo = teamModel:getTeam(teamId)
	local x1, y1 = teamMo:getClientCurGridXY()
	local boo, dir = SeasonOpHandler.instance:checkIsOnALine(x1, y1, gridX, gridY)

	printError(">>>>>>>>>>>>>>>>>>>>>>SeasonController checkIsOnALine", x1, y1, gridX, gridY, dir)

	local scene = SceneMgr.instance:getCurScene()

	if scene and scene.gridUnitsMgr and scene.gridUnitsMgr:isAimmingGrid() then
		local isGridWalkable = data:isGridWalkable(gridX, gridY)

		if isGridWalkable then
			local teamModel = SeasonTeamsModel.instance
			local teamId = teamModel:getCurrTeamId()
			local teamMo = teamModel:getTeam(teamId)

			TipsFacade.instance:openSeasonPopupWindow(lang("tip"), langPara("确定选择当前位置作为<color=#f1c0a6>%s</color>的目标位置吗？", teamMo.teamName), function()
				scene.gridUnitsMgr:aimGrid(false)
				SeasonTeamsModel.instance:setTeamAimingId(teamMo.teamId, id)

				local transUnit = scene.leaders:getTeamUnit(teamId)

				if transUnit then
					scene.navigatePath:navigateUnit(transUnit)
				end
			end, function()
				scene.gridUnitsMgr:aimGrid(false)
				SeasonTeamsModel.instance:setTeamAimingId(teamMo.teamId, -1)
			end)
		else
			TipsFacade.instance:openCommonTips(lang("该位置不能设置为目标"))
		end

		return
	end

	printInfo("SeasonMainView:_onSelectGrid....................", gridX, gridY, id)

	if not SeasonModel.instance:isOpViewShowing(gridX, gridY) then
		self:closeOperateView()

		local opTypes = SeasonGridEvtModel.instance:getOpGroups(id)

		if opTypes and #opTypes > 0 then
			ViewMgr.instance:openAt(self._gridOpContainer, ViewName.SeasonSceneOperateView, self._viewPresentor, opTypes, gridX, gridY, id)
		end
	end

	GlobalDispatcher:dispatch(GlobalNotify.SeasonSelectGrid_R_C, gridX, gridY)
end

function SeasonController:closeOperateView()
	ViewMgr.instance:close(ViewName.SeasonSceneOperateView)
end

function SeasonController:_onEnterSeasonScene()
	if SeasonModel.instance:getGroupState() ~= SeasonModel.GVE_GROUP_STATE_PVE and SeasonModel.instance:getGroupState() ~= SeasonModel.GVE_GROUP_STATE_GVE then
		GotoMgr.gotoByString("func#725")
	elseif self:getSceneSceneId() == 0 then
		self:enterSeasonTilingScene()
	end
end

function SeasonController:recordRecentlyUnlockedFogsGrid(gridId)
	self._recentlyUnlockedFogsGridId = gridId
end

function SeasonController:getRecentlyUnlockedFogsGrid()
	return self._recentlyUnlockedFogsGridId
end

function SeasonController:changeFocusTeam(teamId)
	self._cacheSettingTeamId = teamId

	SeasonModePveAgent.instance:sendPM_SMPVESwitchCurTeamReq(teamId)
end

function SeasonController:setMinimapOpened(opened)
	if self._isMinimapOpened ~= opened then
		self._isMinimapOpened = opened

		GlobalDispatcher:dispatch(GlobalNotify.SeasonMinimapOpenedOrClosed, opened)
	end
end

function SeasonController:isMinimapOpened()
	return self._isMinimapOpened
end

function SeasonController:setSceneSceneId(seasonSceneId)
	self._seasonSceneId = seasonSceneId

	if checknumber(seasonSceneId) == 0 then
		-- block empty
	end
end

function SeasonController:getSceneSceneId()
	return self._seasonSceneId
end

function SeasonController:enterSeasonTilingScene()
	local scene = SceneMgr.instance:getCurScene()

	if scene and scene:getSceneType() == SceneType.SeasonTiling then
		return
	end

	local seasonId = SeasonModel.instance:getSeasonId()
	local mapJson = SeasonConfig.instance:getMapJson(seasonId)

	SeasonPathFindingDataModel.instance:reload(mapJson)
	SeasonModel.instance:beforeEnter()
	SeasonPVEBossStoryHandler.instance:reset()
	SeasonEvtHandler.instance:reset()
	SeasonPVEBossController.instance:initConfig()
	SeasonTeamsModel.instance:clearAllFmtData()

	self._isNeedRequestAll = true

	local cfg = SeasonConfig.instance:getSeasonConfigBySeasonId(seasonId)

	TilingSceneMgr.instance:enterSeasonTilingScene(cfg.mapDataName or "season_scene")
end

function SeasonController:_preloadDataBeforeEnterScene()
	if self._isNeedRequestAll then
		self._isNeedRequestAll = false

		SeasonModePveAgent.instance:sendPM_SMPVEInitMapReq()
		SeasonModePveAgent.instance:sendPM_SMPVETeamStrengthInfoReq()
		SeasonModePveTeamAgent.instance:sendPM_SMPVEPetChangeTipInfoReq()
		SeasonModePveAgent.instance:sendPM_SMPVECalPetStrengthInfoReq()

		if SeasonModel.instance:getGroupState() == SeasonModel.GVE_GROUP_STATE_GVE then
			SeasonModePvePlusAgent.instance:sendPM_SMGVETeammateTeamInfoReq()
		end

		self:_startReqAllMapInfo()
	else
		printInfo("......................TTTTTT2..", SeasonModel.instance:isLoadAllMapServerInfo())
		SeasonPVEBossController.instance:doCheckLogic()
	end
end

function SeasonController:_onShowFirstBossAni()
	local scene = SceneMgr.instance:getCurScene()

	if scene and scene.eventsAnimation and scene.eventsAnimation.playEnterBossShow then
		scene.eventsAnimation:playEnterBossShow()
	end
end

function SeasonController:_onShowFirstBossAniEnd()
	if self._shouldShowPetIds and #self._shouldShowPetIds > 0 then
		local list = self._shouldShowPetIds

		self._shouldShowPetIds = nil

		UIStateManager.instance:push(ViewName.SeasoncampaignpetView, list)
	end

	GuideController.instance:finishGuide()
end

function SeasonController:_onSceneLoadedFinish(sceneType, sceneId)
	if self._seasonSceneId == sceneId then
		self:_preloadDataBeforeEnterScene()
	end
end

function SeasonController:leaveSeasonTilingScene()
	self:recordRecentlyUnlockedFogsGrid(0)

	if self._seasonSceneId ~= 0 then
		SceneStatusMgr.instance:popStatus(ViewName.MainUI)
		TilingSceneMgr.instance:clearTilingSceneConfig(self._seasonSceneId)

		self._seasonSceneId = 0
	end
end

function SeasonController:applyClientMoveTo(gridX, gridY)
	if self._seasonSceneId ~= 0 then
		local scene = SceneMgr.instance:getCurScene()
		local gridId = SeasonPathFindingDataModel.instance:grid2Id(gridX, gridY)
		local teamModel = SeasonTeamsModel.instance
		local teamMo = teamModel:getCurrTeamMo()
		local teamX, teamY = teamMo:getClientCurGridXY()
		local pathList = SeasonPathFindingDataModel.instance:getPathByOccupied(teamX, teamY, gridX, gridY)

		if pathList and #pathList >= 20 then
			local req = SeasonModePveExtension_pb.PM_SMPVEPathRouterMoveReq()

			req.teamId = teamModel:getCurrTeamId()

			local mapMo = SeasonModel.instance:getMapInfoById(gridId)
			local isNeedNextMove = false

			if not mapMo:isOccupied() then
				local seasonId = SeasonModel.instance:getSeasonId()
				local evtConfig = SeasonConfig.instance:getMapEvtTypeAndId(seasonId, gridId)

				if evtConfig then
					isNeedNextMove = true
				end
			end

			for j = 1, (isNeedNextMove or nil) and #pathList - 2, 2 do
				req.pathPointIds:append(SeasonPathFindingDataModel.instance:grid2Id(pathList[j], pathList[j + 1]))
			end

			if isNeedNextMove then
				teamMo:setLongPathRouterMoveTargetId(SeasonPathFindingDataModel.instance:grid2Id(pathList[#pathList - 1], pathList[#pathList]))
			end

			SeasonModePveAgent.instance:sendPM_SMPVEPathRouterMoveReq(req)

			return
		end

		if scene and scene.picker and scene.picker.realOnQueryFindWay then
			local teamX, teamY = -1, -1
			local unit = scene.picker._mainPlayer

			if unit and unit.teamData then
				local teamMo = unit.teamData

				teamX, teamY = teamMo:getClientCurGridXY()
			end

			if unit and teamX == gridX and teamY == gridY then
				self:_onClientLeaderPosChanged(unit, gridX, gridY, false)
			elseif not SeasonOpHandler.instance:checkCanMoveAndShowTips(gridId) then
				SeasonAutoFightController.instance:stopAutoFight()
			else
				scene.picker:realOnQueryFindWay(gridX, gridY)
			end
		end
	end
end

function SeasonController:isGridNearBy(fromGridX, fromGridY, targetGridX, targetGridY)
	if self._seasonSceneId ~= 0 then
		local scene = SceneMgr.instance:getCurScene()

		if scene and scene.pathFinder and scene.pathFinder.isGridNearBy then
			return scene.pathFinder:isGridNearBy(fromGridX, fromGridY, targetGridX, targetGridY)
		end
	end
end

function SeasonController:isInMoveRange(fromGridX, fromGridY, targetGridX, targetGridY, range)
	if self._seasonSceneId ~= 0 then
		local scene = SceneMgr.instance:getCurScene()

		if scene and scene.pathFinder and scene.pathFinder.isInMoveRange then
			return scene.pathFinder:isInMoveRange(fromGridX, fromGridY, targetGridX, targetGridY, range)
		end
	end
end

function SeasonController:isNeighbourAndPassable(fromGridX, fromGridY, targetGridX, targetGridY)
	if self._seasonSceneId ~= 0 then
		local scene = SceneMgr.instance:getCurScene()

		if scene and scene.pathFinder and scene.pathFinder.isPassable then
			return scene.pathFinder:isNeighbourAndPassable(fromGridX, fromGridY, targetGridX, targetGridY)
		end
	end
end

function SeasonController:updatePathGridDataOccupied(pathFindingGridDataOccupied)
	SeasonModel.instance:updatePathGridDataOccupied(pathFindingGridDataOccupied)
end

function SeasonController:checkIfCanMoveByOccupied(gridStartX, gridStartY, gridEndX, gridEndY)
	if SeasonPathFindingDataModel.instance:isGridWalkable(gridEndX, gridEndY) then
		if self:isInMoveRange(gridStartX, gridStartY, gridEndX, gridEndY, 1) then
			return true, nil
		else
			local pathList = SeasonPathFindingDataModel.instance:getPathByOccupied(gridStartX, gridStartY, gridEndX, gridEndY)

			if pathList and #pathList > 0 then
				return true, pathList
			end

			return false, nil
		end
	else
		return false, nil
	end
end

function SeasonController:trySetMark(ids, markState)
	local markPointIds = SeasonModel.instance:getMarkPoints()

	if markState and #markPointIds + #ids > 99 then
		TipsFacade.instance:openCommonTips(lang("您的标记数量已达上限，可以取消部分再进行标记"))
	else
		self._cacheMarkState = markState
		self._cacheSettingMarkPositionIds = ids

		SeasonModePveAgent.instance:sendPM_SMPVEMarkMapPointReq(ids, markState)
	end
end

function SeasonController:_onClientLeaderPosChanged(unit, gridX, gridY, isSetPosDirectly)
	if self._seasonSceneId ~= 0 and unit and unit.teamData then
		local teamMo = unit.teamData
		local teamModel = SeasonTeamsModel.instance
		local evtModel = SeasonGridEvtModel.instance

		teamMo:clearRollbackData()

		local id = SeasonPathFindingDataModel.instance:grid2Id(gridX, gridY)
		local mapMo = SeasonModel.instance:getMapInfoById(id)

		if mapMo and mapMo:isInitServerData() and mapMo:isLock() then
			return
		end

		printInfo("SeasonController:_onClientLeaderPosChanged...................", teamMo.teamId, id)
		teamModel:traceTeamClientGridPos(teamMo.teamId, id)

		if isSetPosDirectly then
			return
		end

		if evtModel:isGridCanDoEvent(teamMo, id) then
			printInfo("client trigger evt...................", id)
			SeasonEvtHandler.instance:handleEvtByClient(teamMo.teamId, gridX, gridY)
		elseif not teamMo:isClientServerPosSame() then
			SeasonModePveAgent.instance:sendPM_SMPVETeamMoveReq(teamMo.teamId, id)
		else
			local seasonId = SeasonModel.instance:getSeasonId()
			local evtConfig = SeasonConfig.instance:getMapEvtTypeAndId(seasonId, id)

			if SeasonGridEvtModel.instance:checkIsCanStanDoing(evtConfig) then
				SeasonModePveAgent.instance:sendPM_SMPVETeamMoveReq(teamMo.teamId, id)
			end
		end
	end
end

function SeasonController:_onGMSetPos(status, msg)
	if status == 0 then
		local targetPointId = msg.targetPointId
		local teamId = msg.teamId
		local teamModel = SeasonTeamsModel.instance
		local teamMo = teamModel:getTeam(teamId)

		if teamMo then
			teamMo:gmSetPosition(targetPointId)
		end

		local scene = SceneMgr.instance:getCurScene()

		if scene and scene.leaders then
			scene.leaders:tryDepartTeamsPos()
		end
	end
end

function SeasonController:onServerTriggerEvt(msg)
	printInfo("server trigger evt...................", msg.targetPointId)

	local isNeedSetPos = true

	if not string.nilorempty(msg.resultParam) then
		local resultJson = GameUtil.jsonToTable(msg.resultParam)

		if resultJson and resultJson.team_pos ~= nil then
			isNeedSetPos = false
		end
	end

	if SeasonGridEvtModel.instance:isGridIsTransportLink(msg.targetPointId, msg.curPointId) then
		printInfo("SeasonController:onServerTriggerEvt............onServerLeaderPosChanged with no dispatch")

		if isNeedSetPos then
			self:onServerLeaderPosChanged(msg.teamId, msg.curPointId, true)
		end

		local req = SeasonModePveExtension_pb.PM_SMPVELoadMapInfoReq()

		req.pointIds:append(msg.targetPointId)
		req.pointIds:append(msg.curPointId)
		SeasonModePveAgent.instance:sendPM_SMPVELoadMapInfoReq(req)
	elseif isNeedSetPos then
		self:onServerLeaderPosChanged(msg.teamId, msg.curPointId)
	end

	SeasonEvtHandler.instance:handleEvtByServer(msg)
end

function SeasonController:onServerTriggerEvtFailed()
	local teamModel = SeasonTeamsModel.instance
	local teamId = teamModel:getCurrTeamId()
	local teamMo = teamModel:getTeam(teamId)

	if teamMo then
		if teamMo.clientCurGridId ~= nil then
			SeasonEvtHandler.instance:handleEvtByServerFail(teamMo.clientCurGridId)
		end

		teamMo:backSetPosition()

		local scene = SceneMgr.instance:getCurScene()

		if scene and scene.leaders then
			scene.leaders:tryDepartTeamsPos()
		end
	end

	SeasonAutoFightController.instance:stopAutoFight()
end

function SeasonController:onServerLeaderPosChanged(teamId, id, isIgnoreDispatch)
	SeasonTeamsModel.instance:syncTeamServerGridPos(teamId, id, isIgnoreDispatch)

	local scene = SceneMgr.instance:getCurScene()

	if scene and scene.leaders then
		scene.leaders:tryDepartTeamsPos()
	end

	SeasonPVEBossController.instance:checkNextPhase()
	SeasonPVEBossController.instance:checkDoppelgangerPopup(teamId, id)
end

function SeasonController:_startReqAllMapInfo()
	if self._seasonSceneId ~= 0 then
		local rows, cols = SeasonPathFindingDataModel.instance:getSceneGridsDimension()

		self._requestingMapPointOffset = 0
		self._maxRequestingMapPointOffset = rows * cols - 1

		local map = {}

		for i = 0, self._maxRequestingMapPointOffset do
			map[i] = true
		end

		SeasonModel.instance:setReqMapInfoRecordMap(map)
		self:_stepReqAllMapInfo()
	end
end

function SeasonController:_stepReqAllMapInfo()
	removetimer(self._stepReqAllMapInfo, self)
	removetimer(self._checkNeedReqAgain, self)

	local req = SeasonModePveExtension_pb.PM_SMPVELoadMapInfoReq()
	local length = 0
	local bDone = false
	local seasonModel = SeasonModel.instance
	local gridsData = SeasonPathFindingDataModel.instance:getSceneGridsData()

	while length < 300 do
		if self._requestingMapPointOffset > self._maxRequestingMapPointOffset then
			bDone = true

			break
		end

		if gridsData[self._requestingMapPointOffset + 1] > 0 then
			length = length + 1

			req.pointIds:append(self._requestingMapPointOffset)
		else
			seasonModel:setMapInfoIfEmptyGrid(self._requestingMapPointOffset, true)
		end

		self._requestingMapPointOffset = self._requestingMapPointOffset + 1
	end

	if length > 0 then
		SeasonModePveAgent.instance:sendPM_SMPVELoadMapInfoReq(req)
	end

	if not bDone then
		settimer(0.1, self._stepReqAllMapInfo, self, false)
	else
		settimer(1, self._checkNeedReqAgain, self, false)
	end
end

function SeasonController:reqSingleMapInfo(ids)
	local req = SeasonModePveExtension_pb.PM_SMPVELoadMapInfoReq()
	local maxCount = math.min(10, #ids)

	if maxCount > 0 then
		for i = 1, maxCount do
			local id = ids[i]

			req.pointIds:append(id)
		end

		SeasonModePveAgent.instance:sendPM_SMPVELoadMapInfoReq(req)
	end
end

function SeasonController:_checkNeedReqAgain()
	SeasonModel.instance:testPrintInfo()
end

function SeasonController:moveCaremaFromTeamToGridList(teamMo, list, isBack)
	local posList = {}
	local teamX, teamY = teamMo:getClientCurGridXY()
	local lastX, lastY = teamX, teamY

	for i, v in ipairs(list) do
		local obj = {}

		obj.fromX = lastX
		obj.fromY = lastY
		obj.toX = v.x
		obj.toY = v.y
		lastX = v.x
		lastY = v.y

		table.insert(posList, obj)
	end

	if isBack then
		local obj = {}

		obj.fromX = lastX
		obj.fromY = lastY
		obj.toX = teamX
		obj.toY = teamY

		table.insert(posList, obj)
	end

	self.cameraPosList = posList
	self.curCameraIndex = 1

	self:_startMoveCameraList()
end

function SeasonController:_startMoveCameraList()
	local obj = self.cameraPosList[self.curCameraIndex]

	self.curCameraIndex = self.curCameraIndex + 1

	local scene = SceneMgr.instance:getCurScene()

	if obj and scene and scene.eventsAnimation then
		self._lastRcdX, self._lastRcdY = obj.toX, obj.toY

		scene.eventsAnimation:playCamera2Grid(obj.toX, obj.toY, GameUtil.handler(self._startMoveCameraList, self))
		GlobalDispatcher:dispatch(GlobalNotify.SeasonSelectGrid_R_C, self._lastRcdX, self._lastRcdY)
	elseif self._lastRcdX and self._lastRcdY then
		GlobalDispatcher:dispatch(GlobalNotify.SeasonSelectGrid, self._lastRcdX, self._lastRcdY)

		self._lastRcdX, self._lastRcdY = nil
	end
end

function SeasonController:handleSMPVEInitMapRes(status, msg)
	if status == 0 then
		SeasonModel.instance:handleInit(msg)
		SeasonTeamsModel.instance:onSetAllTeamMapInfo(msg)
		GlobalDispatcher:dispatch(GlobalNotify.SeasonPVEDataUpdated)
		self:changeFocusTeam(SeasonTeamsModel.instance:getCurrTeamId())
		GuideController.instance:setViewVar("scene_season_id", SeasonModel.instance:getSeasonId())
	end
end

function SeasonController:handleSMPVELoadMapInfoRes(status, msg)
	if status == 0 then
		SeasonModel.instance:updateMapInfo(msg)
		GlobalDispatcher:dispatch(GlobalNotify.SeasonMapInfoUpdate)
		SeasonPVEBossController.instance:doCheckLogic()
	end
end

function SeasonController:handleSMPVENotifyPointOccupiedRes(status, msg)
	if status == 0 then
		SeasonModel.instance:updatePointsOccupiedInfo(msg)

		if msg.state == 2 then
			SeasonTeamsModel.instance:onServerTeammateTeamMapInfo(msg.teammateInfo)
			SeasonModel.instance:handleShareMaterial(msg)
			self:onServerLeaderPosChanged(msg.teammateInfo.teamId + SeasonTeamsModel.TeammateAddTeamId, nil, true)
			GlobalDispatcher:dispatch(GlobalNotify.SeasonServerAddTeam)

			if msg.medalId then
				SeasonModePveAgent.instance:sendPM_SMPVEGetBudgeInfoReq()
			end
		end

		GlobalDispatcher:dispatch(GlobalNotify.SeasonMapInfoUpdate)
		removetimer(self._dispatchApplySeasonPlayOccupiedEffect, self)
		settimer(0.1, self._dispatchApplySeasonPlayOccupiedEffect, self, false)
	end
end

function SeasonController:handlePM_SMPVENotifyTeammateMoveRes(status, msg)
	if status == 0 then
		for i, teammateInfo in ipairs(msg.teammateInfo) do
			SeasonTeamsModel.instance:onServerTeammateTeamMapInfo(teammateInfo)
			self:onServerLeaderPosChanged(teammateInfo.teamId + SeasonTeamsModel.TeammateAddTeamId, nil, true)
		end

		GlobalDispatcher:dispatch(GlobalNotify.SeasonServerAddTeam)
	end
end

function SeasonController:_dispatchApplySeasonPlayOccupiedEffect()
	removetimer(self._dispatchApplySeasonPlayOccupiedEffect, self)
	GlobalDispatcher:dispatch(GlobalNotify.ApplySeasonPlayOccupiedEffect)
end

function SeasonController:handleSMPVESwitchCurTeamRes(status, msg)
	if status == 0 then
		SeasonTeamsModel.instance:setCurrTeamId(self._cacheSettingTeamId)
		GlobalDispatcher:dispatch(GlobalNotify.ChangeFocusTeam, self._cacheSettingTeamId)

		self._cacheSettingTeamId = 0
	end
end

function SeasonController:handleSMPVETeamMoveRes(status, msg)
	if status == 0 then
		self:onServerLeaderPosChanged(msg.teamId, msg.curPointId)
	end
end

function SeasonController:handleSMPVEPathRouterMoveRes(status, msg)
	local teamModel = SeasonTeamsModel.instance

	if status == 0 then
		local scene = SceneMgr.instance:getCurScene()
		local teamMo = teamModel:getTeam(msg.teamId)
		local fromGridX, fromGridY = teamMo:getClientCurGridXY()
		local toGridX, toGridY = SeasonPathFindingDataModel.instance:id2Grid(msg.curPointId)

		local function doNextMove()
			if teamMo:getLongPathRouterMoveTargetId() ~= nil then
				local targetGridX, targetGridY = SeasonPathFindingDataModel.instance:id2Grid(teamMo:getLongPathRouterMoveTargetId())

				if teamMo and teamMo:getLongPathRouterMoveTargetId() ~= nil then
					self:applyClientMoveTo(targetGridX, targetGridY)
					teamMo:clearLongPathRouterMoveTargetId()
				end
			end
		end

		if scene and scene.eventsAnimation then
			teamMo:setStartTransport(teamMo:getLongPathRouterMoveTargetId())
			scene.eventsAnimation:transmitGrid2Grid(msg.teamId, fromGridX, fromGridY, toGridX, toGridY, function()
				teamMo:clearTransport()
				teamModel:traceTeamClientGridPos(msg.teamId, msg.curPointId)
				self:onServerLeaderPosChanged(msg.teamId, msg.curPointId, true)

				if scene and scene.leaders then
					scene.leaders:tryDepartTeamsPos()
				end

				doNextMove()
			end)
		else
			self:onServerLeaderPosChanged(msg.teamId, msg.curPointId, true)

			if scene and scene.leaders then
				scene.leaders:tryDepartTeamsPos()
			end
		end
	else
		local teamMo = teamModel:getCurrTeamMo()

		if teamMo then
			teamMo:clearLongPathRouterMoveTargetId()
		end
	end
end

function SeasonController:handleSMPVEHandleEventRes(status, msg)
	if status == 0 then
		self:onServerTriggerEvt(msg)
	else
		self:onServerTriggerEvtFailed(msg)
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function SeasonController:handleSMPVEMarkMapPointRes(status, msg)
	if status == 0 then
		local seasonModel = SeasonModel.instance

		seasonModel:appendMarkPoints(self._cacheSettingMarkPositionIds, self._cacheMarkState)

		for i = 1, #self._cacheSettingMarkPositionIds do
			seasonModel:setMarkState(self._cacheSettingMarkPositionIds[i], self._cacheMarkState)
		end
	end
end

function SeasonController:sendGetEventInfoById(id)
	self._cacheSendGetEventInfoId = id

	SeasonModePveAgent.instance:sendPM_SMPVEEventInfoReq(id)
end

function SeasonController:handleSMPVEEventInfoRes(status, msg)
	if status == 0 then
		SeasonModel.instance:updateOneMapEventInfo(self._cacheSendGetEventInfoId, msg)
		GlobalDispatcher:dispatch(GlobalNotify.SeasonMapEventInfoUpdate)
	end
end

function SeasonController:handleSMPVETeamStrengthInfoRes(status, msg)
	if status == 0 then
		SeasonTeamsModel.instance:onSetAllTeamStrengthInfo(msg)
	end
end

function SeasonController:handleNotifySMPVEStrengthChangeRes(status, msg)
	if status == 0 then
		SeasonTeamsModel.instance:onSetSingleStrengthInfo(msg.change)
		GlobalDispatcher:dispatch(GlobalNotify.SeasonStrengInfoUpdate)
	end
end

function SeasonController:sendGetAllTeamInfo()
	SeasonModePveTeamAgent.instance:sendPM_GetSMPVEAllTeamInfoReq()
end

function SeasonController:handleGetSMPVEAllTeamInfoRes(status, msg)
	if status == 0 then
		SeasonTeamsModel.instance:onSetAllTeamFmtInfo(msg)
		GlobalDispatcher:dispatch(GlobalNotify.SeasonFmtTeamInfo)
	end
end

function SeasonController:sendGetAllPetListInfo()
	SeasonModePveTeamAgent.instance:sendPM_GetSMPVECommonPetPackageReq()
end

function SeasonController:handleGetSMPVECommonPetPackageRes(status, msg)
	if status == 0 then
		SeasonPetsModel.instance:onSetAllPetInfo(msg)
		GlobalDispatcher:dispatch(GlobalNotify.SeasonFmtBagPetInfo)
	end
end

function SeasonController:sendSaveTeamBagPet(teamId, petIds)
	SeasonModePveTeamAgent.instance:sendPM_SaveSMPSinglePetPackageReq(teamId, petIds)
end

function SeasonController:handleSaveSMPSinglePetPackageRes(status, msg)
	if status == 0 then
		SeasonTeamsModel.instance:onSetSingPetInfo(msg.info)
		SeasonFmtController.instance:updateFmtMoPetList()
		GlobalDispatcher:dispatch(GlobalNotify.SeasonFmtTeamInfo)
		SeasonController.instance:sendGetAllPetListInfo()
	end
end

function SeasonController:sendResetAllTeamFmt()
	SeasonModePveTeamAgent.instance:sendPM_ResetSMPVEAllTeamInfoReq()
end

function SeasonController:handleResetSMPVEAllTeamInfoRes(status, msg)
	if status == 0 then
		SeasonTeamsModel.instance:onResetAllFmtData()
		SeasonFmtController.instance:updateFmtMoPetList()
		GlobalDispatcher:dispatch(GlobalNotify.SeasonFmtTeamInfo)
	end
end

function SeasonController:sendSaveTeamForm(teamId, formationMo)
	local req = SeasonModePveTeamExtension_pb.PM_SaveSMPVESingleTeamFormReq()

	req.teamId = teamId

	CustomFmtController.instance:createFormPb(formationMo, req.form)
	SeasonModePveTeamAgent.instance:sendPM_SaveSMPVESingleTeamFormReq(req)
end

function SeasonController:handleSaveSMPVESingleTeamFormRes(status, msg)
	if status == 0 then
		SeasonTeamsModel.instance:onResetTeamForm(msg)
		GlobalDispatcher:dispatch(GlobalNotify.SeasonFmtTeamInfo)
	end
end

function SeasonController:sendSummonPetInfo(teamId, summonMasterPetId, summonedPetId)
	self._tmpSummonerMasterId = summonMasterPetId
	self._tmpSummonedPetId = summonedPetId

	local req = SeasonModePveTeamExtension_pb.PM_SaveSMPVESingleTeamFormSummonInfoReq()

	req.teamId = teamId
	req.summonInfo.summonMasterPetId = summonMasterPetId
	req.summonInfo.summonedPetId = summonedPetId

	SeasonModePveTeamAgent.instance:sendPM_SaveSMPVESingleTeamFormSummonInfoReq(req)
end

function SeasonController:handleSaveSMPVESingleTeamFormSummonInfoRes(status, msg)
	if status == 0 then
		SeasonTeamsModel.instance:onUpdateTeamSummonInfo(msg)
		GlobalDispatcher:dispatch(GlobalNotify.PM_MakeContractRes, self._tmpSummonerMasterId, self._tmpSummonedPetId)
		GlobalDispatcher:dispatch(GlobalNotify.ForceChangeCurFormTab)
	end

	self._tmpSummonerMasterId = 0
	self._tmpSummonedPetId = 0
end

function SeasonController:sendBuyPayTime(teamId)
	SeasonModePveTeamAgent.instance:sendPM_BuySMPVEPackageTimesReq(teamId)
end

function SeasonController:handleBuySMPVEPackageTimesRes(status, msg)
	if status == 0 then
		SeasonTeamsModel.instance:onBuyPayTime(msg)
		GlobalDispatcher:dispatch(GlobalNotify.SeasonFmtBuyPayTime)
	end
end

function SeasonController:sendGetHolyStripesinfo(teamId)
	SeasonModePveTeamAgent.instance:sendPM_GetSMPVESingleTeamHolyStripesInfoReq(teamId)
end

function SeasonController:handleGetSMPVESingleTeamHolyStripesInfoRes(status, msg)
	if status == 0 then
		SeasonTeamsModel.instance:onUpdateAllTeamHolyStripesInfo(msg)
		GlobalDispatcher:dispatch(GlobalNotify.SeasonFmtHolyStripesInfo)
	end
end

function SeasonController:sendAndSetPetHolystripeInfo(teamId, raceId, holyStripesId)
	SeasonModePveTeamAgent.instance:sendPM_ChangeSMPVESinglePetHolyStripesInfoReq(teamId, raceId, holyStripesId)
end

function SeasonController:handleChangeSMPVESinglePetHolyStripesInfoRes(status, msg)
	if status == 0 then
		SeasonTeamsModel.instance:onUpdateAllTeamHolyStripesInfo(msg)
		GlobalDispatcher:dispatch(GlobalNotify.SeasonFmtHolyStripesInfo)
	end
end

function SeasonController:sendGetHirePetInfo(otherUserId)
	SeasonModePveAgent.instance:sendPM_SMPVEGetPetPalaceInfoReq(otherUserId)
end

function SeasonController:handlePM_SMPVEGetPetPalaceInfoRes(status, msg)
	if status == 0 then
		SeasonPetsModel.instance:onUpdateAllHirePetList(msg)
		GlobalDispatcher:dispatch(GlobalNotify.SeasonHirePetInfo)
	end
end

function SeasonController:sendHirePetByIdx(slotId, petDefineId)
	SeasonModePveAgent.instance:sendPM_SMPVEChangeHirePetReq(slotId, petDefineId)
end

function SeasonController:handlePM_SMPVEChangeHirePetRes(status, msg)
	if status == 0 then
		SeasonPetsModel.instance:onUpdateMyHirePetList(msg)
		GlobalDispatcher:dispatch(GlobalNotify.SeasonHirePetInfo)
	end
end

function SeasonController:sendTrainingGroupLvlup(teamId)
	SeasonModePveAgent.instance:sendPM_SMPVEUpgradeTeamLvReq(teamId)
end

function SeasonController:handlePM_SMPVEUpgradeTeamLvRes(status, msg)
	if status == 0 then
		SeasonTeamsModel.instance:onUndateTeamLv(msg)
		GlobalDispatcher:dispatch(GlobalNotify.SeasonFmtTeamInfo)
		GlobalDispatcher:dispatch(GlobalNotify.SeasonTrainingCoursePropertyEffect)
	end
end

function SeasonController:handlePM_SMPVENotifyTeamZdlChangedRes(status, msg)
	if status == 0 then
		SeasonTeamsModel.instance:updaetTeamZdl(msg)
		GlobalDispatcher:dispatch(GlobalNotify.SeasonFmtTeamInfo)
	end
end

function SeasonController:handlePM_SMPVEPetChangeTipInfoRes(status, msg)
	if status == 0 then
		local list = msg.petId

		self._shouldShowPetIds = list

		local branchId = GuideConst.BRANCH__103

		GuideController.instance:checkBranchIsFinish(branchId)

		if self._shouldShowPetIds and #self._shouldShowPetIds > 0 then
			list = self._shouldShowPetIds
			self._shouldShowPetIds = nil

			UIStateManager.instance:push(ViewName.SeasoncampaignpetView, list)
		end
	end
end

function SeasonController:sendGetRankInfo(rankType, seasonId, zoneId)
	SeasonModePveAgent.instance:sendPM_SMPVEGetRankInfoReq(rankType, seasonId, zoneId)
end

function SeasonController:handlePM_SMPVEGetRankInfoRes(status, msg)
	if status == 0 then
		SeasonRankModel.instance:refreshSeasonRankData(msg)
	end
end

function SeasonController:handleSMPVEInfoRes(status, msg)
	if status == 0 then
		SeasonModel.instance:handleSeasonInfoData(msg)
	end
end

function SeasonController:handleNotifySMPVEUnlockTeamRes(status, msg)
	if status == 0 then
		SeasonTeamsModel.instance:onServerAddTeams(msg)
		GlobalDispatcher:dispatch(GlobalNotify.SeasonServerAddTeam)
	end
end

function SeasonController:sendGetSeasonInfo(seasonId)
	SeasonModePveAgent.instance:sendPM_SMPVESeasonInfoReq(seasonId)
end

function SeasonController:handleFindKeyInfo(msg)
	SeasonModel.instance:handleFindKeyInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.SeasonGetFindKeyInfo)
end

function SeasonController:handleMapBuffInfo(msg)
	SeasonModel.instance:handleMapBuffInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.SeasonGetMapBuffInfo)
end

function SeasonController:handlePM_SMGVEGroupInfoRes(msg)
	SeasonModel.instance:handleGroupInfoAndState(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_SMGVEGroupInfoRes)

	if checknumber(self._inviterUserId) > 0 then
		self:handlerAddTeamByChatMsg()
	end
end

function SeasonController:handlePM_SMGVEGroupInviteListRes(msg)
	SeasonModel.instance:handleGroupInviteList(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_SMGVEGroupInviteListRes)

	if checknumber(self._inviterUserId) > 0 then
		self:handlerAddTeamByChatMsg()
	end
end

function SeasonController:handlePM_SMGVEGroupInviteBuddyListRes(msg)
	local friends = {}
	local buddyList = msg.buddyList
	local friendModel = FriendModel.instance

	for _, buddy in ipairs(buddyList) do
		local mo = friendModel:getFriendMo(buddy.headInfo.userId)

		if mo then
			table.insert(friends, mo)
		end
	end

	UIStateManager.instance:open(ViewName.FriendSelect, friends, 5, "仅能邀请在线好友")
end

function SeasonController:sendPM_SMGVESendGroupInviteReq(ids)
	local targetUseIds = {}
	local cd = 20

	for i, v in ipairs(ids) do
		if self._sendCdIds[v] then
			if cd < ServerTime.now() - self._sendCdIds[v] then
				self._sendCdIds[v] = ServerTime.now()

				table.insert(targetUseIds, v)
			end
		else
			self._sendCdIds[v] = ServerTime.now()

			table.insert(targetUseIds, v)
		end
	end

	SeasonModePvePlusAgent.instance:sendPM_SMGVESendGroupInviteReq(ids)
end

function SeasonController:handlePM_NotifySMGVEReceiveGroupInviteRes(msg)
	self:_addBeGroupInvate(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_NotifySMGVEReceiveGroupInviteRes, msg)
end

function SeasonController:_addBeGroupInvate(msg)
	local invateInfo = msg.invite
	local mo = FriendModel.instance:getFriendMo(invateInfo.userId)

	if not mo then
		self._needBeInvateOnGetFriendMos = true

		table.insert(self._beInvateMsgs, msg)
		FriendAgent.instance:sendGetBuddyInfoReq()

		return
	end

	local headInfo = mo.headInfo

	if headInfo then
		local cd = 20

		self:tryUnregPopupMsg(headInfo.userId)

		self.msgMap[headInfo.userId] = MainUIPopupMsgController.instance:regPopMsg({
			bTimeOutReject = true,
			tag = "seasongroup",
			showInitCD = cd,
			acceptFunc = self._tryAcceptInvite,
			rejectFunc = self._tryRejectInvite,
			thisArg = self,
			desc = langPara("邀请您参与赛季玩法"),
			headInfo = headInfo,
			inviter = invateInfo
		})
		self.msgCdMap[headInfo.userId] = ServerTime.now()
	end
end

function SeasonController:tryUnregPopupMsg(userId)
	local key = self.msgMap[userId]

	MainUIPopupMsgController.instance:removePopMsg(key)

	self.msgMap[userId] = nil
	self.msgCdMap[userId] = nil
end

function SeasonController:_tryAcceptInvite(data)
	local params = data.info

	SeasonModePvePlusAgent.instance:sendPM_SMGVEHandleGroupInviteReq(params.inviter.userId, 1)
end

function SeasonController:_tryRejectInvite(data)
	local params = data.info

	SeasonModePvePlusAgent.instance:sendPM_SMGVEHandleGroupInviteReq(params.inviter.userId, 0)
end

function SeasonController:_onGetFriendInfos()
	if self._needBeInvateOnGetFriendMos then
		for i, msg in ipairs(self._beInvateMsgs) do
			self:_addBeGroupInvate(msg)
		end

		self._beInvateMsgs = {}
	end
end

function SeasonController:handlePM_SMGVEHandleGroupInviteRes(msg)
	local action = msg.action
	local result = msg.result

	if action == 1 and result == 0 and not ViewMgr.instance:isOpen(ViewName.SeasonFormTeamView) and not ViewMgr.instance:isOpen(ViewName.SeasonenterView) then
		GotoMgr.gotoByString("func#725")
	elseif action == 1 and result ~= 0 then
		FloatWordMgr.instance:show(lang("房间已失效"))
	end

	GlobalDispatcher:dispatch(GlobalNotify.handlePM_SMGVEHandleGroupInviteRes)
end

function SeasonController:handlePM_SMGVEGroupReadyRes(msg)
	if msg.groupInfo.ready == true and msg.groupInfo.opReady == true then
		SeasonModel.instance:handleGroupInfoAndState({
			state = SeasonModel.GVE_GROUP_STATE_GVE,
			groupInfo = msg.groupInfo
		})
	else
		SeasonModel.instance:handleGroupInfo(msg.groupInfo)
	end

	GlobalDispatcher:dispatch(GlobalNotify.handlePM_SMGVEGroupReadyRes)
end

function SeasonController:handlePM_SMGVEGroupLeaveRes(msg)
	SeasonModel.instance:handleGroupInfoAndState({
		state = SeasonModel.GVE_GROUP_STATE_FREE
	})
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_SMGVEGroupLeaveRes)
end

function SeasonController:handlePM_SMGVEDetermineCreatePveGameModeReq(msg)
	local seasonId = SeasonModel.instance:getSeasonId()
	local data = SeasonModel.instance:getSeasonInfoData(seasonId)

	data.gameMode = SeasonModel.PVE_GAME_MODE_PVE

	GlobalDispatcher:dispatch(GlobalNotify.SeasonDetermineCreatePveGameMode)
end

function SeasonController:handlePM_NotifySMGVESuccessCreateGroupRes(msg)
	FloatWordMgr.instance:show(langPara("好友%s接受了你的异界战场-组队邀请", msg.groupInfo.headInfo.userName or ""))
	SeasonModel.instance:handleGroupInfoAndState({
		state = SeasonModel.GVE_GROUP_STATE_GROUPING,
		groupInfo = msg.groupInfo
	})
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_NotifySMGVESuccessCreateGroupRes)
end

function SeasonController:handlePM_NotifySMGVEGroupDisbandRes(msg)
	SeasonModel.instance:handleGroupInfoAndState({
		state = SeasonModel.GVE_GROUP_STATE_FREE
	})
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_NotifySMGVEGroupDisbandRes)
end

function SeasonController:handlePM_NotifySMGVESuccessCreateGVERoomRes(msg)
	FloatWordMgr.instance:show(lang("组队成功，您可进入赛季玩法"))
	SeasonModel.instance:handleGroupState(SeasonModel.GVE_GROUP_STATE_GVE)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_NotifySMGVESuccessCreateGVERoomRes)
end

function SeasonController:handlePM_NotifySMGVEOpReadyRes()
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_NotifySMGVEOpReadyRes)
end

function SeasonController:sendAddTeamByChatMsg(userId)
	self._inviterUserId = userId

	if SeasonModel.instance:getGroupState() == SeasonModel.GVE_GROUP_STATE_NOT_INIT then
		SeasonModePvePlusAgent.instance:sendPM_SMGVEGroupInfoReq()
	end

	SeasonModel.instance:clearGroupInviteList()
	SeasonModePvePlusAgent.instance:sendPM_SMGVEGroupInviteListReq()
end

function SeasonController:handlerAddTeamByChatMsg()
	local groupState = SeasonModel.instance:getGroupState()
	local inviteList = SeasonModel.instance:getGroupInviteList()

	if groupState == SeasonModel.GVE_GROUP_STATE_NOT_INIT or not inviteList then
		return
	end

	if groupState ~= SeasonModel.GVE_GROUP_STATE_FREE then
		FloatWordMgr.instance:show(lang("已在队伍中或已开始"))
	else
		local isFind = false

		for i, v in ipairs(inviteList or {}) do
			if v.userId == self._inviterUserId then
				isFind = true

				break
			end
		end

		if isFind == false then
			FloatWordMgr.instance:show(lang("邀请已失效"))
		else
			SeasonModePvePlusAgent.instance:sendPM_SMGVEHandleGroupInviteReq(self._inviterUserId, 1)
		end
	end

	self._inviterUserId = nil
end

function SeasonController:sendGetCutePetInfo(teamId)
	SeasonModePvePlusAgent.instance:sendPM_GetSMPVESingleTeamCutePetInfoReq(teamId)
end

function SeasonController:handlePM_GetSMPVESingleTeamCutePetInfoRes(status, msg)
	if status == 0 then
		SeasonTeamsModel.instance:onUpdateAllTeamCutePetInfo(msg)
		GlobalDispatcher:dispatch(GlobalNotify.SeasonFmtCutePetInfo)
	end
end

function SeasonController:sendAndSetPetCutePetInfo(teamId, raceId, cutePetType, cutePetTalentId)
	SeasonModePvePlusAgent.instance:sendPM_ChangeSMPVESinglePetCutePetInfoReq(teamId, raceId, cutePetType, cutePetTalentId)
end

function SeasonController:handlePM_ChangeSMPVESinglePetCutePetInfoRes(status, msg)
	if status == 0 then
		SeasonTeamsModel.instance:onUpdateAllTeamCutePetInfo(msg)
		GlobalDispatcher:dispatch(GlobalNotify.SeasonFmtCutePetInfo)
	end
end

function SeasonController:handlePM_SMGVETeammateTeamInfoRes(msg)
	SeasonModel.instance:handleTeammateInfo(msg)
	SeasonTeamsModel.instance:onServerAllTeammateTeamMapInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.SeasonServerAddTeam)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_SMGVETeammateTeamInfoRes)
end

function SeasonController:handlePM_SMGVETeammateAllTeamInfoRes(msg)
	SeasonTeamsModel.instance:handleTeammateAllTeamInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_SMGVETeammateAllTeamInfoRes)
end

function SeasonController:handlePM_SMGVEGainTeammateSharePrizeRes()
	SeasonModel.instance:handleShareMaterial({})
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_SMGVEGainTeammateSharePrizeRes)
end

SeasonController.instance = SeasonController.New()

return SeasonController
