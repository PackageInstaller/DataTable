-- chunkname: @modules/logic/guide/controller/trigger/GuideTriggerTalentStyle.lua

module("modules.logic.guide.controller.trigger.GuideTriggerTalentStyle", package.seeall)

local GuideTriggerTalentStyle = class("GuideTriggerTalentStyle", BaseGuideTrigger)

function GuideTriggerTalentStyle:ctor(triggerKey)
	GuideTriggerTalentStyle.super.ctor(self, triggerKey)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, self._onOpenView, self)
	CharacterController.instance:registerCallback(CharacterEvent.onReturnTalentView, self._onReturnTalentView, self)
end

function GuideTriggerTalentStyle:assertGuideSatisfy(param, configParam)
	if not param then
		return false
	end

	return param >= tonumber(configParam)
end

function GuideTriggerTalentStyle:_checkStartGuide(heroId)
	local heroMo = HeroModel.instance:getByHeroId(heroId)

	if heroMo then
		self:checkStartGuide(heroMo.talent)
	end
end

function GuideTriggerTalentStyle:_onOpenView(viewName, viewParam)
	if viewName == ViewName.CharacterTalentView then
		local heroId = viewParam.heroid

		self:_checkStartGuide(heroId)
	end
end

function GuideTriggerTalentStyle:_onReturnTalentView(heroId)
	self:_checkStartGuide(heroId)
end

return GuideTriggerTalentStyle
