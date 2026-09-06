-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originelizabeth/view/OriginelizabethmainView.lua

module("logic.extensions.originelizabeth.view.OriginelizabethmainView", package.seeall)

local OriginelizabethmainView = class("OriginelizabethmainView", FanRuiChallengeMainView)

function OriginelizabethmainView:ctor()
	OriginelizabethmainView.super.ctor(self)
end

function OriginelizabethmainView:unbindEvents()
	OriginelizabethmainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnJump3)
	GameUtil.rmClickHandler(self._btnJump4)
end

function OriginelizabethmainView:bindEvents()
	OriginelizabethmainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnJump3, self._onClickJump3, self)
	GameUtil.addClickHandler(self._btnJump4, self._onClickJump4, self)
end

function OriginelizabethmainView:buildUI()
	OriginelizabethmainView.super.buildUI(self)

	self._btnGainBuff = self:getGo("buffCol/btnGain")
	self._txtDescBuff = self:getTxt("buffCol/txtDesc")
	self._redBuff = self:getGo("buffCol/cell/red")
	self._btnJump3 = self:getGo("btnJump3")
	self._btnJump4 = self:getGo("btnJump4")
end

function OriginelizabethmainView:onExit()
	OriginelizabethmainView.super.onExit(self)
	SignInBuffController.instance:unregSignInBuffPartSimple(self._activityId, self._btnGainBuff)
end

function OriginelizabethmainView:onEnter()
	OriginelizabethmainView.super.onEnter(self)
	SignInBuffController.instance:regSignInBuffPartSimple(self._activityId, self._btnGainBuff, function(param)
		self:_updateBuffUI(param)
	end)
end

function OriginelizabethmainView:_updateBuffUI(param)
	GameUtil.SetActive(self._redBuff, param.isCanGain)

	local buffCfg = param.buffCfg

	if buffCfg then
		self._txtDescBuff.text = buffCfg.des or "点击激活Buff"
	end
end

function OriginelizabethmainView:_onClickLevel(index)
	if not self._isRecieveRes then
		return
	end

	if not FanRuiChallengeModel.instance:isBigLevelUnlock(self._activityId, index) then
		FloatWordMgr.instance:show("未解锁")

		return
	end

	if FanRuiChallengeModel.instance:isPassBigLevel(self._activityId, index) then
		FloatWordMgr.instance:show("已通关")

		return
	end

	if index == FanRuiChallengeModel.StageLife then
		UIStateManager.instance:push(ViewName.OriginelizabethlifeView, self._activityId)
	elseif index == FanRuiChallengeModel.StageDestiny then
		UIStateManager.instance:push(ViewName.OriginelizabethdestinyView, self._activityId)
	elseif index == FanRuiChallengeModel.StageControl then
		UIStateManager.instance:push(ViewName.OriginelizabethcontrolView, self._activityId)
	end
end

function OriginelizabethmainView:_onClickJump3()
	GotoMgr.gotoByString(self._cfgActivity.jumpTo3)
end

function OriginelizabethmainView:_onClickJump4()
	GotoMgr.gotoByString(self._cfgActivity.jumpTo4)
end

function OriginelizabethmainView:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, "originelizabethmainview_rule")
end

return OriginelizabethmainView
