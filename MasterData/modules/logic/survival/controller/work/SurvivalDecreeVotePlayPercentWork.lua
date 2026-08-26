-- chunkname: @modules/logic/survival/controller/work/SurvivalDecreeVotePlayPercentWork.lua

module("modules.logic.survival.controller.work.SurvivalDecreeVotePlayPercentWork", package.seeall)

local SurvivalDecreeVotePlayPercentWork = class("SurvivalDecreeVotePlayPercentWork", BaseWork)

function SurvivalDecreeVotePlayPercentWork:ctor(param)
	self:initParam(param)
end

function SurvivalDecreeVotePlayPercentWork:initParam(param)
	self.toastList = {}
	self.goVoteFinish = param.goVoteFinish
	self.txtVotePercent = param.txtVotePercent
	self.txtVotePercentGlow = param.txtVotePercentGlow
	self.votePercent = param.votePercent
	self.anim = self.goVoteFinish:GetComponent(gohelper.Type_Animator)
	self.startValue = 0
	self.endValue = math.floor(self.votePercent * 100)
end

function SurvivalDecreeVotePlayPercentWork:onStart()
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_binansuo_agree)
	gohelper.setActive(self.goVoteFinish, true)

	self.txtVotePercent.text = string.format("%s%%", self.startValue)
	self.txtVotePercentGlow.text = ""
	self.tweenId = ZProj.TweenHelper.DOTweenFloat(self.startValue, self.endValue, 1.5, self.setPercentValue, self.onTweenFinish, self, nil, EaseType.Linear)
end

function SurvivalDecreeVotePlayPercentWork:setPercentValue(value)
	local str = string.format("%s%%", math.floor(value))

	self.txtVotePercent.text = str
	self.txtVotePercentGlow.text = str
end

function SurvivalDecreeVotePlayPercentWork:onTweenFinish()
	self:setPercentValue(self.endValue)
	self.anim:Play("finish")
	self:onPlayFinish()
end

function SurvivalDecreeVotePlayPercentWork:onPlayFinish()
	self:onDone(true)
end

function SurvivalDecreeVotePlayPercentWork:clearWork()
	if self.tweenId then
		ZProj.TweenHelper.KillById(self.tweenId)

		self.tweenId = nil
	end

	self:setPercentValue(self.endValue)
end

return SurvivalDecreeVotePlayPercentWork
