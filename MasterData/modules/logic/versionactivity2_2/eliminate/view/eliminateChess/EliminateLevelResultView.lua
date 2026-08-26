-- chunkname: @modules/logic/versionactivity2_2/eliminate/view/eliminateChess/EliminateLevelResultView.lua

module("modules.logic.versionactivity2_2.eliminate.view.eliminateChess.EliminateLevelResultView", package.seeall)

local EliminateLevelResultView = class("EliminateLevelResultView", BaseView)

function EliminateLevelResultView:onInitView()
	self._simagebg1 = gohelper.findChildSingleImage(self.viewGO, "#simage_bg1")
	self._simagebg2 = gohelper.findChildSingleImage(self.viewGO, "#simage_bg2")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._gosuccess = gohelper.findChild(self.viewGO, "#go_success")
	self._gofail = gohelper.findChild(self.viewGO, "#go_fail")
	self._txtclassnum = gohelper.findChildText(self.viewGO, "txtFbName/#txt_classnum")
	self._txtclassname = gohelper.findChildText(self.viewGO, "txtFbName/#txt_classname")
	self._gotargets = gohelper.findChild(self.viewGO, "#go_targets")
	self._gotargetitem = gohelper.findChild(self.viewGO, "#go_targets/#go_targetitem")
	self._btnquitgame = gohelper.findChildButtonWithAudio(self.viewGO, "btn/#btn_quitgame")
	self._btnrestart = gohelper.findChildButtonWithAudio(self.viewGO, "btn/#btn_restart")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function EliminateLevelResultView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnquitgame:AddClickListener(self._btnquitgameOnClick, self)
	self._btnrestart:AddClickListener(self._btnrestartOnClick, self)
end

function EliminateLevelResultView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnquitgame:RemoveClickListener()
	self._btnrestart:RemoveClickListener()
end

function EliminateLevelResultView:_btncloseOnClick()
	EliminateLevelController.instance:closeLevel()
end

function EliminateLevelResultView:_btnquitgameOnClick()
	EliminateLevelController.instance:closeLevel()
end

function EliminateLevelResultView:_btnrestartOnClick()
	EliminateTeamSelectionModel.instance:setRestart(true)
	EliminateLevelController.instance:closeLevel()
end

function EliminateLevelResultView:_editableInitView()
	EliminateLevelController.instance:BgSwitch(EliminateEnum.AudioFightStep.Victory)
end

function EliminateLevelResultView:onUpdateParam()
	return
end

function EliminateLevelResultView:onOpen()
	self._resultData = EliminateTeamChessModel.instance:getWarFightResult()
	self._isWin = self._resultData.resultCode == EliminateTeamChessEnum.FightResult.win
	self._isLose = self._resultData.resultCode == EliminateTeamChessEnum.FightResult.lose

	gohelper.setActive(self._gosuccess, self._isWin)
	gohelper.setActive(self._gofail, self._isLose)
	gohelper.setActive(self._gotargets, self._isWin)
	gohelper.setActive(self._btnclose, self._isWin)
	gohelper.setActive(self._btnquitgame, self._isLose)
	gohelper.setActive(self._btnrestart, self._isLose)

	if self._isWin then
		AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_pkls_endpoint_arrival)
		self:refreshWinInfo()
	end

	if self._isLose then
		AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_pkls_challenge_fail)
		self:refreshLoseInfo()

		local var_9_0

		if self._isWin then
			var_9_0 = EliminateLevelEnum.resultStatUse.win or EliminateLevelEnum.resultStatUse.lose
		end
	end

	EliminateLevelModel.instance:sendStatData(var_9_0)
	self:refreshBaseInfo()
end

function EliminateLevelResultView:refreshBaseInfo()
	local levelId = EliminateLevelModel.instance:getLevelId()
	local episodeConfig = EliminateConfig.instance:getEliminateEpisodeConfig(levelId)

	if episodeConfig then
		self._txtclassname.text = episodeConfig.name or ""
	end

	local chapterId = episodeConfig.chapterId
	local index = self:getLevelIndex(chapterId, levelId)

	self._txtclassnum.text = string.format("STAGE <color=#FFC67C>%s-%s</color>", chapterId, index)
end

function EliminateLevelResultView:getLevelIndex(chapterId, levelId)
	local tempList = {}

	for _, v in ipairs(lua_eliminate_episode.configList) do
		if v.chapterId == chapterId then
			table.insert(tempList, v.id)

			if v.id == levelId then
				return #tempList
			end
		end
	end

	return 1
end

function EliminateLevelResultView:refreshWinInfo()
	local star = self._resultData:getStar()
	local config = EliminateTeamChessModel.instance:getCurWarChessEpisodeConfig()

	self._taskItem = self:getUserDataTb_()

	if not string.nilorempty(config.winCondition) then
		local item = gohelper.clone(self._gotargetitem, self._gotargets.gameObject, "taskItem")
		local txtTaskTarget = gohelper.findChildText(item, "txt_taskdesc")
		local finish = gohelper.findChild(item, "result/go_finish")
		local unfinish = gohelper.findChild(item, "result/go_unfinish")

		txtTaskTarget.text = EliminateLevelModel.instance.formatString(config.winConditionDesc)

		local isFinish = star >= 1

		gohelper.setActive(finish, isFinish)
		gohelper.setActive(unfinish, not isFinish)
		gohelper.setActive(item, true)
		table.insert(self._taskItem, item)
	end

	if not string.nilorempty(config.extraWinCondition) then
		local item = gohelper.clone(self._gotargetitem, self._gotargets.gameObject, "taskItem")
		local txtTaskTarget = gohelper.findChildText(item, "txt_taskdesc")
		local finish = gohelper.findChild(item, "result/go_finish")
		local unfinish = gohelper.findChild(item, "result/go_unfinish")

		txtTaskTarget.text = EliminateLevelModel.instance.formatString(config.extraWinConditionDesc)

		local isFinish = star >= 2

		gohelper.setActive(finish, isFinish)
		gohelper.setActive(unfinish, not isFinish)
		gohelper.setActive(item, true)
		table.insert(self._taskItem, item)
	end
end

function EliminateLevelResultView:refreshLoseInfo()
	return
end

function EliminateLevelResultView:onClose()
	return
end

function EliminateLevelResultView:onDestroyView()
	return
end

return EliminateLevelResultView
