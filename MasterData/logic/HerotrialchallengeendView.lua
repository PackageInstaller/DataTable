-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/herotrial/view/HerotrialchallengeendView.lua

module("logic.extensions.herotrial.view.HerotrialchallengeendView", package.seeall)

local HerotrialchallengeendView = class("HerotrialchallengeendView", ViewComponent)

function HerotrialchallengeendView:ctor()
	HerotrialchallengeendView.super.ctor(self)
end

function HerotrialchallengeendView:buildUI()
	HerotrialchallengeendView.super.buildUI(self)

	self._btnOk = self:getBtn("btnOk")
	self._btnClose = self:getBtn("btnClose")
end

function HerotrialchallengeendView:bindEvents()
	HerotrialchallengeendView.super.bindEvents(self)
	self._btnOk:AddClickListener(self._onClickClose, self)
	self._btnClose:AddClickListener(self._onClickClose, self)

	self._txtDamage = goutil.findChildTextComponent(self.mainGO, "txtDamage")
	self._txtBestRecord = goutil.findChildTextComponent(self.mainGO, "txtBestRecord")
end

function HerotrialchallengeendView:unbindEvents()
	HerotrialchallengeendView.super.unbindEvents(self)
	self._btnOk:RemoveClickListener()
	self._btnClose:RemoveClickListener()
end

function HerotrialchallengeendView:destroyUI()
	HerotrialchallengeendView.super.destroyUI(self)
end

function HerotrialchallengeendView:onEnter()
	HerotrialchallengeendView.super.onEnter(self)

	self._callback = self:getOpenParam()[1]

	local curDamage = HerotrialModel.instance:getCurDamage()
	local highestDam = HerotrialModel.instance:getHighestDamage()

	self._txtDamage.text = string.format("%s", curDamage)
	self._txtBestRecord.text = string.format("%s", highestDam)
end

function HerotrialchallengeendView:onEnterFinished()
	HerotrialchallengeendView.super.onEnterFinished(self)
end

function HerotrialchallengeendView:onExit()
	if self._callback then
		self._callback()

		self._callback = nil
	end

	HerotrialchallengeendView.super.onExit(self)
end

function HerotrialchallengeendView:onExitFinished()
	HerotrialchallengeendView.super.onExitFinished(self)
end

function HerotrialchallengeendView:_onClickClose()
	BattleController.instance:endBattle()
end

return HerotrialchallengeendView
