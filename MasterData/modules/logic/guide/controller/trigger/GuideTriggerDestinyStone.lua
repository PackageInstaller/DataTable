-- chunkname: @modules/logic/guide/controller/trigger/GuideTriggerDestinyStone.lua

module("modules.logic.guide.controller.trigger.GuideTriggerDestinyStone", package.seeall)

local GuideTriggerDestinyStone = class("GuideTriggerDestinyStone", BaseGuideTrigger)

function GuideTriggerDestinyStone:ctor(triggerKey)
	GuideTriggerDestinyStone.super.ctor(self, triggerKey)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, self._onOpenView, self)
	CharacterDestinyController.instance:registerCallback(CharacterDestinyEvent.OnUnlockSlot, self._OnUnlockSlot, self)
	CharacterDestinyController.instance:registerCallback(CharacterDestinyEvent.OnUseStoneReply, self._OnUseStone, self)
	CharacterController.instance:registerCallback(CharacterEvent.successHeroRankUp, self._characterLevelUp, self)
	CharacterController.instance:registerCallback(CharacterEvent.successHeroLevelUp, self._characterLevelUp, self)
end

function GuideTriggerDestinyStone:assertGuideSatisfy(param, configParam)
	if param == tonumber(configParam) then
		return true
	end
end

function GuideTriggerDestinyStone:_characterLevelUp()
	if self:_checkDestinyStone(self.heroMo) then
		local destinyStoneMo = self.heroMo.destinyStoneMo

		if destinyStoneMo and not destinyStoneMo:isUnlockSlot() then
			self:checkStartGuide(23301)
		end
	end
end

function GuideTriggerDestinyStone:_onOpenView(viewName, viewParam)
	if viewName == ViewName.CharacterView then
		local heroMo = viewParam

		if self:_checkDestinyStone(heroMo) then
			local destinyStoneMo = heroMo.destinyStoneMo
			local guideId = 23301

			if destinyStoneMo:isUnlockSlot() then
				local guideMO = GuideModel.instance:getById(guideId)

				if guideMO then
					local isGuideFinish = guideMO.serverStepId == -1 and guideMO.clientStepId == -1

					if not isGuideFinish then
						GuideStepController.instance:clearFlow(guideId)
						GuideModel.instance:remove(guideMO)
					end
				end
			else
				self:checkStartGuide(guideId)
			end
		end

		self.heroMo = heroMo
	end

	if viewName == ViewName.CharacterDestinySlotView then
		local heroMo = viewParam.heroMo

		if self:_checkDestinyStone(heroMo) then
			local destinyStoneMo = heroMo.destinyStoneMo

			if destinyStoneMo and destinyStoneMo:isUnlockSlot() then
				if destinyStoneMo.curUseStoneId == 0 then
					if not destinyStoneMo.unlockStoneIds or #destinyStoneMo.unlockStoneIds == 0 then
						self:checkStartGuide(23302)
					end
				else
					self:checkStartGuide(23303)
				end
			end
		end
	end
end

function GuideTriggerDestinyStone:_checkDestinyStone(heroMo)
	if not heroMo or not heroMo:isOwnHero() then
		return
	end

	if not heroMo:isCanOpenDestinySystem() then
		return
	end

	return true
end

function GuideTriggerDestinyStone:_OnUnlockSlot()
	self:checkStartGuide(23302)
end

function GuideTriggerDestinyStone:_OnUseStone(heroId, stoneId)
	self:checkStartGuide(23303)
end

return GuideTriggerDestinyStone
