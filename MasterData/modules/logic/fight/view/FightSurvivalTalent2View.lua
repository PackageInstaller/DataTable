-- chunkname: @modules/logic/fight/view/FightSurvivalTalent2View.lua

module("modules.logic.fight.view.FightSurvivalTalent2View", package.seeall)

local FightSurvivalTalent2View = class("FightSurvivalTalent2View", FightBaseView)

function FightSurvivalTalent2View:onInitView()
	self.imageProgress = gohelper.findChildImage(self.viewGO, "root/progress/#image_progress")
	self.txtProgress = gohelper.findChildText(self.viewGO, "root/progress/#txt_progress")
	self.goFull = gohelper.findChild(self.viewGO, "root/#go_full")

	gohelper.setActive(self.goFull, false)

	self.powerType = FightEnum.PowerType.SurvivalDot
	self.entityMo = FightDataHelper.entityMgr:getVorpalith()
	self.entityId = self.entityMo.id
end

function FightSurvivalTalent2View:addEvents()
	self.addEventCb(self, FightController.instance, FightEvent.PowerChange, self.onPowerChange, self)
end

function FightSurvivalTalent2View:onPowerChange(entityId, powerId, oldValue, newValue)
	if entityId ~= self.entityId then
		return
	end

	if powerId ~= self.powerType then
		return
	end

	self:changePower()
end

FightSurvivalTalent2View.TweenDuration = 0.5

function FightSurvivalTalent2View:changePower()
	if self.entityMo then
		local powerInfo = self.entityMo:getPowerInfo(self.powerType)

		if not powerInfo then
			return
		end

		self:killTween()

		local curProgress = powerInfo.num / powerInfo.max
		local oldProgress = self.imageProgress.fillAmount

		self.tweenId = ZProj.TweenHelper.DOTweenFloat(oldProgress, curProgress, self.TweenDuration, self.onFrameCallback, self.onDoneCallback, self)
	end
end

function FightSurvivalTalent2View:onFrameCallback(progress)
	self:directSetProgress(progress)
end

function FightSurvivalTalent2View:onDoneCallback()
	self.tweenId = nil

	self:refreshProgress()
	self:tryPlayFullAnim()
end

function FightSurvivalTalent2View:tryPlayFullAnim()
	if self:checkTriggerEffect() then
		gohelper.setActive(self.goFull, false)
		gohelper.setActive(self.goFull, true)
		AudioMgr.instance:trigger(410000031)
	end
end

function FightSurvivalTalent2View:checkTriggerEffect()
	if self.entityMo then
		local powerInfo = self.entityMo:getPowerInfo(self.powerType)

		if not powerInfo then
			return
		end

		local triggerValue = powerInfo.max

		if self.entityMo:hasBuffId(107311008) then
			triggerValue = 0.8 * triggerValue
		end

		return triggerValue <= powerInfo.num
	end
end

function FightSurvivalTalent2View:onOpen()
	self:refreshProgress()
end

function FightSurvivalTalent2View:directSetProgress(rate)
	self.imageProgress.fillAmount = rate
	self.txtProgress.text = string.format("%s%%", math.floor(rate * 100))
end

function FightSurvivalTalent2View:refreshProgress()
	if self.entityMo then
		local powerInfo = self.entityMo:getPowerInfo(self.powerType)

		if not powerInfo then
			return
		end

		local progress = powerInfo.num / powerInfo.max

		self:directSetProgress(progress)
	end
end

function FightSurvivalTalent2View:killTween()
	if self.tweenId then
		ZProj.TweenHelper.KillById(self.tweenId)

		self.tweenId = nil
	end
end

function FightSurvivalTalent2View:onDestroyView()
	self:killTween()
end

return FightSurvivalTalent2View
