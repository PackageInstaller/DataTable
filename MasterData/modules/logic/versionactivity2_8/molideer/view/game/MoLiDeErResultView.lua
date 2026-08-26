-- chunkname: @modules/logic/versionactivity2_8/molideer/view/game/MoLiDeErResultView.lua

module("modules.logic.versionactivity2_8.molideer.view.game.MoLiDeErResultView", package.seeall)

local MoLiDeErResultView = class("MoLiDeErResultView", BaseView)

function MoLiDeErResultView:onInitView()
	self._gotop = gohelper.findChild(self.viewGO, "#go_top")
	self._txtstage = gohelper.findChildText(self.viewGO, "#go_top/#txt_stage")
	self._txtname = gohelper.findChildText(self.viewGO, "#go_top/#txt_name")
	self._gosuccess = gohelper.findChild(self.viewGO, "#go_success")
	self._gofail = gohelper.findChild(self.viewGO, "#go_fail")
	self._gotargetitem = gohelper.findChild(self.viewGO, "targets/#go_targetitem")
	self._txttaskdesc = gohelper.findChildText(self.viewGO, "targets/#go_targetitem/#txt_taskdesc")
	self._gounfinish = gohelper.findChild(self.viewGO, "targets/#go_targetitem/result/#go_unfinish")
	self._gofinish = gohelper.findChild(self.viewGO, "targets/#go_targetitem/result/#go_finish")
	self._gobtn = gohelper.findChild(self.viewGO, "#go_btn")
	self._btnquitgame = gohelper.findChildButtonWithAudio(self.viewGO, "#go_btn/#btn_quitgame")
	self._btnrestart = gohelper.findChildButtonWithAudio(self.viewGO, "#go_btn/#btn_restart")
	self._btnsuccessClick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_successClick")
	self._goTargetParent = gohelper.findChild(self.viewGO, "targets")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MoLiDeErResultView:addEvents()
	self._btnquitgame:AddClickListener(self._btnquitgameOnClick, self)
	self._btnrestart:AddClickListener(self._btnrestartOnClick, self)
	self._btnsuccessClick:AddClickListener(self._btnsuccessClickOnClick, self)
	self.addEventCb(self, MoLiDeErGameController.instance, MoLiDeErEvent.GameExit, self.onGameExit, self)
	self.addEventCb(self, MoLiDeErGameController.instance, MoLiDeErEvent.GameReset, self.onGameReset, self)
end

function MoLiDeErResultView:removeEvents()
	self._btnquitgame:RemoveClickListener()
	self._btnrestart:RemoveClickListener()
	self._btnsuccessClick:RemoveClickListener()
	self.removeEventCb(self, MoLiDeErGameController.instance, MoLiDeErEvent.GameExit, self.onGameExit, self)
	self.removeEventCb(self, MoLiDeErGameController.instance, MoLiDeErEvent.GameReset, self.onGameReset, self)
end

function MoLiDeErResultView:_btnquitgameOnClick()
	self:closeThis()
end

function MoLiDeErResultView:_btnrestartOnClick()
	MoLiDeErGameController.instance:onFailRestart()
end

function MoLiDeErResultView:_btnsuccessClickOnClick()
	self:closeThis()
end

function MoLiDeErResultView:_editableInitView()
	self._targetItemList = {}

	local targetParentGo = self._gotargetitem.transform.parent.gameObject

	for i = 1, 2 do
		local targetGo = gohelper.clone(self._gotargetitem, targetParentGo)

		self._targetItemList[i] = MonoHelper.addNoUpdateLuaComOnceToGo(targetGo, MoLiDeErResultTargetItem)
	end

	gohelper.setActive(self._gotargetitem, false)
end

function MoLiDeErResultView:onUpdateParam()
	return
end

function MoLiDeErResultView:onOpen()
	self._gameInfoMo = MoLiDeErGameModel.instance:getCurGameInfo()

	self:refreshUI()
end

function MoLiDeErResultView:refreshUI()
	local gameInfoMo = self._gameInfoMo
	local isSuccess = gameInfoMo.passStar > 0

	if isSuccess then
		AudioMgr.instance:trigger(AudioEnum2_8.MoLiDeEr.play_ui_pkls_endpoint_arrival)
	else
		AudioMgr.instance:trigger(AudioEnum2_8.MoLiDeEr.play_ui_pkls_challenge_fail)
	end

	self.isSuccess = isSuccess

	gohelper.setActive(self._gosuccess, isSuccess)
	gohelper.setActive(self._goTargetParent, isSuccess)
	gohelper.setActive(self._gofail, not isSuccess)
	gohelper.setActive(self._gobtn, not isSuccess)
	gohelper.setActive(self._btnsuccessClick, isSuccess)

	local episodeConfig = MoLiDeErModel.instance:getCurEpisode()

	self._txtname.text = episodeConfig.name
	self._txtstage.text = "01"

	local isExtraComplete = gameInfoMo.isExtraStar
	local gameConfig = MoLiDeErGameModel.instance:getCurGameConfig()
	local targetItemList = self._targetItemList

	targetItemList[1]:refreshUI(gameConfig.winConditionStr, gameConfig.winCondition, gameInfoMo.passStar and gameInfoMo.passStar >= 1, true)
	targetItemList[2]:refreshUI(gameConfig.extraConditionStr, gameConfig.extraCondition, isExtraComplete, false)
end

function MoLiDeErResultView:onGameExit()
	self:closeThis()
end

function MoLiDeErResultView:onGameReset()
	self:closeThis()
end

function MoLiDeErResultView:onClose()
	if self.isSuccess then
		MoLiDeErGameController.instance:onSuccessExit()
		MoLiDeErController.instance:statGameExit(StatEnum.MoLiDeErGameExitType.Win)
	else
		MoLiDeErGameController.instance:onFailExit()
		MoLiDeErController.instance:statGameExit(StatEnum.MoLiDeErGameExitType.Lose)
	end
end

function MoLiDeErResultView:onDestroyView()
	return
end

return MoLiDeErResultView
