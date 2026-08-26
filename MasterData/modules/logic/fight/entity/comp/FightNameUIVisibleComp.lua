-- chunkname: @modules/logic/fight/entity/comp/FightNameUIVisibleComp.lua

module("modules.logic.fight.entity.comp.FightNameUIVisibleComp", package.seeall)

local FightNameUIVisibleComp = class("FightNameUIVisibleComp", FightBaseClass)

function FightNameUIVisibleComp:onConstructor(entity)
	self.entity = entity
	self._showBySkillStart = {}
	self._hideByEntity = {}
	self._showByTimeline = {}
	self._hideByTimeline = {}

	self:com_registEvent(ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView)
	self:com_registEvent(ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView)
	self:com_registFightEvent(FightEvent.OnSkillPlayStart, self._onSkillPlayStart)
	self:com_registFightEvent(FightEvent.OnSkillPlayFinish, self._onSkillPlayFinish)
	self:com_registFightEvent(FightEvent.SetEntityVisibleByTimeline, self._setEntityVisibleByTimeline)
	self:com_registFightEvent(FightEvent.SetNameUIVisibleByTimeline, self._setNameUIVisibleByTimeline)
	self:com_registFightEvent(FightEvent.ForceEndSkillStep, self._forceEndSkillStep, LuaEventSystem.High)
end

function FightNameUIVisibleComp:_onOpenView(viewName)
	if viewName == ViewName.FightQuitTipView and self.entity.nameUI then
		self.entity.nameUI:setActive(false, FightNameActiveKey.OpenFightQuitTipViewKey)
	end
end

function FightNameUIVisibleComp:_onCloseView(viewName)
	if viewName == ViewName.FightQuitTipView and self.entity.nameUI then
		self.entity.nameUI:setActive(true, FightNameActiveKey.OpenFightQuitTipViewKey)
	end
end

local filterEffectType = {
	[FightEnum.EffectType.STORAGEINJURY] = true,
	[FightEnum.EffectType.DAMAGEFROMABSORB] = true,
	[FightEnum.EffectType.SHIELDVALUECHANGE] = true,
	[FightEnum.EffectType.SHAREHURT] = true
}

function FightNameUIVisibleComp:_onSkillPlayStart(entity, skillId, fightStepData)
	local dict = FightHelper.getRelativeEntityIdDict(fightStepData, filterEffectType)

	if dict[self.entity.id] then
		table.insert(self._showBySkillStart, fightStepData)
	end

	self:_checkVisible(FightNameActiveKey.PlayingTimelineKey)
end

function FightNameUIVisibleComp:_onSkillPlayFinish(entity, skillId, fightStepData)
	tabletool.removeValue(self._showBySkillStart, fightStepData)
	tabletool.removeValue(self._hideByEntity, fightStepData)
	tabletool.removeValue(self._showByTimeline, fightStepData)
	tabletool.removeValue(self._hideByTimeline, fightStepData)

	local is_same_skill_playing
	local all_entity = FightHelper.getAllEntitys()

	for i, tar_entity in ipairs(all_entity) do
		if tar_entity.skill and tar_entity.skill:sameSkillPlaying() then
			is_same_skill_playing = true

			break
		end
	end

	if is_same_skill_playing then
		return
	end

	self:_checkVisible(FightNameActiveKey.PlayingTimelineKey)
end

function FightNameUIVisibleComp:_forceEndSkillStep(fightStepData)
	tabletool.removeValue(self._hideByEntity, fightStepData)
end

function FightNameUIVisibleComp:_setEntityVisibleByTimeline(entity, fightStepData, isVisible, transitionTime)
	if self.entity.id ~= entity.id then
		return
	end

	tabletool.removeValue(self._hideByEntity, fightStepData)

	if not isVisible then
		table.insert(self._hideByEntity, fightStepData)
	end

	self:_checkVisible(FightNameActiveKey.PlayingTimelineKey)
end

function FightNameUIVisibleComp:_setNameUIVisibleByTimeline(entity, fightStepData, isVisible)
	if self.entity.id ~= entity.id then
		return
	end

	if isVisible then
		if not tabletool.indexOf(self._showByTimeline, fightStepData) then
			table.insert(self._showByTimeline, fightStepData)
		end
	elseif not tabletool.indexOf(self._hideByTimeline, fightStepData) then
		table.insert(self._hideByTimeline, fightStepData)
	end

	self:_checkVisible(FightNameActiveKey.PlayingTimelineKey)
end

function FightNameUIVisibleComp:_checkVisible(key)
	if self.entity.nameUI then
		if FightSkillMgr.instance:isPlayingAnyTimeline() then
			if #self._hideByEntity > 0 then
				self.entity.nameUI:setActive(false, key)
			elseif #self._showByTimeline > 0 then
				self.entity.nameUI:setActive(true, key)
			elseif #self._hideByTimeline > 0 then
				self.entity.nameUI:setActive(false, key)
			elseif #self._showBySkillStart > 0 then
				self.entity.nameUI:setActive(true, key)
			else
				self.entity.nameUI:setActive(false, key)
			end
		else
			self.entity.nameUI:setActive(true, key)
		end
	end
end

return FightNameUIVisibleComp
