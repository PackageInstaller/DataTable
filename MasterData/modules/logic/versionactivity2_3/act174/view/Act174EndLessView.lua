-- chunkname: @modules/logic/versionactivity2_3/act174/view/Act174EndLessView.lua

module("modules.logic.versionactivity2_3.act174.view.Act174EndLessView", package.seeall)

local Act174EndLessView = class("Act174EndLessView", BaseView)

function Act174EndLessView:onInitView()
	self._goTip1 = gohelper.findChild(self.viewGO, "Tips/#go_Tip1")
	self._txtTip1 = gohelper.findChildText(self.viewGO, "Tips/#go_Tip1/#txt_Tip1")
	self._txtScore = gohelper.findChildText(self.viewGO, "Tips/#go_Tip1/#txt_Score")
	self._btnEscape1 = gohelper.findChildButtonWithAudio(self.viewGO, "Tips/#go_Tip1/#btn_Escape1")
	self._btnEnter1 = gohelper.findChildButtonWithAudio(self.viewGO, "Tips/#go_Tip1/#btn_Enter1")
	self._goTip2 = gohelper.findChild(self.viewGO, "Tips/#go_Tip2")
	self._btnBet1 = gohelper.findChildButtonWithAudio(self.viewGO, "Tips/#go_Tip2/go_BetPercent/#btn_Bet1")
	self._txtBet1 = gohelper.findChildText(self.viewGO, "Tips/#go_Tip2/go_BetPercent/#btn_Bet1/#txt_Bet1")
	self._btnBet2 = gohelper.findChildButtonWithAudio(self.viewGO, "Tips/#go_Tip2/go_BetPercent/#btn_Bet2")
	self._txtBet2 = gohelper.findChildText(self.viewGO, "Tips/#go_Tip2/go_BetPercent/#btn_Bet2/#txt_Bet2")
	self._btnBet3 = gohelper.findChildButtonWithAudio(self.viewGO, "Tips/#go_Tip2/go_BetPercent/#btn_Bet3")
	self._txtBet3 = gohelper.findChildText(self.viewGO, "Tips/#go_Tip2/go_BetPercent/#btn_Bet3/#txt_Bet3")
	self._txtCoinNum = gohelper.findChildText(self.viewGO, "Tips/#go_Tip2/go_topright/#go_Coin/#txt_CoinCnt2")
	self._goTip3 = gohelper.findChild(self.viewGO, "Tips/#go_Tip3")
	self._txtTip3 = gohelper.findChildText(self.viewGO, "Tips/#go_Tip3/txt_Tip3")
	self._txtcurScore = gohelper.findChildText(self.viewGO, "Tips/#go_Tip3/go_Score/#txt_curScore")
	self._txtunbetScore = gohelper.findChildText(self.viewGO, "Tips/#go_Tip3/go_Score/#txt_unbetScore")
	self._txtbetScore = gohelper.findChildText(self.viewGO, "Tips/#go_Tip3/go_Score/#txt_betScore")
	self._txttimes = gohelper.findChildText(self.viewGO, "Tips/#go_Tip3/go_Score/#txt_times")
	self._btnEscape3 = gohelper.findChildButtonWithAudio(self.viewGO, "Tips/#go_Tip3/#btn_Escape3")
	self._btnEnter3 = gohelper.findChildButtonWithAudio(self.viewGO, "Tips/#go_Tip3/#btn_Enter3")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act174EndLessView:addEvents()
	self._btnEscape1:AddClickListener(self._btnEscape1OnClick, self)
	self._btnEnter1:AddClickListener(self._btnEnter1OnClick, self)
	self._btnBet1:AddClickListener(self._btnBet1OnClick, self)
	self._btnBet2:AddClickListener(self._btnBet2OnClick, self)
	self._btnBet3:AddClickListener(self._btnBet3OnClick, self)
	self._btnEscape3:AddClickListener(self._btnEscape3OnClick, self)
	self._btnEnter3:AddClickListener(self._btnEnter3OnClick, self)
end

function Act174EndLessView:removeEvents()
	self._btnEscape1:RemoveClickListener()
	self._btnEnter1:RemoveClickListener()
	self._btnBet1:RemoveClickListener()
	self._btnBet2:RemoveClickListener()
	self._btnBet3:RemoveClickListener()
	self._btnEscape3:RemoveClickListener()
	self._btnEnter3:RemoveClickListener()
end

function Act174EndLessView:_btnEscape1OnClick()
	GameFacade.showMessageBox(MessageBoxIdDefine.Act174EndLessEscape, MsgBoxEnum.BoxType.Yes_No, self.notEnterGame, nil, nil, self)
end

function Act174EndLessView:notEnterGame()
	Activity174Rpc.instance:sendEnterEndLessAct174FightRequest(self.actId, false, self.betLevel, self.closeThis, self)
end

function Act174EndLessView:_btnEnter1OnClick()
	GameFacade.showMessageBox(MessageBoxIdDefine.Act174EndLessChallenge1, MsgBoxEnum.BoxType.Yes_No, self.startBet, nil, nil, self)
end

function Act174EndLessView:startBet()
	gohelper.setActive(self._goTip1, false)
	gohelper.setActive(self._goTip2, true)
	gohelper.setActive(self._goTip3, false)
	self:refreshBetTxt()
	Activity174Controller.instance:dispatchEvent(Activity174Event.SureEnterEndlessMode)
end

function Act174EndLessView:refreshBetTxt()
	local curScore = self.gameInfo.score

	for i = 1, 3 do
		local betCo = self.betConfigList[i]

		if betCo then
			local num = curScore * betCo.ratio / 1000

			self["_txtBet" .. i].text = math.floor(num + 0.5)
		else
			gohelper.setActive(self["_btnBet" .. i], false)
		end
	end
end

function Act174EndLessView:_btnBet1OnClick()
	self.betLevel = 1

	self:enterGame()
end

function Act174EndLessView:_btnBet2OnClick()
	self.betLevel = 2

	self:enterGame()
end

function Act174EndLessView:_btnBet3OnClick()
	self.betLevel = 3

	self:enterGame()
end

function Act174EndLessView:enterGame()
	Activity174Rpc.instance:sendEnterEndLessAct174FightRequest(self.actId, true, self.betLevel, self.enterGameReply, self)
end

function Act174EndLessView:enterGameReply(cmd, resultCode, msg)
	if resultCode == 0 then
		Activity174Controller.instance:dispatchEvent(Activity174Event.ClickStartGame)
		self:closeThis()
	end
end

function Act174EndLessView:_btnEscape3OnClick()
	GameFacade.showMessageBox(MessageBoxIdDefine.Act174EndLessEscape, MsgBoxEnum.BoxType.Yes_No, self.endGame, nil, nil, self)
end

function Act174EndLessView:endGame()
	Activity174Rpc.instance:sendEndAct174GameRequest(self.actId, self.endGameReply, self)
end

function Act174EndLessView:endGameReply(cmd, resultCode, msg)
	if resultCode == 0 then
		FightController.instance:dispatchEvent(FightEvent.DouQuQuSettlementFinish)
		self:closeThis()
	end
end

function Act174EndLessView:_btnEnter3OnClick()
	Activity174Controller.instance:dispatchEvent(Activity174Event.ClickStartGame)
	self:closeThis()
end

function Act174EndLessView:_editableInitView()
	return
end

function Act174EndLessView:onUpdateParam()
	return
end

function Act174EndLessView:onOpen()
	self.actId = Activity174Model.instance:getCurActId()
	self.gameInfo = Activity174Model.instance:getActInfo():getGameInfo()
	self.betConfigList = lua_activity174_bet.configDict[self.actId]

	if self.viewParam and self.viewParam.showScore then
		self:betEnd()
	else
		self.betLevel = 0

		self:refreshUI()
	end
end

function Act174EndLessView:refreshUI()
	gohelper.setActive(self._goTip1, true)
	gohelper.setActive(self._goTip2, false)
	gohelper.setActive(self._goTip3, false)

	local maxRound = Activity174Config.instance:getMaxRound(self.actId, self.gameInfo.gameCount)
	local str = luaLang("act174_endless_tip1")

	self._txtTip1.text = GameUtil.getSubPlaceholderLuaLangOneParam(str, maxRound)
	self._txtScore.text = self.gameInfo.score
	self._txtCoinNum.text = self.gameInfo.score
end

function Act174EndLessView:betEnd()
	local turnCo = Activity174Config.instance:getTurnCo(self.actId, self.gameInfo.gameCount - 1)

	if turnCo then
		if not (turnCo.point / 1000) then
			local point = ""

			gohelper.setActive(self._goTip1, false)
			gohelper.setActive(self._goTip2, false)
			gohelper.setActive(self._goTip3, true)

			local betScore = self.gameInfo:getBetScore()
			local curScore = self.gameInfo.score

			self._txtcurScore.text = curScore + betScore
			self._txtunbetScore.text = curScore
			self._txtbetScore.text = math.floor(betScore / point + 0.5)
			self._txttimes.text = point
			turnCo = Activity174Config.instance:getTurnCo(self.actId, self.gameInfo.gameCount)
			point = turnCo and turnCo.point / 1000 or ""

			local txt = luaLang("act174_endless_tip3")

			self._txtTip3.text = GameUtil.getSubPlaceholderLuaLangOneParam(txt, point)
		end
	end
end

function Act174EndLessView:onClose()
	return
end

function Act174EndLessView:onDestroyView()
	return
end

return Act174EndLessView
