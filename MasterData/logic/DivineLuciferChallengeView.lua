-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fantian/view/DivineLuciferChallengeView.lua

module("logic.extensions.fantian.view.DivineLuciferChallengeView", package.seeall)

local DivineLuciferChallengeView = class("DivineLuciferChallengeView", FantianchallengeView)

function DivineLuciferChallengeView:unbindEvents()
	DivineLuciferChallengeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnGift)
end

function DivineLuciferChallengeView:bindEvents()
	DivineLuciferChallengeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnGift, self._onClickGift, self)
end

function DivineLuciferChallengeView:buildUI()
	DivineLuciferChallengeView.super.buildUI(self)

	self._btnGainBuff = self:getGo("buffCol/btnGain")
	self._txtLvBuff = self:getTxt("buffCol/Lv/txt")
	self._txtDescBuff = self:getTxt("buffCol/txtDesc")
	self._rdGainBuff = self:getGo("buffCol/cell/rd")
	self._btnGift = self:getGo("btnGift")
end

function DivineLuciferChallengeView:onExit()
	DivineLuciferChallengeView.super.onExit(self)
	SignInBuffController.instance:unregSignInBuffPartSimple(self._activityId, self._btnGainBuff)
end

function DivineLuciferChallengeView:onEnter()
	DivineLuciferChallengeView.super.onEnter(self)
	SignInBuffController.instance:regSignInBuffPartSimple(self._activityId, self._btnGainBuff, function(param)
		goutil.setActive(self._rdGainBuff, param.isCanGain)

		local buffCfg = param.buffCfg

		self._txtLvBuff.text = string.format("Lv.%s", param.buffLevel)

		if buffCfg then
			self._txtDescBuff.text = buffCfg.des or "点击激活Buff"
		end
	end)
end

function DivineLuciferChallengeView:_onClickBtnChallenge()
	UIStateManager.instance:push(ViewName.DivineLuciferLevelSelectView, self._activityId)
end

function DivineLuciferChallengeView:_onClickGift()
	local str = self._actCfg.giftJump

	GotoMgr.gotoByString(str)
end

return DivineLuciferChallengeView
