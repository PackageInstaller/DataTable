-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aceteam/view/MatchingPopupView.lua

module("logic.extensions.numberbomb.view.MatchingPopupView", package.seeall)

local MatchingPopupView = class("MatchingPopupView", ViewComponent)

function MatchingPopupView:ctor()
	MatchingPopupView.super.ctor(self)

	self._isSendMsg = false
	self.totalWaitTime = 2
	self._waitTime = self.totalWaitTime
	self._sussTime = 0
end

function MatchingPopupView:bindEvents()
	MatchingPopupView.super.bindEvents(self)
	self._cancleBtn:AddClickListener(self._onClickCancleBtn, self)
end

function MatchingPopupView:unbindEvents()
	MatchingPopupView.super.unbindEvents(self)
	self._cancleBtn:RemoveClickListener()
end

function MatchingPopupView:onExit()
	MatchingPopupView.super.onExit(self)

	if self._pmEff then
		UIEffectManager.instance:stopEffect(self._pmEff)
	end

	self._pmEff = nil

	removetimer(self._calculationSurplusTime, self)
	GlobalDispatcher:removeListener(GlobalNotify.NumberGameMatch, self._updataGameMatchState, self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdataPlayerGameInfo, self._startNumberGame, self)
end

function MatchingPopupView:destroyUI()
	MatchingPopupView.super.destroyUI(self)
end

function MatchingPopupView:buildUI()
	MatchingPopupView.super.buildUI(self)

	self._cancleBtn = self:getBtn("cancleBtn")
	self._cancleTxt = goutil.findChildTextComponent(self.mainGO, "cancleBtn/cancleTxt")
	self._supTimeTxt = goutil.findChildTextComponent(self.mainGO, "supTimeTxt")
end

function MatchingPopupView:onEnter()
	MatchingPopupView.super.onEnter(self)

	self._timer = 0
	self.totalTime = checknumber(AceTeamConfig.instance:getCommonValue("MAX_MATCH_TIME"))
	self._supTimeTxt.text = GameUtil.FormatTimeSymbol(self._timer)
	self._waitTime = self.totalWaitTime
	self._sussTime = 0
	self._cancleTxt.text = lang("matchingpopupview__1")

	settimer(1, self._calculationSurplusTime, self, true)

	self.isMatching = false

	local effPath = "fx_ui_zdsz/fx_ui_zdsz_pipei.prefab"

	self._pmEff = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 0, 0, true, nil, nil, nil, self)

	self._pmEff:setParent(self.mainGO.transform)
	self._pmEff:setLocalPos(0, 0, 0)
	self._pmEff:setScale(1)
end

function MatchingPopupView:_onClickCancleBtn()
	if self.isMatching == true then
		AceTeamController.instance:sendCancelMatch()
	end

	if self._sussTime > 0 then
		return
	end

	if not self._isSendMsg then
		removetimer(self._calculationSurplusTime, self)
		self:_updataGameMatchState(2)

		return
	end
end

function MatchingPopupView:_calculationSurplusTime()
	self._timer = self._timer + 1

	if self._timer > self.totalTime + self.totalWaitTime then
		self._supTimeTxt.text = lang("matchingpopupview__2")

		removetimer(self._calculationSurplusTime, self)
		self:_updataGameMatchState(3)
		AceTeamController.instance:sendCancelMatch()

		return
	end

	self._supTimeTxt.text = GameUtil.FormatTimeSymbol(self._timer)

	if self._waitTime > 0 then
		self._waitTime = self._waitTime - 1

		if self._waitTime <= 0 then
			self.isMatching = true

			AceTeamController.instance:sendGoMatch()
		end
	end

	if self._sussTime > 0 then
		self._sussTime = self._sussTime - 1

		if self._sussTime <= 0 then
			self:close()
		end
	end
end

function MatchingPopupView:_updataGameMatchState(state)
	state = checknumber(state)

	if state == 1 then
		self._isSendMsg = true
	elseif state == 2 then
		FloatWordMgr.instance:show(lang("matchingpopupview__1"))
		self:close()
	else
		FloatWordMgr.instance:show(lang("aceteamcontroller__8"))
		self:close()
	end
end

function MatchingPopupView:_startNumberGame(opType, sortIndex, param)
	if opType == nil or sortIndex == nil then
		self._sussTime = 2
		self._cancleTxt.text = lang("matchingpopupview__4")
	end
end

return MatchingPopupView
