-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shenjichallenge/view/ShenJiBossHpView.lua

module("logic.extensions.shenjichallenge.view.ShenJiBossHpView", package.seeall)

local ShenJiBossHpView = class("ShenJiBossHpView", ViewComponent)

function ShenJiBossHpView:ctor()
	ShenJiBossHpView.super.ctor(self)
end

function ShenJiBossHpView:buildUI()
	ShenJiBossHpView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._txtTitle = self:getTxt("txtTitle")
	self._txtDesc = self:getTxt("main/txtDesc")
	self._txtHp = self:getTxt("main/hp/txtHp")
	self._fillImg = self:getImg("main/hp/fillImg")
end

function ShenJiBossHpView:bindEvents()
	ShenJiBossHpView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
end

function ShenJiBossHpView:unbindEvents()
	ShenJiBossHpView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function ShenJiBossHpView:onEnter()
	ShenJiBossHpView.super.onEnter(self)

	local params = self:getOpenParam()
	local isEmulate = params[1]
	local bossLeftHp = params[2]
	local bossTotalHp = params[3]
	local isWin = params[4]
	local curChallengeTimes = params[5]
	local maxChallengeTimes = params[6]
	local curActivityId = ShenJiChallengeModel.instance:getCurActivityId()

	self._txtTitle.text = self:_getTitle(curActivityId, isEmulate, isWin)
	self._txtDesc.text = isEmulate and self:_getDesc(curActivityId) or string.format("剩余挑战次数：<color=#%s>%d/%d</color>", ColorConst.Blue, Mathf.Max(maxChallengeTimes - curChallengeTimes, 0), maxChallengeTimes)
	self._txtHp.text = string.format("%d/%d", bossLeftHp, bossTotalHp)

	if bossTotalHp > 0 then
		local percent = bossLeftHp / bossTotalHp

		self._fillImg.fillAmount = Mathf.Clamp01(percent)
	else
		self._fillImg.fillAmount = 1
	end
end

function ShenJiBossHpView:_getTitle(curActivityId, isEmulate, isWin)
	local practiceTitle = ShenJiChallengeConfig.instance:getCommonValue(curActivityId, "practiceTitle")

	return isEmulate and practiceTitle or isWin and "战斗胜利" or "战斗失败"
end

function ShenJiBossHpView:_getDesc(curActivityId)
	local practiceTitle = ShenJiChallengeConfig.instance:getCommonValue(curActivityId, "practiceTitle")

	return (string.format(lang("%s的结果不记入实际的Boss血量"), practiceTitle))
end

function ShenJiBossHpView:onExit()
	ShenJiBossHpView.super.onExit(self)
end

return ShenJiBossHpView
