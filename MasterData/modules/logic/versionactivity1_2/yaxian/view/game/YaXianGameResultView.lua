-- chunkname: @modules/logic/versionactivity1_2/yaxian/view/game/YaXianGameResultView.lua

module("modules.logic.versionactivity1_2.yaxian.view.game.YaXianGameResultView", package.seeall)

local YaXianGameResultView = class("YaXianGameResultView", BaseView)

function YaXianGameResultView:onInitView()
	self._simagebg1 = gohelper.findChildSingleImage(self.viewGO, "#simage_bg1")
	self._simageSuccTitle = gohelper.findChildSingleImage(self.viewGO, "#go_success/#simage_title")
	self._simageFailTitle = gohelper.findChildSingleImage(self.viewGO, "#go_fail/#simage_title")
	self._gosuccess = gohelper.findChild(self.viewGO, "#go_success")
	self._gofail = gohelper.findChild(self.viewGO, "#go_fail")
	self._gotargetitem = gohelper.findChild(self.viewGO, "targets/#go_targetitem")
	self._btnquitgame = gohelper.findChildButtonWithAudio(self.viewGO, "btn/#btn_quitgame")
	self._btnrestart = gohelper.findChildButtonWithAudio(self.viewGO, "btn/#btn_restart")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function YaXianGameResultView:addEvents()
	self._btnquitgame:AddClickListener(self._btnquitgameOnClick, self)
	self._btnrestart:AddClickListener(self._btnrestartOnClick, self)
end

function YaXianGameResultView:removeEvents()
	self._btnquitgame:RemoveClickListener()
	self._btnrestart:RemoveClickListener()
end

function YaXianGameResultView:btnCloseOnClick()
	YaXianGameController.instance:dispatchEvent(YaXianEvent.QuitGame)
	self:closeThis()
end

function YaXianGameResultView:_btnquitgameOnClick()
	YaXianGameController.instance:dispatchEvent(YaXianEvent.QuitGame)
	self:closeThis()
end

function YaXianGameResultView:_btnrestartOnClick()
	YaXianGameController.instance:enterChessGame(self.episodeConfig.id)
	self:closeThis()
end

function YaXianGameResultView:_editableInitView()
	self._simagebg1:LoadImage(ResUrl.getCommonIcon("full/bg_beijingzhezhao"))

	self.txtEpisodeIndex = gohelper.findChildText(self.viewGO, "txtFbName/#txt_classnum")
	self.txtEpisodeName = gohelper.findChildText(self.viewGO, "txtFbName/#txt_classname")
	self._btnclose = gohelper.findChildClick(self.viewGO, "#btn_close")

	self._btnclose:AddClickListener(self.btnCloseOnClick, self)
	gohelper.setActive(self._gotargetitem, false)
	NavigateMgr.instance:addEscape(self.viewName, self.btnCloseOnClick, self)
end

function YaXianGameResultView:onUpdateParam()
	return
end

function YaXianGameResultView:initData()
	self.isWin = self.viewParam.result
	self.episodeConfig = self.viewParam.episodeConfig
end

function YaXianGameResultView:onOpen()
	self:initData()
	self:refreshUI()
end

function YaXianGameResultView:refreshUI()
	gohelper.setActive(self._gosuccess, self.isWin)
	gohelper.setActive(self._gofail, not self.isWin)
	self:showBtn(not self.isWin)

	if self.isWin then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_settleaccounts_win)
		self._simageSuccTitle:LoadImage(ResUrl.gettxt_versionactivitychessIcon(YaXianGameEnum.ResultSimageName.Success))
	else
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_settleaccounts_lose)

		local yaXianInteractItem = YaXianGameController.instance:getPlayerInteractItem()

		if yaXianInteractItem and yaXianInteractItem:isDelete() then
			self._simageFailTitle:LoadImage(ResUrl.gettxt_versionactivitychessIcon(YaXianGameEnum.ResultSimageName.FightFail))
		elseif YaXianGameModel.instance:isRoundUseUp() then
			self._simageFailTitle:LoadImage(ResUrl.gettxt_versionactivitychessIcon(YaXianGameEnum.ResultSimageName.RoundUseUp))
		else
			self._simageFailTitle:LoadImage(ResUrl.gettxt_versionactivitychessIcon(YaXianGameEnum.ResultSimageName.FightFail))
		end
	end

	self:refreshEpisodeInfo()
	self:refreshConditions()
end

function YaXianGameResultView:showBtn(active)
	gohelper.setActive(self._btnquitgame.gameObject, active)
	gohelper.setActive(self._btnrestart.gameObject, active)
	gohelper.setActive(self._btnclose.gameObject, not active)
end

function YaXianGameResultView:refreshEpisodeInfo()
	self.txtEpisodeIndex.text = self.episodeConfig.index
	self.txtEpisodeName.text = self.episodeConfig.name
end

function YaXianGameResultView:refreshConditions()
	local conditionList = YaXianConfig.instance:getConditionList(self.episodeConfig)
	local conditionTextList = string.split(self.episodeConfig.conditionStr, "|")

	for index, conditionArr in ipairs(conditionList) do
		local conditionItem = self:createConditionItem()

		gohelper.setActive(conditionItem.go, true)

		local finish = YaXianGameModel.instance:checkFinishCondition(conditionArr[1], conditionArr[2])

		gohelper.setActive(conditionItem.goFinish, finish)
		gohelper.setActive(conditionItem.goUnFinish, not finish)

		conditionItem.txtDesc.text = conditionTextList[index]
	end
end

function YaXianGameResultView:createConditionItem()
	local conditionItem = self:getUserDataTb_()

	conditionItem.go = gohelper.cloneInPlace(self._gotargetitem)
	conditionItem.txtDesc = gohelper.findChildText(conditionItem.go, "txt_taskdesc")
	conditionItem.goFinish = gohelper.findChild(conditionItem.go, "result/go_finish")
	conditionItem.goUnFinish = gohelper.findChild(conditionItem.go, "result/go_unfinish")

	return conditionItem
end

function YaXianGameResultView:onClose()
	return
end

function YaXianGameResultView:onDestroyView()
	self._simagebg1:UnLoadImage()
	self._simageSuccTitle:UnLoadImage()
	self._simageFailTitle:UnLoadImage()
	self._btnclose:RemoveClickListener()
end

return YaXianGameResultView
