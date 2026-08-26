-- chunkname: @modules/logic/versionactivity2_6/dicehero/view/DiceHeroResultView.lua

module("modules.logic.versionactivity2_6.dicehero.view.DiceHeroResultView", package.seeall)

local DiceHeroResultView = class("DiceHeroResultView", BaseView)

function DiceHeroResultView:onInitView()
	self._gosuccess = gohelper.findChild(self.viewGO, "#go_success")
	self._gofail = gohelper.findChild(self.viewGO, "#go_fail")
	self._btnClick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_click")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._btnquitgame = gohelper.findChildButtonWithAudio(self.viewGO, "#go_btns/#btn_quitgame")
	self._btnrestart = gohelper.findChildButtonWithAudio(self.viewGO, "#go_btns/#btn_restart")
end

function DiceHeroResultView:addEvents()
	self._btnClick:AddClickListener(self._onClickClose, self)
	self._btnquitgame:AddClickListener(self.closeThis, self)
	self._btnrestart:AddClickListener(self._onClickRestart, self)
end

function DiceHeroResultView:removeEvents()
	self._btnClick:RemoveClickListener()
	self._btnquitgame:RemoveClickListener()
	self._btnrestart:RemoveClickListener()
end

function DiceHeroResultView:onOpen()
	gohelper.setActive(self._gosuccess, self.viewParam.status == DiceHeroEnum.GameStatu.Win)
	gohelper.setActive(self._gofail, self.viewParam.status == DiceHeroEnum.GameStatu.Lose)

	local lastEnterLevelId = DiceHeroModel.instance.lastEnterLevelId
	local co = lua_dice_level.configDict[lastEnterLevelId]

	self.co = co

	local showBtn = false

	if co then
		showBtn = self.viewParam.status == DiceHeroEnum.GameStatu.Lose and co.mode == 1
	end

	gohelper.setActive(self._gobtns, showBtn)
	gohelper.setActive(self._btnClick, not showBtn)

	if self.viewParam.status == DiceHeroEnum.GameStatu.Win then
		AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_pkls_endpoint_arrival)
	else
		AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_pkls_challenge_fail)
	end
end

function DiceHeroResultView:_onClickRestart()
	DiceHeroStatHelper.instance:resetGameDt()
	DiceHeroRpc.instance:sendDiceHeroEnterFight(self.co.id, self._onEnterFight, self)
end

function DiceHeroResultView:_onClickClose()
	if self.co then
		local gameInfo = DiceHeroModel.instance:getGameInfo(self.co.chapter)

		if gameInfo:hasReward() and gameInfo.currLevel == DiceHeroModel.instance.lastEnterLevelId then
			ViewMgr.instance:openView(ViewName.DiceHeroTalkView, {
				co = self.co
			})
		elseif self.co.mode == 2 and self.viewParam.status == DiceHeroEnum.GameStatu.Win and self.co.dialog ~= 0 then
			ViewMgr.instance:openView(ViewName.DiceHeroTalkView, {
				co = self.co
			})
		end
	end

	self:closeThis()
end

function DiceHeroResultView:_onEnterFight(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	self._restart = true

	ViewMgr.instance:openView(ViewName.DiceHeroGameView)
	self:closeThis()
end

function DiceHeroResultView:onClose()
	if not self._restart then
		ViewMgr.instance:closeView(ViewName.DiceHeroGameView)
	end

	DiceHeroFightModel.instance.finishResult = DiceHeroEnum.GameStatu.None

	if DiceHeroModel.instance.isUnlockNewChapter then
		ViewMgr.instance:closeView(ViewName.DiceHeroLevelView)
	end
end

return DiceHeroResultView
