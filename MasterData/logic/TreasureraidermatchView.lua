-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/treasureraider/view/TreasureraidermatchView.lua

module("logic.extensions.treasureraider.view.TreasureraidermatchView", package.seeall)

local TreasureraidermatchView = class("TreasureraidermatchView", BountyPKCompeteMatchView)

function TreasureraidermatchView:ctor()
	TreasureraidermatchView.super.ctor(self)
end

function TreasureraidermatchView:unbindEvents()
	TreasureraidermatchView.super.unbindEvents(self)
end

function TreasureraidermatchView:bindEvents()
	TreasureraidermatchView.super.bindEvents(self)
end

function TreasureraidermatchView:buildUI()
	TreasureraidermatchView.super.buildUI(self)

	self._animator = self:getGo("container"):GetComponent(ComponentType.Animator)
end

function TreasureraidermatchView:onExit()
	TreasureraidermatchView.super.onExit(self)
	removetimer(self._delayMatchSuccessRes, self)
	removetimer(self._delayClose, self)
end

function TreasureraidermatchView:onEnter()
	TreasureraidermatchView.super.onEnter(self)
	self._animator:Play("dafuweng_match_start")
end

function TreasureraidermatchView:_onMatchingSuccessRes(status, msg)
	removetimer(self._delayMatchSuccessRes, self)

	local sec = math.random(2, 4)

	self._cacheMsg = {
		status = status,
		msg = msg
	}

	settimer(sec, self._delayMatchSuccessRes, self)
end

function TreasureraidermatchView:_delayMatchSuccessRes()
	removetimer(self._delayMatchSuccessRes, self)

	if self._cacheMsg.status == 0 then
		self._animator:Play("dafuweng_match_end")
		goutil.setActive(self._matching, false)
		TreasureRaiderModel.instance:onOpMapGetInfoRes(self._cacheMsg.msg)
		TREnterSceneSequenceController.instance:onReset()
		TREnterSceneSequenceController.instance:enterScene()
		settimer(1, self._delayClose, self)
	else
		TreasureRaiderController.instance:onOpMapGetInfoFail()
		TipsFacade.instance:openCommonTips(lang("当前未寻找到对手，请在此重试"))
		self:_onMatchingFailRes()
	end
end

function TreasureraidermatchView:_delayClose()
	self._matchModel:setMatchingState(false)
	self:_applyDispose(BountyPkCompeteMatchModel.MatchSuccess)
end

return TreasureraidermatchView
