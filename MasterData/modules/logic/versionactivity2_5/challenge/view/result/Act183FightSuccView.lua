-- chunkname: @modules/logic/versionactivity2_5/challenge/view/result/Act183FightSuccView.lua

module("modules.logic.versionactivity2_5.challenge.view.result.Act183FightSuccView", package.seeall)

local Act183FightSuccView = class("Act183FightSuccView", FightSuccView)

function Act183FightSuccView:_onClickClose()
	if not self._canClick or self._isStartToCloseView then
		return
	end

	local status = ActivityHelper.getActivityStatus(self._activityId)

	if self._reChallenge and self._episodeType ~= Act183Enum.EpisodeType.Boss and status == ActivityEnum.ActivityStatus.Normal then
		GameFacade.showMessageBox(MessageBoxIdDefine.Act183ReplaceResult, MsgBoxEnum.BoxType.Yes_No, self._confrimReplaceResult, self._cancelReplaceResult, nil, self, self)

		return
	end

	self:_reallyStartToCloseView()
end

function Act183FightSuccView:_confrimReplaceResult()
	Activity183Rpc.instance:sendAct183ReplaceResultRequest(self._activityId, self._episodeId, self._reallyStartToCloseView, self)
end

function Act183FightSuccView:_cancelReplaceResult()
	Act183Model.instance:clearBattleFinishedInfo()
	self:_reallyStartToCloseView()
end

function Act183FightSuccView:_reallyStartToCloseView()
	Act183FightSuccView.super._onClickClose(self)

	self._isStartToCloseView = true
end

function Act183FightSuccView:onOpen()
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)

	self._canClick = false
	self._animation = self.viewGO:GetComponent(typeof(UnityEngine.Animation))

	self._animation:Play("fightsucc_in", UnityEngine.PlayMode.StopAll)
	self._animation:PlayQueued("fightsucc_loop", UnityEngine.QueueMode.CompleteOthers, UnityEngine.PlayMode.StopAll)

	self._animEventWrap = self.viewGO:GetComponent(typeof(ZProj.AnimationEventWrap))

	FightController.instance:checkFightQuitTipViewClose()
	gohelper.setActive(self._bonusItemGo, false)

	self._curEpisodeId = DungeonModel.instance.curSendEpisodeId
	self._curChapterId = DungeonModel.instance.curSendChapterId

	local fightResultModel = FightResultModel.instance
	local curEpisodeConfig = lua_episode.configDict[self._curEpisodeId]
	local curChapterConfig = DungeonConfig.instance:getChapterCO(self._curChapterId)

	if curChapterConfig then
		if not curChapterConfig.type then
			local chapterType = DungeonEnum.ChapterType.Normal

			self._normalMode = chapterType == DungeonEnum.ChapterType.Normal
			self._hardMode = chapterType == DungeonEnum.ChapterType.Hard
			self._simpleMode = chapterType == DungeonEnum.ChapterType.Simple

			if curEpisodeConfig then
				if not curEpisodeConfig.type then
					self._curEpisodeId = FightResultModel.instance.episodeId
					self.hadHighRareProp = false

					self:_loadBonusItems()
					self:_hideGoDemand()

					self._randomEntityMO = self:_getRandomEntityMO()

					self._simagecharacterbg:LoadImage(ResUrl.getFightQuitResultIcon("bg_renwubeiguang"))
					self._simagemaskImage:LoadImage(ResUrl.getFightResultcIcon("bg_zhezhao"))

					local chapterCO = lua_chapter.configDict[fightResultModel:getChapterId()]
					local episodeCO = lua_episode.configDict[fightResultModel:getEpisodeId()]
					local needShowFbName = chapterCO ~= nil and episodeCO ~= nil

					gohelper.setActive(self._txtFbName.gameObject, needShowFbName)
					gohelper.setActive(self._txtFbNameEn.gameObject, needShowFbName)

					if needShowFbName then
						self:_setFbName(episodeCO)
					end

					local exps = PlayerModel.instance:getExpNowAndMax()

					self._txtLv.text = "<size=36>LV </size>" .. PlayerModel.instance:getPlayerLevel()

					self._sliderExp:SetValue(exps[1] / exps[2])

					self._txtExp.text = exps[1] .. "/" .. exps[2]

					local addExp = fightResultModel:getPlayerExp()

					if addExp and addExp > 0 then
						gohelper.setActive(self._txtAddExp.gameObject, true)

						self._txtAddExp.text = "EXP+" .. addExp
					else
						gohelper.setActive(self._txtAddExp.gameObject, false)
					end

					self:_setSpineVoice()
					NavigateMgr.instance:addEscape(ViewName.FightSuccView, self._onClickClose, self)

					self._canPlayVoice = false

					TaskDispatcher.runDelay(self._setCanPlayVoice, self, 0.9)
					AudioMgr.instance:trigger(AudioEnum.UI.play_ui_settleaccounts_win)
					self:_checkNewRecord()
					self:_detectCoverRecord()
					self:_checkTypeDetails()
					self:showUnLockCurrentEpisodeNewMode()

					self._conditionItemTab = self:getUserDataTb_()

					self:initBattleFinishInfo()
					self:refreshEpisodeConditions()
					NavigateMgr.instance:addEscape(self.viewName, self._onClickClose, self)
				end
			end
		end
	end
end

function Act183FightSuccView:initBattleFinishInfo()
	local battleFinishedInfo = Act183Model.instance:getBattleFinishedInfo()

	self._activityId = battleFinishedInfo.activityId
	self._episodeMo = battleFinishedInfo.episodeMo
	self._fightResultMo = battleFinishedInfo.fightResultMo
	self._episodeId = self._episodeMo and self._episodeMo:getEpisodeId()
	self._episodeType = self._episodeMo and self._episodeMo:getEpisodeType()
	self._reChallenge = battleFinishedInfo and battleFinishedInfo.reChallenge
end

function Act183FightSuccView:refreshEpisodeConditions()
	local maxUseItemIndex = self:refreshFirstAndAdvanceConditions(0)

	self:refreshFightConditions(maxUseItemIndex)
end

function Act183FightSuccView:refreshFirstAndAdvanceConditions(startIndex)
	local conditionDescList = Act183Helper.getEpisodeConditionDescList(self._episodeId)
	local getStarNum = FightResultModel.instance.star
	local starImage = self._hardMode and "zhuxianditu_kn_xingxing_002" or "zhuxianditu_pt_xingxing_001"

	if conditionDescList then
		if not #conditionDescList then
			local conditionDescNum = 0
			local curUseIndex = 0

			for index = 1, conditionDescNum do
				curUseIndex = index + startIndex

				local conditionItem = self:_getOrCreateConditionItem(index + startIndex)
				local isConditionPass = index <= getStarNum
				local txtColor = isConditionPass and "#C4C0BD" or "#6C6C6B"

				conditionItem.txtcondition.text = gohelper.getRichColorText((not conditionDescList[index] or nil) and "", txtColor)

				local starColor = "#87898C"

				if isConditionPass then
					starColor = self._hardMode and "#FF4343" or "#F77040"
				end

				UISpriteSetMgr.instance:setCommonSprite(conditionItem.imagestar, starImage, true)
				SLFramework.UGUI.GuiHelper.SetColor(conditionItem.imagestar, starColor)
				gohelper.setActive(conditionItem.viewGO, true)
			end

			return curUseIndex
		end
	end
end

function Act183FightSuccView:refreshFightConditions(startIndex)
	local conditionIds = self._episodeMo:getConditionIds()

	if conditionIds then
		for index, conditionId in ipairs(conditionIds) do
			local conditionItem = self:_getOrCreateConditionItem(index + startIndex)
			local isConditionPass = self._fightResultMo:isConditionPass(conditionId)
			local conditionCo = Act183Config.instance:getConditionCo(conditionId)

			if conditionCo then
				conditionItem.txtcondition.text = conditionCo.decs1 or ""
			end

			Act183Helper.setEpisodeConditionStar(conditionItem.imagestar, isConditionPass, nil, true)
			gohelper.setActive(conditionItem.viewGO, true)
		end
	end
end

function Act183FightSuccView:_getOrCreateConditionItem(index)
	local conditionItem = self._conditionItemTab[index]

	if not conditionItem then
		conditionItem = self:getUserDataTb_()
		conditionItem.viewGO = gohelper.cloneInPlace(self._goCondition, "fightcondition_" .. index)
		conditionItem.txtcondition = gohelper.findChildText(conditionItem.viewGO, "condition")
		conditionItem.imagestar = gohelper.findChildImage(conditionItem.viewGO, "star")
		self._conditionItemTab[index] = conditionItem
	end

	return conditionItem
end

return Act183FightSuccView
