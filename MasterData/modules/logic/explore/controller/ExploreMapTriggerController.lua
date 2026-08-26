-- chunkname: @modules/logic/explore/controller/ExploreMapTriggerController.lua

module("modules.logic.explore.controller.ExploreMapTriggerController", package.seeall)

local ExploreMapTriggerController = class("ExploreMapTriggerController", BaseController)

function ExploreMapTriggerController:onInit()
	self.triggerHandleDic = {
		[ExploreEnum.TriggerEvent.Award] = ExploreTriggerAward,
		[ExploreEnum.TriggerEvent.Story] = ExploreTriggerStory,
		[ExploreEnum.TriggerEvent.ChangeCamera] = ExploreTriggerCameraCO,
		[ExploreEnum.TriggerEvent.ChangeElevator] = ExploreTriggerElevator,
		[ExploreEnum.TriggerEvent.MoveCamera] = ExploreTriggerMoveCamera,
		[ExploreEnum.TriggerEvent.Guide] = ExploreTriggerGuide,
		[ExploreEnum.TriggerEvent.Rotate] = ExploreTriggerRotate,
		[ExploreEnum.TriggerEvent.Dialogue] = ExploreTriggerDialogue,
		[ExploreEnum.TriggerEvent.ItemUnit] = ExploreTriggerItem,
		[ExploreEnum.TriggerEvent.Spike] = ExploreTriggerSpike,
		[ExploreEnum.TriggerEvent.OpenArchiveView] = ExploreTriggerOpenArchiveView,
		[ExploreEnum.TriggerEvent.Audio] = ExploreTriggerPlayAudio,
		[ExploreEnum.TriggerEvent.BubbleDialogue] = ExploreTriggerBubbleDialogue,
		[ExploreEnum.TriggerEvent.HeroPlayAnim] = ExploreTriggerHeroPlayAnim
	}
	self._triggerflowPool = LuaObjPool.New(5, function()
		return BaseExploreSequence.New()
	end, function(flow)
		flow:dispose()
	end, function()
		return
	end)
	self._usingTriggerflowDic = {}
	self._triggerHandlePoolDic = {}
end

function ExploreMapTriggerController:onInitFinish()
	return
end

function ExploreMapTriggerController:addConstEvents()
	ExploreController.instance:registerCallback(ExploreEvent.TryTriggerUnit, self._tryTriggerUnit, self)
	ExploreController.instance:registerCallback(ExploreEvent.TryCancelTriggerUnit, self._tryCancelTriggerUnit, self)
end

function ExploreMapTriggerController:reInit()
	self._triggerflowPool:dispose()
end

function ExploreMapTriggerController:getFlow(unitId)
	local flow = self._usingTriggerflowDic[unitId]

	if flow == nil then
		flow = self._triggerflowPool:getObject()
	end

	self._usingTriggerflowDic[unitId] = flow

	return flow
end

function ExploreMapTriggerController:releaseFlow(unitId)
	local flow = self._usingTriggerflowDic[unitId]

	self._triggerflowPool:putObject(flow)

	self._usingTriggerflowDic[unitId] = nil
end

function ExploreMapTriggerController:getTriggerHandle(triggerType)
	if self.triggerHandleDic[triggerType] then
		local pool = self._triggerHandlePoolDic[triggerType]

		if pool == nil then
			pool = LuaObjPool.New(5, function()
				return self.triggerHandleDic[triggerType].New()
			end, function(work)
				work:clearWork()
			end, function()
				return
			end)
			self._triggerHandlePoolDic[triggerType] = pool
		end

		return pool:getObject()
	end
end

function ExploreMapTriggerController:registerMap(map)
	self._map = map
end

function ExploreMapTriggerController:unRegisterMap(map)
	if self._map == map then
		self._map = nil
	end
end

function ExploreMapTriggerController:getMap()
	return self._map
end

function ExploreMapTriggerController:_tryCancelTriggerUnit(unitId)
	if not self._map:isInitDone() then
		return
	end

	local unit = self._map:getUnit(unitId)

	if unit then
		unit:cancelTrigger()
	end
end

function ExploreMapTriggerController:_tryTriggerUnit(unitId, isClient)
	if not self._map:isInitDone() then
		return
	end

	local unit = self._map:getUnit(unitId)

	if unit then
		local carryUnit = ExploreModel.instance:getCarryUnit()

		if not isClient and carryUnit and (not isTypeOf(unit, ExplorePipeEntranceUnit) or unit.mo:getColor() ~= ExploreEnum.PipeColor.None) then
			ToastController.instance:showToast(ExploreConstValue.Toast.ExploreCantTrigger)

			return
		end

		local interactOptions = {}

		if unit.mo.isCanMove and not unit.mo:isInteractFinishState() then
			table.insert(interactOptions, ExploreInteractOptionMO.New(luaLang("explore_op_move"), self._beginMoveUnit, self, unit))
		end

		if not unit.mo:isInteractEnabled() and unit:getFixItemId() then
			table.insert(interactOptions, ExploreInteractOptionMO.New(luaLang("explore_op_fix"), self._beginFixUnit, self, unit))
		end

		if unit:canTrigger() then
			table.insert(interactOptions, ExploreInteractOptionMO.New(luaLang("explore_op_interact"), self._beginTriggerUnit, self, unit, isClient))
		end

		local len = #interactOptions

		if len == 1 then
			interactOptions[1].optionCallBack(interactOptions[1].optionCallObj, interactOptions[1].unit, interactOptions[1].isClient)
		elseif len > 1 then
			ViewMgr.instance:openView(ViewName.ExploreInteractOptionView, interactOptions)
		end
	end
end

function ExploreMapTriggerController:_beginMoveUnit(unit)
	ExploreController.instance:dispatchEvent(ExploreEvent.SetMoveUnit, unit)
end

function ExploreMapTriggerController:_beginFixUnit(unit)
	local itemMO = ExploreBackpackModel.instance:getItem(unit:getFixItemId())

	if not itemMO then
		ToastController.instance:showToast(ExploreConstValue.Toast.NoItem)

		return
	end

	local hero = ExploreController.instance:getMap():getHero()

	hero:onCheckDir(hero.nodePos, unit.nodePos)
	hero:setHeroStatus(ExploreAnimEnum.RoleAnimStatus.Fix, true, true)

	local fixView = hero.uiComp:addUI(ExploreRoleFixView)

	fixView:setFixUnit(unit)
	ExploreRpc.instance:sendExploreUseItemRequest(itemMO.id, 0, 0, unit.id)

	local effName, isOnce, audioId, isBindGo = ExploreConfig.instance:getUnitEffectConfig(unit:getResPath(), "fix")

	ExploreHelper.triggerAudio(audioId, isBindGo, unit.go)
end

function ExploreMapTriggerController:_beginTriggerUnit(unit, isClient)
	local unitType = unit:getUnitType()
	local isTrigger = unit:tryTrigger()

	if unitType ~= ExploreEnum.ItemType.Bonus then
		local hero = ExploreController.instance:getMap():getHero()

		if not isClient and ExploreHelper.getDistance(hero.nodePos, unit.nodePos) == 1 then
			hero:onCheckDir(hero.nodePos, unit.nodePos)
		end

		if isTrigger then
			hero:setHeroStatus((unitType == ExploreEnum.ItemType.StoneTable or isTypeOf(unit, ExploreItemUnit)) and ExploreAnimEnum.RoleAnimStatus.CreateUnit, true, true)
		end
	end
end

function ExploreMapTriggerController:triggerUnit(unit, clientOnly)
	if self._map:isInitDone() == false then
		return
	end

	local unitId = unit.id
	local flow = self:getFlow(unitId)

	flow:buildFlow()

	local isFirstDialog = true
	local unitType = unit:getUnitType()

	if unitType == ExploreEnum.ItemType.BonusScene then
		local t = ExploreTriggerBonusScene.New()

		t:setParam(nil, unit, 0, clientOnly)
		flow:addWork(t)
	end

	for i, v in ipairs(unit:getExploreUnitMO().triggerEffects) do
		local triggerType = v[1]
		local handler = self:getTriggerHandle(triggerType)

		if handler then
			handler:setParam(v[2], unit, i, clientOnly)

			if triggerType == ExploreEnum.TriggerEvent.Dialogue then
				if isFirstDialog then
					isFirstDialog = false
				else
					handler.isNoFirstDialog = true
				end
			end

			flow:addWork(handler)
		end
	end

	if not ExploreEnum.ServerTriggerType[unitType] and unit.mo.triggerByClick or unit:getUnitType() == ExploreEnum.ItemType.Reset then
		local t = ExploreTriggerNormal.New()

		t:setParam(nil, unit, 0, clientOnly)
		flow:addWork(t)
	end

	flow:start(function(isSuccess)
		if isSuccess then
			self:triggerDone(unitId)
		end
	end)
end

function ExploreMapTriggerController:triggerDone(unitId)
	self:releaseFlow(unitId)
	self:doDoneTrigger(unitId)
end

function ExploreMapTriggerController:setDonePerformance(unit)
	for i, v in ipairs(unit:getExploreUnitMO().doneEffects) do
		local handler = self:getTriggerHandle(v[1])

		if handler then
			handler:setParam(v[2], unit)
			handler:onStart()
		else
			logError("Explore triggerHandle not find:", unit.id, v[1])
		end
	end
end

function ExploreMapTriggerController:doDoneTrigger(unitId)
	if not self._map then
		return
	end

	local unit = self._map:getUnit(unitId, true)

	if not unit then
		return
	end

	unit:getExploreUnitMO().hasInteract = true

	local flow = self:getFlow(unitId)

	flow:buildFlow()

	for i, v in ipairs(unit:getExploreUnitMO().doneEffects) do
		local handler = self:getTriggerHandle(v[1])

		if handler then
			handler:setParam(v[2], unit)
			flow:addWork(handler)
		end
	end

	flow:start(function()
		unit:onTriggerDone()
		self:releaseFlow(unitId)
	end)
end

function ExploreMapTriggerController:triggerEvent(eventType, parm)
	local handler = self:getTriggerHandle(eventType)

	if handler then
		handler:handle(parm)
	end
end

function ExploreMapTriggerController:cancelTriggerEvent(eventType, parm, unit)
	local handler = self:getTriggerHandle(eventType)

	if handler then
		handler:setParam(parm, unit)
		handler:cancel(parm)
	end
end

function ExploreMapTriggerController:cancelTrigger(unit, clientOnly)
	if self._map:isInitDone() == false then
		return
	end

	local unitId = unit.id
	local flow = self:getFlow(unitId)

	flow:buildFlow()

	for i, v in ipairs(unit:getExploreUnitMO().triggerEffects) do
		local handler = self:getTriggerHandle(v[1])

		if handler then
			handler:setParam(v[2], unit, i, clientOnly, true)
			flow:addWork(handler)
		end
	end

	flow:start(function(isSuccess)
		self:releaseFlow(unitId)
		unit:onTriggerDone()
	end)
end

ExploreMapTriggerController.instance = ExploreMapTriggerController.New()

return ExploreMapTriggerController
