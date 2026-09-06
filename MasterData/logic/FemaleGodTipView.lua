-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/femalegod/view/FemaleGodTipView.lua

module("logic.extensions.femalegod.view.FemaleGodTipView", package.seeall)

local FemaleGodTipView = class("FemaleGodTipView", ViewComponent)

function FemaleGodTipView:ctor()
	FemaleGodTipView.super.ctor(self)
end

function FemaleGodTipView:unbindEvents()
	FemaleGodTipView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnJump1)
	GameUtil.rmClickHandler(self._btnSure)
end

function FemaleGodTipView:bindEvents()
	FemaleGodTipView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnSure, self.close, self)
end

function FemaleGodTipView:buildUI()
	FemaleGodTipView.super.buildUI(self)

	self._rewardCell = self:getGo("window/rewardCell")
	self._btnSure = self:getGo("window/btnSure")
	self._txtRewardNum = self:getTxt("window/txtRewardNum")
	self._bg = self:getGo("window/bg3/bg")
end

function FemaleGodTipView:onExit()
	FemaleGodTipView.super.onExit(self)

	if self._rotateSequence then
		self._rotateSequence:Kill(true)

		self._rotateSequence = nil
	end

	MaterialMgr.clearIcon(self._rewardCell)
end

function FemaleGodTipView:onEnter()
	FemaleGodTipView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = checknumber(params[1])
	self._actCfg = FemaleGodConfig.instance:getActivityCfg(self._activityId)
	self._rotateRate = 2

	self:_onSetUI()
end

function FemaleGodTipView:_onSetUI()
	local prizeStr = self._actCfg.oncePrize
	local matType, matId, matNum = MaterialMgr.getMatParams(prizeStr)

	MaterialMgr.setIcon(self._rewardCell, matType, matId, nil, nil)

	self._txtRewardNum.text = matNum

	if self._rotateSequence then
		self._rotateSequence:Kill(true)

		self._rotateSequence = nil
	end

	GameUtil.setLocalRotation(self._bg, 0, 0, 0)

	self._rotateSequence = DG.Tweening.DOTween.Sequence()

	local rotateTween = self._bg.transform:DORotate(Vector3.New(0, 0, 360), self._rotateRate, DG.Tweening.RotateMode.FastBeyond360):SetEase(DG.Tweening.Ease.Linear)

	self._rotateSequence:Append(rotateTween)
	self._rotateSequence:SetLoops(-1)
end

return FemaleGodTipView
