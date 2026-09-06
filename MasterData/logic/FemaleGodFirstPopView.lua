-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/femalegod/view/FemaleGodFirstPopView.lua

module("logic.extensions.femalegod.view.FemaleGodFirstPopView", package.seeall)

local FemaleGodFirstPopView = class("FemaleGodFirstPopView", ViewComponent)

function FemaleGodFirstPopView:ctor()
	FemaleGodFirstPopView.super.ctor(self)
end

function FemaleGodFirstPopView:unbindEvents()
	FemaleGodFirstPopView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnGet)
end

function FemaleGodFirstPopView:bindEvents()
	FemaleGodFirstPopView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnGet, self._onClickBtnGet, self)
end

function FemaleGodFirstPopView:buildUI()
	FemaleGodFirstPopView.super.buildUI(self)

	self._btnGet = self:getGo("btnGet")
	self._bg2 = self:getGo("bg2")
end

function FemaleGodFirstPopView:onExit()
	FemaleGodFirstPopView.super.onExit(self)

	if self._rotateSequence then
		self._rotateSequence:Kill(true)

		self._rotateSequence = nil
	end
end

function FemaleGodFirstPopView:onEnter()
	FemaleGodFirstPopView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_InflationMoneyGainOncePrizeRes, self._onGainOncePrize, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._rotateRate = 2

	if self._rotateSequence then
		self._rotateSequence:Kill(true)

		self._rotateSequence = nil
	end

	GameUtil.setLocalRotation(self._bg2, 0, 0, 0)

	self._rotateSequence = DG.Tweening.DOTween.Sequence()

	local rotateTween = self._bg2.transform:DORotate(Vector3.New(0, 0, 360), self._rotateRate, DG.Tweening.RotateMode.FastBeyond360):SetEase(DG.Tweening.Ease.Linear)

	self._rotateSequence:Append(rotateTween)
	self._rotateSequence:SetLoops(-1)
end

function FemaleGodFirstPopView:_onClickBtnGet()
	FemaleGodController.instance:sendPM_InflationMoneyGainOncePrizeReq(self._activityId)
end

function FemaleGodFirstPopView:_onGainOncePrize()
	self:close()
	UIStateManager.instance:push(ViewName.FemaleGodTipView, self._activityId)
end

return FemaleGodFirstPopView
