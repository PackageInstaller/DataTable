-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shenjichallenge/view/ShenJiBossPassView.lua

module("logic.extensions.shenjichallenge.view.ShenJiBossPassView", package.seeall)

local ShenJiBossPassView = class("ShenJiBossPassView", ViewComponent)

function ShenJiBossPassView:buildUI()
	ShenJiBossPassView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._tip = self:getGo("tip")
	self._txtDesc1 = self:getTxt("img/txtDesc1")
	self._txtDesc2 = self:getTxt("txtDesc2")
end

function ShenJiBossPassView:bindEvents()
	ShenJiBossPassView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
end

function ShenJiBossPassView:unbindEvents()
	ShenJiBossPassView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function ShenJiBossPassView:onEnter()
	ShenJiBossPassView.super.onEnter(self)

	self._activityId = self:getFirstParam()

	self:_initCloseBtn()
	self:_initDescTxt()
end

function ShenJiBossPassView:onExit()
	ShenJiBossPassView.super.onExit(self)
end

function ShenJiBossPassView:_initCloseBtn()
	goutil.setActive(self._btnClose.gameObject, false)
	goutil.setActive(self._tip, false)
	TweenUtil.DoDelay(1, function()
		goutil.setActive(self._btnClose.gameObject, true)
		goutil.setActive(self._tip, true)
	end)
end

function ShenJiBossPassView:_initDescTxt()
	local isPassAll = ShenJiChallengeModel.instance:isPassAllBossStage(self._activityId)

	self._txtDesc1.text = isPassAll and "恭喜通关" or "关卡解锁"

	local txt1 = "您已完成本次挑战所有关卡"
	local txt2 = "新关卡需次日05:00才可以挑战\n"

	self._txtDesc2.text = isPassAll and txt1 or txt2
end

return ShenJiBossPassView
