-- chunkname: @modules/logic/autochess/main/view/game/AutoChessGameView.lua

module("modules.logic.autochess.main.view.game.AutoChessGameView", package.seeall)

local AutoChessGameView = class("AutoChessGameView", BaseView)

function AutoChessGameView:onInitView()
	self._gotouch = gohelper.findChild(self.viewGO, "UI/#go_touch")
	self._goFightRoot = gohelper.findChild(self.viewGO, "UI/#go_FightRoot")
	self._btnStop = gohelper.findChildButtonWithAudio(self.viewGO, "UI/#go_FightRoot/#btn_Stop")
	self._btnResume = gohelper.findChildButtonWithAudio(self.viewGO, "UI/#go_FightRoot/#btn_Resume")
	self._btnSkip = gohelper.findChildButtonWithAudio(self.viewGO, "UI/#go_FightRoot/#btn_Skip")
	self._btnSpeed1 = gohelper.findChildButtonWithAudio(self.viewGO, "UI/#go_FightRoot/#btn_Speed1")
	self._btnSpeed2 = gohelper.findChildButtonWithAudio(self.viewGO, "UI/#go_FightRoot/#btn_Speed2")
	self._goDamageTip = gohelper.findChild(self.viewGO, "UI/#go_DamageTip")
	self._txtDamageTip = gohelper.findChildText(self.viewGO, "UI/#go_DamageTip/#txt_DamageTip")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AutoChessGameView:addEvents()
	self._btnStop:AddClickListener(self._btnStopOnClick, self)
	self._btnResume:AddClickListener(self._btnResumeOnClick, self)
	self._btnSkip:AddClickListener(self._btnSkipOnClick, self)
	self._btnSpeed1:AddClickListener(self._btnSpeed1OnClick, self)
	self._btnSpeed2:AddClickListener(self._btnSpeed2OnClick, self)
end

function AutoChessGameView:removeEvents()
	self._btnStop:RemoveClickListener()
	self._btnResume:RemoveClickListener()
	self._btnSkip:RemoveClickListener()
	self._btnSpeed1:RemoveClickListener()
	self._btnSpeed2:RemoveClickListener()
end

function AutoChessGameView:_onEscapeBtnClick()
	return
end

function AutoChessGameView:_btnSpeed1OnClick()
	self.curSpeed = 2

	AutoChessHelper.setPlayerPrefs("AutoChessFightSpeed", self.curSpeed)
	self:refreshSpeed()
end

function AutoChessGameView:_btnSpeed2OnClick()
	self.curSpeed = 1

	AutoChessHelper.setPlayerPrefs("AutoChessFightSpeed", self.curSpeed)
	self:refreshSpeed()
end

function AutoChessGameView:_btnResumeOnClick()
	gohelper.setActive(self._btnStop, true)
	gohelper.setActive(self._btnResume, false)
	AutoChessController.instance:dispatchEvent(AutoChessEvent.StopFight, false)
end

function AutoChessGameView:_btnStopOnClick()
	gohelper.setActive(self._btnStop, false)
	gohelper.setActive(self._btnResume, true)
	AutoChessController.instance:dispatchEvent(AutoChessEvent.StopFight, true)
end

function AutoChessGameView:_btnSkipOnClick()
	AutoChessController.instance:dispatchEvent(AutoChessEvent.SkipFight)
end

function AutoChessGameView:_editableInitView()
	self.moduleId = AutoChessModel.instance.moduleId

	NavigateMgr.instance:addEscape(self.viewName, self._onEscapeBtnClick, self)

	self.collectionTbl = {}

	gohelper.setActive(self._goCollectionItem, false)
end

function AutoChessGameView:onOpen()
	self.addEventCb(self, AutoChessController.instance, AutoChessEvent.StartFight, self.onStartFight, self)
	self.addEventCb(self, AutoChessController.instance, AutoChessEvent.EndFight, self.onEndFight, self)
	self.addEventCb(self, AutoChessController.instance, AutoChessEvent.NextRound, self.onNextRound, self)
	self.addEventCb(self, AutoChessController.instance, AutoChessEvent.CheckEnemyTeam, self.onCheckEnemy, self)

	self.chessMo = AutoChessModel.instance:getChessMo()
	self.actId = Activity182Model.instance:getCurActId()
	self.curSpeed = AutoChessHelper.getPlayerPrefs("AutoChessFightSpeed", 1)

	self:refreshUI()
end

function AutoChessGameView:onClose()
	self:recoverSpeed()
end

function AutoChessGameView:onDestroyView()
	TaskDispatcher.cancelTask(self.delayShowFightRoot, self)
end

function AutoChessGameView:refreshUI()
	if self.moduleId == AutoChessEnum.ModuleId.Friend then
		return
	end

	if self.chessMo.svrFight.roundType == AutoChessEnum.RoundType.BOSS then
		self._txtDamageTip.text = luaLang("autochess_gameview_bosslimit")
	else
		local roundCo = lua_auto_chess_round.configDict[self.actId][self.chessMo.sceneRound]
		local txt1 = luaLang("autochess_gameview_damagelimit")

		self._txtDamageTip.text = GameUtil.getSubPlaceholderLuaLangOneParam(txt1, roundCo.maxdamage)
	end
end

function AutoChessGameView:onStartFight()
	ViewMgr.instance:openView(ViewName.AutoChessStartFightView)
	TaskDispatcher.runDelay(self.delayShowFightRoot, self, 0.5)
end

function AutoChessGameView:delayShowFightRoot()
	self:refreshSpeed()
	gohelper.setActive(self._gotouch, false)
	gohelper.setActive(self._goFightRoot, true)
	gohelper.setActive(self._goDamageTip, self.moduleId ~= AutoChessEnum.ModuleId.Friend)
end

function AutoChessGameView:onEndFight()
	self:recoverSpeed()

	local resultData = AutoChessModel.instance.resultData

	if resultData then
		AutoChessController.instance:openResultView()
	else
		AutoChessController.instance:onResultViewClose()
	end
end

function AutoChessGameView:onNextRound()
	self:refreshUI()
	gohelper.setActive(self._btnStop, true)
	gohelper.setActive(self._btnResume, false)
	gohelper.setActive(self._gotouch, true)
	gohelper.setActive(self._goFightRoot, false)
	gohelper.setActive(self._goDamageTip, false)
end

function AutoChessGameView:onCheckEnemy(isCheck)
	gohelper.setActive(self._goDamageTip, isCheck)
end

function AutoChessGameView:refreshSpeed()
	GameTimeMgr.instance:setTimeScale(GameTimeMgr.TimeScaleType.AutoChess, self.curSpeed)
	gohelper.setActive(self._btnSpeed1, self.curSpeed == 1)
	gohelper.setActive(self._btnSpeed2, self.curSpeed == 2)
end

function AutoChessGameView:recoverSpeed()
	GameTimeMgr.instance:setTimeScale(GameTimeMgr.TimeScaleType.AutoChess, 1)
end

return AutoChessGameView
