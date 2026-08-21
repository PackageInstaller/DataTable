-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/clientonly/BattleGroupEntityAddCommand.lua

module("logic.battle.battleflow.component.command.impl.clientonly.BattleGroupEntityAddCommand", package.seeall)

local M = class("BattleGroupEntityAddCommand", BattleCommandBase)
local kSceneRoot = SceneMgr.instance:getSceneRoot()

function M:create(entityId, handlers)
	local cmd = M:createInstance()

	cmd:setEntityId(entityId)
	cmd:setEntityAddHandlers(handlers)

	return cmd
end

function M:onInit()
	self._entityId = 0
	self._handlers = {}
	self._resLoader = SingleResLoader.New()
	self._attackInfo = SkillAttackInfo:createInstance()
	self._directorSetter = PlayableDirectorSetter.New()
	self._attackPointContext = SkillAttackPointContext.New()
end

function M:onClear()
	self._resLoader:clear()

	self._entityId = 0

	self._attackInfo:clear()
	BattleTableUtil.clearTable(self._handlers)
	self._directorSetter:Clear()
	self._attackPointContext:clear()

	if self._timelineListener then
		self._timelineListener:RemoveListener()

		self._timelineListener = false
	end

	if self._goTimeline then
		goutil.destroy(self._goTimeline)

		self._goTimeline = false
	end
end

function M:execute(battleFlow, runningContext)
	local unitMgr = battleFlow.unitMgr
	local unit = unitMgr:getUnit(self._entityId)

	if not unit then
		if BattleLog.enableWarn then
			BattleLog.warn(string.format("M::cannot find unit[%s]", self._entityId))
		end

		self:finish(true)

		return
	end

	self._attackInfo:setAttacker(unit)
	self._attackInfo:passAttackPointHandlers(self._handlers)

	local timelineUrl = self:_getEntityAddTimeline(self._entityId)

	if timelineUrl then
		self._resLoader:load(timelineUrl, self._onResLoaded, self)
	else
		if BattleLog.enableWarn then
			BattleLog.error(string.format("M::cannot find timelineUrl[%s]", unit.property:getName()))
		end

		self:finish(true)
	end
end

function M:_onResLoaded()
	self:_buildTimeline()
	self:_buildAttackPointContext()
	self:_setTimelineBindings()
	self._directorSetter:Play()
end

function M:_buildTimeline()
	local goTimeline = self._resLoader:getResInstance()
	local unitMgr = BattleMgr.instance:getUnitMgr()
	local unit = unitMgr:getUnit(self._entityId)
	local goAvatar = unit.mountRoot:getAvatarRoot()

	goutil.addChildToParent(goTimeline, kSceneRoot)
	Astral.TransformUtil.SetPos(goTimeline.transform, Astral.TransformUtil.GetPos(goAvatar.transform, 0, 0, 0))

	self._goTimeline = goTimeline

	self._directorSetter:Build(goTimeline)
	self._directorSetter:SetWrapMode(UnityEngine.Playables.DirectorWrapMode.None)
	self._directorSetter:Stop()

	self._timelineListener = TimelineEventListener.Get(goTimeline)

	self._timelineListener:AddListener(self._onTimelineEvent, self)
end

function M:_buildAttackPointContext()
	local count, weight = self._directorSetter:GetTotalAttackPointCountAndWeight(0, 0)
	local pointTimeStr = self._directorSetter:GetTotalAttackPointTimeString(0)

	self._attackPointIndex = 0
	self._totalAttackPoint = count

	self._attackPointContext:setTimelineGameObject(self._goTimeline)
	self._attackPointContext:setSoloPerformance(true)
	self._attackPointContext:setAttackInfo(self._attackInfo)
	self._attackPointContext:setParam(SkillAttackPointContext.TotalWeight, weight)
	self._attackPointContext:setPointTimeStr(pointTimeStr)
	SkillAttackPointHandlerUtil.buildAttackPointHandlers(self._attackInfo:getAttackPointHandlers(), self._attackPointContext)
end

function M:_onTimelineEvent(eventName, param)
	if eventName == BattleTimelineEventName.Stopped then
		self:_onTimelineStop()
	elseif eventName == BattleTimelineEventName.AttackPoint then
		self:_handleAttackPoint(param)
	end
end

function M:_onTimelineStop()
	SkillAttackPointHandlerUtil.clearAttackPointHandlers(self._attackInfo:getAttackPointHandlers(), self._attackPointContext)
	self:_cleanTimelineBindings()
	self:finish(true)
end

function M:_handleAttackPoint(weight)
	if not self:_checkAttackPoint() then
		return
	end

	self._attackPointIndex = self._attackPointIndex + 1

	SkillAttackPointHandlerUtil.executeAttackPointHandlers(self._attackInfo:getAttackPointHandlers(), self._attackPointContext, weight)
end

function M:_checkAttackPoint()
	if self._attackPointIndex >= self._totalAttackPoint then
		if BattleLog.enableError then
			BattleLog.error(string.format("M::attack point[%s] is not equal，skill [%s]", self._totalAttackPoint, self._attackInfo:getSkillId()))
		end

		return false
	end

	return true
end

function M:_setTimelineBindings()
	SkillPerformanceAssistant:setupTimelineBindings(self._directorSetter, self._goTimeline, self._attackInfo)
end

function M:_cleanTimelineBindings()
	SkillPerformanceAssistant:cleanupTimelineBindings(self._directorSetter, self._attackInfo)
end

function M:toString()
	return string.format("[BattleGroupEntityAddCommand entityId = %s,]", self._entityId)
end

function M:_getEntityAddTimeline(entityId)
	local unitMgr = BattleMgr.instance:getUnitMgr()
	local unit = unitMgr:getUnit(entityId)

	if not unit then
		return false
	end

	if unit.property:getModelCode() == BattleConst.SPECIAL_MODELID_AILISI then
		return string.format("effect3d/prefab/skill/100002_ailisi_boss_special1/100002_ailisi_boss_special1_p.prefab")
	end

	return false
end

function M:hasGroupEntityAddEffect(entityId)
	local timelineUrl = self:_getEntityAddTimeline(entityId)

	return timelineUrl and true or false
end

function M:setEntityId(entityId)
	self._entityId = entityId

	return self
end

function M:setEntityAddHandlers(handlers)
	for i, handler in ipairs(handlers) do
		table.insert(self._handlers, handler)
	end

	return self
end

return M
