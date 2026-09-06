-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/expedition/controller/ExpeditionController.lua

module("logic.extensions.exchange.controller.ExpeditionController", package.seeall)

local ExpeditionController = class("ExpeditionController", BaseController)

function ExpeditionController:onInit()
	GlobalDispatcher:addListener(GlobalNotify.SelectTilingElem, self._onSelectTilingElem, self)
	GlobalDispatcher:addListener(GlobalNotify.EnterSceneTrigger, self._onEnterSceneTrigger, self)
	GlobalDispatcher:addListener(GlobalNotify.OnMofangLvUp, self._onMofangLvUp, self)
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._resetExpedition, self)
	self:onReset()
end

function ExpeditionController:onReset()
	self.canPlay = false
	self.hasPlayTimes = 0
	self.todayHasPlay = false
end

function ExpeditionController:getExpedSortParams()
	local names, opt = BagModel.instance:GetSortParms()

	names[1] = function(data)
		local formation = ExpeditionFmtModel.instance:getFormation()

		return (data ~= nil and formation and formation:HasPet(data.petId) or nil) and 1
	end

	table.insert(names, 2, ExpeditionController._sortFuncWithDead)
	table.insert(opt, 2, ArraySort.DESCENDING)

	return names, opt
end

function ExpeditionController._sortFuncWithDead(pet)
	local petStateData = ExpeditionModel.instance:getPetState(pet.petId)

	return (petStateData or nil) and petStateData.hpRate > 0
end

function ExpeditionController:_onSelectTilingElem(instanceId)
	local scene = SceneMgr.instance:getCurScene()

	if not scene then
		return
	end

	local unit = scene.unitFactory:getUnit(UnitTag.TilingSceneElem, instanceId)

	if not unit or not unit.elemData then
		return
	end

	local elemData = unit.elemData

	if not elemData.bindExpGridData then
		return
	end

	self:openEventView(elemData.bindExpGridData)
end

function ExpeditionController:isBattleBuffEvent(gridData)
	if not gridData then
		return false
	end

	local id = gridData.eventId

	if id == ExpeditionModel.EventType.FIGHT and gridData.progress == 1 then
		return true
	end

	return false
end

function ExpeditionController:openEventView(gridData)
	local mainPlayer = SceneMainPlayer.instance:getMainPlayer()

	if not mainPlayer or mainPlayer.actions:isPaused() then
		return
	end

	self:showEventViewByData(gridData)
end

function ExpeditionController:showEventViewByData(gridData)
	local viewName = self:getViewNameByEventData(gridData)

	if viewName then
		UIStateManager.instance:open(viewName, {
			gridData
		}, true)
	end
end

function ExpeditionController:getViewNameByEventData(gridData)
	local id = gridData.eventId
	local viewName

	if id == ExpeditionModel.EventType.FIGHT then
		viewName = self:isBattleBuffEvent(gridData) and ViewName.ExpBuffEvent or ViewName.ExpBattleEvent
	elseif id == ExpeditionModel.EventType.PET then
		viewName = ViewName.ExpPetEvent
	elseif id == ExpeditionModel.EventType.BUFF then
		viewName = ViewName.ExpBuffEvent
	elseif id == ExpeditionModel.EventType.PRIZE or id == ExpeditionModel.EventType.TREASURE then
		viewName = ViewName.ExpPrizeEvent
	elseif id == ExpeditionModel.EventType.REVIVE then
		viewName = ViewName.ExpReviveEvent
	elseif id == ExpeditionModel.EventType.SHOP then
		viewName = ViewName.ExpShopEvent
	end

	return viewName
end

function ExpeditionController:checkOneKeySweepEnd()
	local changesetId = ExpeditionModel.instance:getOneKeySweepChangeSetId()

	if changesetId then
		ExpeditionModel.instance:setOneKeySweepChangeSetId(nil)

		if changesetId then
			ExpeditionModel.instance.needShowFinish = nil

			MaterialController.instance:showChangeSetInTemp(changesetId)
		end
	end
end

function ExpeditionController:checkSweepEvents()
	local hasSweep = ExpeditionSweepModel.instance:existSweepEvents()
	local changesetId = ExpeditionModel.instance:getSweepChangeSetId()

	if hasSweep or changesetId then
		ExpeditionModel.instance:setSweepChangeSetId(nil)

		if changesetId then
			ExpeditionModel.instance.needShowFinish = nil

			MaterialController.instance:showChangeSetInTemp(changesetId)

			return
		end

		if ExpeditionModel.instance:isAllFinished() then
			return
		end

		local sweepConfigs = ExpeditionSweepModel.instance:getNextSweepEvents()

		self:openSweepEventsView(sweepConfigs)
	end

	return hasSweep
end

function ExpeditionController:checkPopSweep(level)
	local curLevel = checkint(level)
	local hasPop = GameUtil.getUserDayData("exped_sweep_pop" .. curLevel) ~= nil

	if hasPop then
		return
	end

	local sweepLv = ExpeditionSweepModel.instance:getSweepOpenedLevel()

	if sweepLv > MofangModel.instance:getCurLv() then
		return
	end

	if ExpeditionSweepModel.instance:isLevelSweepable() then
		ExpeditionModel.instance:setPopSweepOK(curLevel)
		ViewMgr.instance:open(ViewName.ExpSweepEvent)

		return true
	end
end

function ExpeditionController:openSweepEventsView(sweepConfigs)
	local viewName = sweepConfigs.viewName

	if viewName then
		UIStateManager.instance:open(viewName, sweepConfigs.gridDatas, true, true)
	end
end

function ExpeditionController:getToLevelTarget(data)
	local mainPlayer = SceneMainPlayer.instance:getMainPlayer()

	if not mainPlayer then
		return
	end

	local scene = SceneMgr.instance:getCurScene()

	if not scene then
		return
	end

	local units = scene.unitFactory:getUnits(UnitTag.TilingSceneElem)

	if not units then
		return
	end

	local currEvtId = data.eventId
	local msts

	for k, v in pairs(units) do
		local eventId

		if v.elemData and v.elemData.bindExpGridData then
			eventId = v.elemData.bindExpGridData.eventId
		end

		if eventId and not ExpeditionModel.instance:isEventCompeleted(eventId, v.elemData.bindExpGridData.progress) and currEvtId == eventId then
			msts = msts or {}

			table.insert(msts, v)
		end
	end

	if not msts then
		return
	end

	local minDist = 999999
	local msdId
	local scene = SceneMgr.instance:getCurScene()
	local mx, my = mainPlayer.transform:getPos()

	for i = 1, #msts do
		local posx, posy = msts[i].transform:getPos()
		local path = scene.pathFinder:getPath(mainPlayer.sceneUnit, mx, my, posx, posy)
		local len = scene.pathFinder:calculatePathLen(mx, my, path)

		if len < minDist then
			minDist = len
			msdId = msts[i].id
		end
	end

	if msdId then
		TaskController.instance:foreceClearState()
		mainPlayer:gotoTilingElem(msdId)
	end
end

function ExpeditionController:getToTransmitPoint()
	local mainPlayer = SceneMainPlayer.instance:getMainPlayer()

	if not mainPlayer then
		return
	end

	local scene = SceneMgr.instance:getCurScene()

	if not scene then
		return
	end

	local units = scene.unitFactory:getUnits(UnitTag.TilingSceneElem)

	if not units then
		return
	end

	for k, v in pairs(units) do
		if v.elemData and v.elemData.elemData.scene == TilingElemScene.Exitrance then
			local px, py = v.transform:getPos()

			TaskController.instance:foreceClearState()
			mainPlayer:runPath(px, py)

			return
		end
	end
end

function ExpeditionController:enterView()
	self:openWeeklyInfoView()
end

function ExpeditionController:sendGetWeekCanPlayInfo()
	ExpeditionAgent.instance:sendPM_ExpeditionGetWeeklyInfoReq()
end

function ExpeditionController:onGetWeekCanPlayInfo(msg)
	self.hasPlayTimes = checknumber(msg.hasPlayTimes)
	self.canPlay = msg.canPlay
	self.todayHasPlay = msg.todayHasPlay

	GlobalDispatcher:dispatch(GlobalNotify.OnExpeditionWeeklyInfo)
end

function ExpeditionController:openWeeklyInfoView()
	local total = checknumber(ExpeditionConfig.instance:getConst("weeklyMaxTimes"))
	local left = math.max(0, total - self.hasPlayTimes)
	local content

	if self.canPlay then
		local desc = ExpeditionConfig.instance:getConst("weeklyCanEnterDesc")

		content = langPara(desc, left, total)
	else
		local desc = ExpeditionConfig.instance:getConst("weeklyNotCanEnterDesc")

		content = langPara(desc, left, total)
	end

	TipsFacade.instance:openTipWindow(lang("tip"), content, function()
		if self.canPlay then
			UIStateManager.instance:push(ViewName.ExpMap)
		end
	end, nil, UnityEngine.TextAnchor.MiddleCenter)
end

function ExpeditionController:_onEnterSceneTrigger()
	if ExpeditionTilingModel.instance:isInTilingMapScene() then
		ExpeditionAgent.instance:sendPM_ExpeditionLeaveGridMapReq()
	end
end

function ExpeditionController:onSelectMapGridRes(msg)
	ExpeditionTilingModel.instance:setTilingMapInfos(msg.map)

	local xAxis, yAxis, eventIndex = ExpeditionTilingModel.instance:getTilingMapGrid()

	ExpeditionModel.instance:onSelectGrid(xAxis, yAxis, eventIndex)
	GlobalDispatcher:dispatch(GlobalNotify.OnExpedSelectGrid)
end

function ExpeditionController:leaveGridMap(msg)
	local xAxis, yAxis, eventIndex = ExpeditionTilingModel.instance:getTilingMapGrid()
	local sceneId = ExpeditionTilingModel.instance.sceneId
	local inInScene = ExpeditionTilingModel.instance:isInTilingMapScene()

	ExpeditionTilingModel.instance:resetTilingMapInfos()
	ExpeditionModel.instance:onNextEvent(xAxis, yAxis, eventIndex)

	if inInScene then
		SceneStatusMgr.instance:popStatus(ViewName.ExpMap)
	end

	TilingSceneMgr.instance:clearTilingSceneConfig(sceneId)
end

function ExpeditionController:onSweepLevelBack(msg)
	ExpeditionSweepModel.instance:onSweepLevelBack(msg)
	ExpeditionModel.instance:onSweepLevelBack(msg)

	if not self.todayHasPlay then
		self.todayHasPlay = true
		self.hasPlayTimes = self.hasPlayTimes + 1
	end

	GlobalDispatcher:dispatch(GlobalNotify.OnExpedSweepLevel, msg)
end

function ExpeditionController:onDoSweepEvent(msg)
	ExpeditionModel.instance:onDoSweepEvent(msg)
	ExpeditionSweepModel.instance:onDoSweepEvent(msg)
end

function ExpeditionController:onDoneGrid(msg)
	ExpeditionModel.instance:onDoneGrid(msg)

	if not self.todayHasPlay then
		self.todayHasPlay = true
		self.hasPlayTimes = self.hasPlayTimes + 1
	end

	if ExpeditionModel.instance:isAllFinished() then
		local total = checknumber(ExpeditionConfig.instance:getConst("weeklyMaxTimes"))
		local left = math.max(0, total - self.hasPlayTimes)

		self.canPlay = left > 0
	end
end

function ExpeditionController:_onMofangLvUp(msg)
	ExpeditionModel.instance:checkNextLevelGrid()
end

function ExpeditionController:_resetExpedition()
	if self.todayHasPlay then
		self.todayHasPlay = false
	end

	local total = checknumber(ExpeditionConfig.instance:getConst("weeklyMaxTimes"))
	local left = math.max(0, total - self.hasPlayTimes)

	self.canPlay = left > 0

	ExpeditionController.instance:sendGetWeekCanPlayInfo()
end

function ExpeditionController:resetSweepsInfo()
	ExpeditionModel.instance:resetSweepsInfo()
	ExpeditionSweepModel.instance:resetSweepsInfo()
end

function ExpeditionController:onOneKeySweepBack(msg)
	ExpeditionModel.instance:onOneKeySweepBack(msg)

	if not self.todayHasPlay then
		self.todayHasPlay = true
		self.hasPlayTimes = self.hasPlayTimes + 1
	end

	GlobalDispatcher:dispatch(GlobalNotify.OnExpedOneKeySweep, msg)
end

ExpeditionController.instance = ExpeditionController.New()

return ExpeditionController
