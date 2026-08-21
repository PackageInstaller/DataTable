-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/controller/HouseGMController.lua

module("logic.extensions.house.controller.HouseGMController", package.seeall)

local M = class("HouseGMController", BaseController)
local PlayerStatus = HouseEnum.PlayerStatus

function M:onInit()
	self._focusHeroId = false
	self._isGMToggleOn = false
	self._focusWorkStatus = false
	self._focusBehavior = false
	self._restartAIHeroId = false
	self._currBehavior = false
	self._forbidDefaultPerform = false

	HouseDispatcher:addEventListener(HouseEventType.REMOVE_HERO_UNIT, self._onRemoveUnit, self)
	HouseDispatcher:addEventListener(HouseEventType.END_HERO_CURR_BEHAVIOR, self._onUnitCurrBehaviorEnd, self)
end

function M:onReset()
	self._focusHeroId = false
	self._isGMToggleOn = false
	self._focusWorkStatus = false
	self._focusBehavior = false
	self._restartAIHeroId = false
	self._currBehavior = false
	self._forbidDefaultPerform = false
end

function M:setGMToggle(isOn)
	local curScene = SceneMgr.instance:getCurScene()

	if SceneMgr.instance:getCurSceneType() ~= SceneType.House then
		return
	end

	self._isGMToggleOn = isOn

	if self:getGMToggle() then
		ViewMgr.instance:open(ViewName.HouseGMView)
		ViewMgr.instance:close(ViewName.HackToolView)
	else
		ViewMgr.instance:close(ViewName.HouseGMView)
	end
end

function M:getGMToggle()
	return self._isGMToggleOn
end

function M:showGMView()
	if self._isGMToggleOn or self._focusHeroId then
		return true
	end

	return false
end

function M:setFocusHero(heroId)
	heroId = heroId or false

	if self._focusHeroId ~= heroId then
		self:restartHeroAI(self._focusHeroId)

		self._focusHeroId = heroId
		self._focusWorkStatus = false
		self._focusBehavior = false

		self:_tryGetFocusHeroBehavior()
		HouseDispatcher:dispatchEvent(HouseEventType.GM_CHANGE_FOCUS_HERO)
	end
end

function M:getFocusHero()
	return self._focusHeroId
end

function M:setFocusWorkStatus(workStatus)
	workStatus = workStatus or false

	if self._focusWorkStatus ~= workStatus then
		self._focusWorkStatus = workStatus

		self:restartHeroAI(self._focusHeroId)
	end
end

function M:getFocusWorkStatus()
	return self._focusWorkStatus
end

function M:setFocusBehavior(behavior)
	behavior = behavior or false

	if self._focusBehavior ~= behavior then
		self._focusBehavior = behavior

		self:restartHeroAI(self._focusHeroId)
	end
end

function M:getFocusBehavior()
	return self._focusBehavior
end

function M:setCurrBehavior(currBehaviorType)
	if not self._focusBehavior then
		self._currBehavior = currBehaviorType
	end
end

function M:getCurrBehavior()
	return self._currBehavior
end

function M:setForbidDefaultPerform(forbid)
	self._forbidDefaultPerform = forbid
end

function M:getForbidDefaultPerform()
	return self._forbidDefaultPerform
end

function M:_tryGetFocusHeroBehavior()
	if self._focusHeroId then
		local focusUnit = HouseSceneUtil.getHousePlayerUnit(self._focusHeroId)

		if focusUnit then
			local currBehavior = focusUnit.behaviorMgr:getCurrBehavior()

			self:setCurrBehavior(currBehavior:getType())
		end
	end
end

function M:getEffectBehaviorOrSchedule(heroId)
	local effectBehavior = false
	local effectSchedule = false

	if SceneMgr.instance:getCurSceneType() == SceneType.House and self._focusHeroId == heroId then
		effectSchedule = self._focusWorkStatus
		effectBehavior = self._focusBehavior
	end

	return effectBehavior, effectSchedule
end

function M:openFocusHeroSelectedView()
	local scheduleList = HouseWorkerModel.instance:getAllScheduleWithHero()
	local heroIdList = {}

	for _, schedule in ipairs(scheduleList) do
		table.insert(heroIdList, schedule.hero)
	end

	local paramTable = {}

	paramTable.heroIdList = heroIdList
	paramTable.selectedHero = self._focusHeroId
	paramTable.confirmCallback = self._onSelectedFocusHero
	paramTable.confirmTarget = self

	ViewMgr.instance:open(ViewName.HeroSelected, paramTable)
end

function M:_onSelectedFocusHero(selectedHeroId)
	self:setFocusHero(selectedHeroId)
end

function M:getEffectBehaviors()
	local behaviors = {}

	if self._focusHeroId then
		local focusUnit = HouseSceneUtil.getHousePlayerUnit(self._focusHeroId)

		if focusUnit then
			behaviors = HouseSceneUtil.getBehaviorsByWorkType(focusUnit.scheduleModel:getWorkType())
		end
	end

	return behaviors
end

function M:restartHeroAI(heroId)
	if heroId then
		local heroUnit = HouseSceneUtil.getHousePlayerUnit(heroId)

		if heroUnit then
			if heroUnit.model:judgeStatus(PlayerStatus.Elevator) then
				self._restartAIHeroId = heroId
			else
				heroUnit.behaviorMgr:clearAllBehavior()
				heroUnit.performCtrl:interrupt()
				heroUnit.ai:restartCurrAI()
			end
		end
	end
end

function M:_handleElevatorExit(e, elevatorId, unitId)
	local curScene = SceneMgr.instance:getCurScene()

	if curScene and curScene.unitFactory then
		local exitUnit = curScene.unitFactory:getUnit(UnitTag.Player, unitId)

		if exitUnit.heroId == self._restartAIHeroId then
			local heroId = self._restartAIHeroId

			self._restartAIHeroId = false

			self:restartHeroAI(heroId)
		end
	end
end

function M:performFocusHero()
	local function _rollOneSinglePerform(unit)
		local curSceneFlow = SceneFace.instance:getCurSceneFlow()

		if curSceneFlow and curSceneFlow.performTrigger then
			local singleCtrl = curSceneFlow.performTrigger:_getOrCreateSingleCtrl(unit)
			local COs = singleCtrl:reFindAllUsablePerformCO()

			if #COs > 0 then
				singleCtrl:clearPerformCD()

				local performId = singleCtrl:showPerformance()

				FloatWordMgr.instance:show(string.format("成功触发表演，id：%s", performId))
			else
				FloatWordMgr.instance:show(lang("tip_not_performance"))
			end
		end
	end

	if self._focusHeroId then
		local focusUnit = HouseSceneUtil.getHousePlayerUnit(self._focusHeroId)

		if focusUnit then
			local runningCtrl = focusUnit.performCtrl:getRunningCtrl()

			if runningCtrl then
				if runningCtrl:getCtrlType() == HouseEnum.PerformCtrlType.Double then
					if runningCtrl:canPerformForGM() and runningCtrl:getPerformStatus() ~= HouseEnum.PerformStatus.Running then
						runningCtrl:clearPerformCD()

						local performId = runningCtrl:showPerformance()

						FloatWordMgr.instance:show(string.format("成功触发表演，id：%s", performId))
					end
				else
					runningCtrl:interruptPerform()
					_rollOneSinglePerform(focusUnit)
				end
			elseif HousePerformUtil.canUnitTriggerPerform(focusUnit, true) then
				_rollOneSinglePerform(focusUnit)
			else
				FloatWordMgr.instance:show("触发表演失败，小人所处状态不对，或者当前表演未结束")
			end
		end
	end
end

function M:getFocusHeroOriginWorkStatus()
	if self._focusHeroId then
		local focusUnit = HouseSceneUtil.getHousePlayerUnit(self._focusHeroId)

		if focusUnit then
			return focusUnit.scheduleModel:getCurWorkStatus()
		end
	end
end

function M:_onRemoveUnit(e, unitId, heroId)
	if self._focusHeroId == heroId then
		self:setFocusHero(false)
	end
end

function M:_onUnitCurrBehaviorEnd(e, unit, lastBehavior, currBehavior)
	if unit and unit.heroId == self._focusHeroId then
		self:setCurrBehavior(currBehavior:getType())
	end
end

M.instance = M.New()

return M
