-- chunkname: @modules/logic/versionactivity3_7/anniversary3/view/guessgame/GuessGamePlayResultView.lua

module("modules.logic.versionactivity3_7.anniversary3.view.guessgame.GuessGamePlayResultView", package.seeall)

local GuessGamePlayResultView = class("GuessGamePlayResultView", BaseView)

function GuessGamePlayResultView:onInitView()
	self._goclick = gohelper.findChild(self.viewGO, "root/bg/#go_click")
	self._gobtns = gohelper.findChild(self.viewGO, "root/#go_btns")
	self._btnquit = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_btns/#btn_quit")
	self._btnrestart = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_btns/#btn_restart")
	self._goscore = gohelper.findChild(self.viewGO, "root/#go_score")
	self._txtscore = gohelper.findChildText(self.viewGO, "root/#go_score/#txt_score")
	self._goreward = gohelper.findChild(self.viewGO, "root/#go_reward")
	self._txtreward = gohelper.findChildText(self.viewGO, "root/#go_reward/#txt_reward")
	self._imageicon = gohelper.findChildImage(self.viewGO, "root/#go_reward/#image_icon")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function GuessGamePlayResultView:addEvents()
	self._btnquit:AddClickListener(self._btnquitOnClick, self)
	self._btnrestart:AddClickListener(self._btnrestartOnClick, self)
end

function GuessGamePlayResultView:removeEvents()
	self._btnquit:RemoveClickListener()
	self._btnrestart:RemoveClickListener()
end

function GuessGamePlayResultView:_btnquitOnClick()
	GuessGameController.instance:exitGame()
end

function GuessGamePlayResultView:_btnrestartOnClick()
	GuessGameController.instance:restartGame()
end

function GuessGamePlayResultView:_editableInitView()
	self._actId = VersionActivity3_7Enum.ActivityId.Anniversary3GuessGame

	NavigateMgr.instance:addEscape(self.viewName, self._onEscapelick, self)

	self._btnclose = gohelper.getClick(self._goclick)

	self._btnclose:AddClickListener(self._btnquitOnClick, self)
end

function GuessGamePlayResultView:_onEscapelick()
	self:_btnquitOnClick()
end

function GuessGamePlayResultView:onOpen()
	AudioMgr.instance:trigger(AudioEnum3_7.Anniversary3.play_ui_beiai_kapai_settlement_bonus)
	self:_refreshUI()
end

function GuessGamePlayResultView:_refreshUI()
	local isFirstShow = self.viewParam
	local multi = isFirstShow and Activity234Config.instance:getConstNumberValue(GuessGameEnum.ConstId.DailyFirstBonusMulti) or 1
	local resultScore = GuessGameModel.instance:getResultScoreByGameScore()

	self._txtscore.text = resultScore
	self._txtreward.text = multi * resultScore
end

function GuessGamePlayResultView:onClose()
	GuessGameController.instance:dispatchEvent(GuessGameEvent.OnFinishGameBackToMain)
end

function GuessGamePlayResultView:onDestroyView()
	self._btnclose:RemoveClickListener()
end

return GuessGamePlayResultView
