-- chunkname: @modules/logic/versionactivity2_8/molideer/view/MoLiDeErGameView.lua

module("modules.logic.versionactivity2_8.molideer.view.MoLiDeErGameView", package.seeall)

local MoLiDeErGameView = class("MoLiDeErGameView", BaseView)

function MoLiDeErGameView:onInitView()
	self._gocameraMain = gohelper.findChild(self.viewGO, "#go_cameraMain")
	self._simageBG = gohelper.findChildSingleImage(self.viewGO, "#go_cameraMain/#simage_BG")
	self._gotarget = gohelper.findChild(self.viewGO, "#go_cameraMain/Left/Target/TargetList/#go_target")
	self._gotarget2 = gohelper.findChild(self.viewGO, "#go_cameraMain/Left/Target/TargetList/#go_target2")
	self._gotarget3 = gohelper.findChild(self.viewGO, "#go_cameraMain/Left/Target/TargetList/#go_target3")
	self._txtTarget = gohelper.findChildText(self.viewGO, "#go_cameraMain/Left/Target/TargetList/#go_target/#txt_Target")
	self._goTurnsBG = gohelper.findChild(self.viewGO, "#go_cameraMain/Middle/Title/#go_TurnsBG")
	self._txtTurns = gohelper.findChildText(self.viewGO, "#go_cameraMain/Middle/Title/#txt_Turns")
	self._txtTurns1 = gohelper.findChildText(self.viewGO, "#go_cameraMain/Middle/Title/#txt_Turns1")
	self._goeventMap = gohelper.findChild(self.viewGO, "#go_cameraMain/Middle/Middle/#go_eventMap")
	self._goeventItem = gohelper.findChild(self.viewGO, "#go_cameraMain/Middle/Middle/#go_eventMap/#go_eventItem")
	self._goPoint = gohelper.findChild(self.viewGO, "#go_cameraMain/Middle/Middle/#go_eventMap/#go_eventItem/#go_Point")
	self._simageIcon = gohelper.findChildSingleImage(self.viewGO, "#go_cameraMain/Middle/Middle/#go_eventMap/#go_eventItem/#simage_Icon")
	self._goStar = gohelper.findChild(self.viewGO, "#go_cameraMain/Middle/Middle/#go_eventMap/#go_eventItem/#go_Star")
	self._txtNum = gohelper.findChildText(self.viewGO, "#go_cameraMain/Middle/Middle/#go_eventMap/#go_eventItem/#txt_Num")
	self._simageHead = gohelper.findChildSingleImage(self.viewGO, "#go_cameraMain/Middle/Middle/#go_eventMap/#go_eventItem/Dispatch/image_HeadBG/image/#simage_Head")
	self._txtTime = gohelper.findChildText(self.viewGO, "#go_cameraMain/Middle/Middle/#go_eventMap/#go_eventItem/Dispatch/#txt_Time")
	self._btnReset = gohelper.findChildButtonWithAudio(self.viewGO, "#go_cameraMain/Right/Layout/#btn_Reset")
	self._btnSkip = gohelper.findChildButtonWithAudio(self.viewGO, "#go_cameraMain/Right/Layout/#btn_Skip")
	self._btnNextBtn = gohelper.findChildButtonWithAudio(self.viewGO, "#go_cameraMain/Right/#btn_NextBtn")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")
	self._gowarehouseInfo = gohelper.findChild(self.viewGO, "#go_warehouseInfo")
	self._scrollDetail = gohelper.findChildScrollRect(self.viewGO, "#go_warehouseInfo/#scroll_Detail")
	self._goescaperulecontainer = gohelper.findChild(self.viewGO, "#go_warehouseInfo/#scroll_Detail/Viewport/Content/#go_escaperulecontainer")
	self._goItemList = gohelper.findChild(self.viewGO, "#go_warehouseInfo/#scroll_Detail/Viewport/Content/#go_escaperulecontainer/#go_ItemList")
	self._goitem = gohelper.findChild(self.viewGO, "#go_warehouseInfo/#scroll_Detail/Viewport/Content/#go_escaperulecontainer/#go_ItemList/#go_item")
	self._txtCount = gohelper.findChildText(self.viewGO, "#go_warehouseInfo/#scroll_Detail/Viewport/Content/#go_escaperulecontainer/#go_ItemList/#go_item/image_icon/image_Count/#txt_Count")
	self._goLineParent = gohelper.findChild(self.viewGO, "#go_cameraMain/Middle/Middle/Line")
	self._goLineVirtual = gohelper.findChild(self.viewGO, "#go_cameraMain/Middle/Middle/Line/#go_Line1")
	self._goLineSolid = gohelper.findChild(self.viewGO, "#go_cameraMain/Middle/Middle/Line/#go_Line2")
	self._goTips = gohelper.findChild(self.viewGO, "#go_cameraMain/Middle/#go_Tips")
	self._goTargetFx = gohelper.findChild(self.viewGO, "#go_hpFlyItem_energy")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MoLiDeErGameView:addEvents()
	self._btnReset:AddClickListener(self._btnResetOnClick, self)
	self._btnSkip:AddClickListener(self._btnSkipOnClick, self)
	self._btnNextBtn:AddClickListener(self._btnNextBtnOnClick, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.BeforeOpenView, self.onViewOpen, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self.onViewClose, self)
	self.addEventCb(self, MoLiDeErGameController.instance, MoLiDeErEvent.GameReset, self.onGameReset, self)
	self.addEventCb(self, MoLiDeErGameController.instance, MoLiDeErEvent.GameExit, self.onGameExit, self)
	self.addEventCb(self, MoLiDeErGameController.instance, MoLiDeErEvent.GameSkip, self.onGameSkip, self)
	self.addEventCb(self, MoLiDeErGameController.instance, MoLiDeErEvent.GameEventSelect, self.onEventChange, self)
	self.addEventCb(self, MoLiDeErGameController.instance, MoLiDeErEvent.GameUIRefresh, self.refreshUI, self)
	self.addEventCb(self, MoLiDeErGameController.instance, MoLiDeErEvent.GameTipRecycle, self.recycleToast, self)
end

function MoLiDeErGameView:removeEvents()
	self._btnReset:RemoveClickListener()
	self._btnSkip:RemoveClickListener()
	self._btnNextBtn:RemoveClickListener()
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.BeforeOpenView, self.onViewOpen, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self.onViewClose, self)
	self.removeEventCb(self, MoLiDeErGameController.instance, ViewEvent.OnCloseView, self.onViewClose, self)
	self.removeEventCb(self, MoLiDeErGameController.instance, MoLiDeErEvent.GameReset, self.onGameReset, self)
	self.removeEventCb(self, MoLiDeErGameController.instance, MoLiDeErEvent.GameExit, self.onGameExit, self)
	self.removeEventCb(self, MoLiDeErGameController.instance, MoLiDeErEvent.GameSkip, self.onGameSkip, self)
	self.removeEventCb(self, MoLiDeErGameController.instance, MoLiDeErEvent.GameEventSelect, self.onEventChange, self)
	self.removeEventCb(self, MoLiDeErGameController.instance, MoLiDeErEvent.GameUIRefresh, self.refreshUI, self)
	self.removeEventCb(self, MoLiDeErGameController.instance, MoLiDeErEvent.GameTipRecycle, self.recycleToast, self)
end

function MoLiDeErGameView:_btnNextBtnOnClick()
	local actId = MoLiDeErModel.instance:getCurActId()
	local episodeId = MoLiDeErModel.instance:getCurEpisodeId()

	MoLiDeErGameController.instance:nextRound(actId, episodeId)
end

function MoLiDeErGameView:_btnResetOnClick()
	MoLiDeErGameController.instance:resetGame()
end

function MoLiDeErGameView:_btnSkipOnClick()
	MoLiDeErGameController.instance:skipGame()
end

function MoLiDeErGameView:_editableInitView()
	self._targetItemList = {}
	self._targetResultItemList = {}
	self._eventItemList = {}

	if self._dispatchItem == nil then
		local prefabPath = self.viewContainer._viewSetting.otherRes[1]
		local prefab = self:getResInst(prefabPath, self.viewGO)

		self._goDispatch = prefab
		self._dispatchItem = MonoHelper.addNoUpdateLuaComOnceToGo(prefab, MoLiDeErDispatchItem)
	end

	gohelper.setActive(self._goeventItem, false)
	gohelper.setActive(self._gotarget, false)
	gohelper.setActive(self._goLineVirtual, false)
	gohelper.setActive(self._goLineSolid, false)

	self._unUseLineSolidList = {}
	self._useLineSolidList = {}
	self._tweenIdList = {}
	self._titleAnimator = gohelper.findChildComponent(self.viewGO, "#go_cameraMain/Middle/Title", gohelper.Type_Animator)
	self._goTipsParent = self._goTips.transform.parent.gameObject

	gohelper.setActive(self._goTips, false)

	self._unUsedTipsItem = {}
	self._usedTipsItem = {}
	self._cacheMsgList = {}
	self._maxCount = 4
	self._showNextToastInterval = 0.1
	self._unUseTargetFxList = {}
	self._useTargetFxList = {}
	self._targetFxTweenList = {}
	self._targetProgressFxDic = {}
end

function MoLiDeErGameView:onUpdateParam()
	return
end

function MoLiDeErGameView:onOpen()
	self._actId = MoLiDeErModel.instance:getCurActId()
	self._episodeId = MoLiDeErModel.instance:getCurEpisodeId()
	self._episodeConfig = MoLiDeErModel.instance:getCurEpisode()
	self._gameConfig = MoLiDeErGameModel.instance:getCurGameConfig()

	MoLiDeErController.instance:statGameStart(self._actId, self._episodeId)
	self:refreshUI(false)
end

function MoLiDeErGameView:refreshUI(noShowEffect)
	logNormal("莫莉德尔 角色活动 刷新主界面")

	local gameInfoMo = MoLiDeErGameModel.instance:getGameInfo(self._actId, self._episodeId)

	self._infoMo = gameInfoMo

	local finishList = gameInfoMo.newFinishEventList
	local newEventList = gameInfoMo.newEventList

	if not noShowEffect then
		if finishList then
			local haveFinishOrNewEvent = true

			if not finishList[1] then
				haveFinishOrNewEvent = newEventList ~= nil and newEventList[1] or false
			end

			if gameInfoMo.isEpisodeFinish then
				local isEpisodeEnd = gameInfoMo.passStar ~= 0

				self._isEpisodeEnd = isEpisodeEnd

				if haveFinishOrNewEvent then
					if not gameInfoMo.existEventList then
						local existEventInfoList = gameInfoMo.eventInfos

						self:refreshState()
						self:refreshExistEvent(existEventInfoList)

						if not haveFinishOrNewEvent then
							self:delayShowInfo()

							if isEpisodeEnd then
								self:_lockScreen(true, MoLiDeErEnum.DelayTime.BlackScreenTime3)
							end

							self:checkTargetProgressFx()
						else
							self:refreshFinishEvent()
						end
					end
				end
			end
		end
	end
end

function MoLiDeErGameView:delayShowInfo()
	logNormal("莫莉德尔 角色活动 刷新信息")
	self:refreshInfo()
	self:refreshTeam()
end

function MoLiDeErGameView:refreshState()
	local episodeInfo = MoLiDeErModel.instance:getCurEpisodeInfo()

	gohelper.setActive(self._btnSkip, episodeInfo.passCount > 0)
end

function MoLiDeErGameView:refreshInfo()
	local gameInfoMo = self._infoMo
	local round = gameInfoMo.currentRound
	local previousRound = gameInfoMo.previousRound
	local showAnim = previousRound and previousRound < round
	local gameConfig = self._gameConfig
	local data = string.splitToNumber(gameConfig.winCondition, "#")
	local type = data[1]
	local maxRound

	if type == MoLiDeErEnum.TargetType.RoundFinishAll or type == MoLiDeErEnum.TargetType.RoundFinishAny then
		maxRound = MoLiDeErHelper.getRealRound(data[2], true)
	end

	if showAnim then
		self._txtTurns.text = MoLiDeErHelper.getGameRoundTitleDesc(previousRound, maxRound)
		self._txtTurns1.text = MoLiDeErHelper.getGameRoundTitleDesc(previousRound, maxRound)
	else
		self._txtTurns.text = MoLiDeErHelper.getGameRoundTitleDesc(round, maxRound)
	end

	if showAnim then
		if not MoLiDeErEnum.AnimName.GameViewEventTitleCount then
			local animName = MoLiDeErEnum.AnimName.GameViewEventTitleIdle

			if showAnim then
				AudioMgr.instance:trigger(AudioEnum2_8.MoLiDeEr.play_ui_mln_no_effect)
			end

			self._titleAnimator:Play(animName, 0, 0)
			TaskDispatcher.cancelTask(self.onTitleCountTimeEnd, self)
			TaskDispatcher.runDelay(self.onTitleCountTimeEnd, self, 0.167)

			local showToast = {}

			if gameInfoMo.newGetTeam and gameInfoMo.newGetTeam[1] then
				for _, teamId in ipairs(gameInfoMo.newGetTeam) do
					local teamConfig = MoLiDeErConfig.instance:getTeamConfig(teamId)
					local toastDesc = luaLang("molideer_team_add_tips")

					toastDesc = GameUtil.getSubPlaceholderLuaLangOneParam(toastDesc, teamConfig.name)

					table.insert(showToast, toastDesc)
				end
			end

			if gameInfoMo.newGetItem and gameInfoMo.newGetItem[1] then
				for _, itemId in ipairs(gameInfoMo.newGetItem) do
					local itemConfig = MoLiDeErConfig.instance:getItemConfig(itemId)
					local toastDesc = luaLang("molideer_item_add_tips")

					toastDesc = GameUtil.getSubPlaceholderLuaLangOneParam(toastDesc, itemConfig.name)

					table.insert(showToast, toastDesc)
				end
			end

			local executionCount = gameInfoMo.leftRoundEnergy
			local previousExecutionCount = gameInfoMo.previousRoundEnergy

			if previousExecutionCount and executionCount ~= previousExecutionCount then
				local toastDesc = luaLang("molideer_execution_change_tips")
				local changeDesc = MoLiDeErHelper.getExecutionCostStr(executionCount - previousExecutionCount)

				toastDesc = GameUtil.getSubPlaceholderLuaLangOneParam(toastDesc, changeDesc)

				table.insert(showToast, toastDesc)
			end

			for _, msg in ipairs(showToast) do
				self:addTitleTips(msg)
			end
		end
	end
end

function MoLiDeErGameView:onTitleCountTimeEnd()
	TaskDispatcher.cancelTask(self.onTitleCountTimeEnd, self)

	local gameInfoMo = self._infoMo
	local round = gameInfoMo.currentRound
	local gameConfig = self._gameConfig
	local data = string.splitToNumber(gameConfig.winCondition, "#")
	local type = data[1]
	local maxRound

	self._txtTurns.text = MoLiDeErHelper.getGameRoundTitleDesc(round, (type == MoLiDeErEnum.TargetType.RoundFinishAll or type == MoLiDeErEnum.TargetType.RoundFinishAny or nil) and MoLiDeErHelper.getRealRound(data[2], true))
end

function MoLiDeErGameView:checkTargetProgressFx()
	local gameInfoMo = MoLiDeErGameModel.instance:getCurGameInfo()
	local tempTweenIdList = {}

	for _, tweenId in ipairs(self._targetFxTweenList) do
		ZProj.TweenHelper.KillById(tweenId, true)
	end

	local fxCount = 0
	local targetProgressDic = {}

	TaskDispatcher.cancelTask(self.onTargetFxAllShowEnd, self)
	TaskDispatcher.cancelTask(self.onTargetProgressAddFxShowEnd, self)

	if gameInfoMo.newFinishEventList and gameInfoMo.newFinishEventList[1] then
		for _, info in ipairs(gameInfoMo.newFinishEventList) do
			local optionId = info.optionId
			local optionConfig = MoLiDeErConfig.instance:getProgressConfig(optionId)

			if optionConfig ~= nil then
				local conditionParamList = string.split(optionConfig.condition, "|")
				local eventConfig = MoLiDeErConfig.instance:getEventConfig(info.finishedEventId)

				for _, conditionParam in ipairs(conditionParamList) do
					local conditionData = string.splitToNumber(conditionParam, "#")
					local gameId = conditionData[1]

					if gameId == gameInfoMo.gameId then
						local targetId = conditionData[2]
						local progressValue = gameInfoMo:getTargetProgress(targetId)
						local targetState = MoLiDeErHelper.getTargetState(progressValue)

						if targetState ~= MoLiDeErEnum.ProgressChangeType.Failed then
							local item = self._targetItemList[targetId]
							local targetTran = item:getFxTargetTran()
							local fxGo = self:getOrReturnTargetFxLine()
							local originalPos = string.splitToNumber(eventConfig.position, "#")

							transformhelper.setLocalPosXY(fxGo.transform, originalPos[1], originalPos[2])

							local targetPosX, targetPosY = recthelper.rectToRelativeAnchorPos2(targetTran.position, self._goeventMap.transform)
							local angle = math.atan2(originalPos[2] - targetPosY, originalPos[1] - targetPosX) * (180 / math.pi)

							transformhelper.setEulerAngles(fxGo.transform, 0, 0, angle)

							local param = {
								fxGo = fxGo
							}
							local tweenId = ZProj.TweenHelper.DOLocalMove(fxGo.transform, targetPosX, targetPosY, 0, MoLiDeErEnum.DelayTime.TargetFxMove, self.onTargetFxTweenEnd, self, param)

							table.insert(tempTweenIdList, tweenId)

							fxCount = fxCount + 1
						end

						targetProgressDic[targetId] = true
					end
				end
			end
		end
	end

	self._targetFxTweenList = tempTweenIdList
	self._targetProgressFxDic = targetProgressDic
	self._targetProgressFxCount = fxCount

	if fxCount > 0 then
		TaskDispatcher.runDelay(self.onTargetFxAllShowEnd, self, MoLiDeErEnum.DelayTime.TargetFxMove)
	else
		self:onTargetFxAllShowEnd()
	end
end

function MoLiDeErGameView:onTargetFxTweenEnd(param)
	self:getOrReturnTargetFxLine(param.fxGo)
end

function MoLiDeErGameView:onTargetFxAllShowEnd()
	TaskDispatcher.cancelTask(self.onTargetFxAllShowEnd, self)

	if self._targetProgressFxCount > 0 then
		self:refreshTarget(true)
		TaskDispatcher.runDelay(self.onTargetProgressAddFxShowEnd, self, MoLiDeErEnum.DelayTime.TargetFxProgressAdd)
	else
		self:onTargetProgressAddFxShowEnd()
	end
end

function MoLiDeErGameView:onTargetProgressAddFxShowEnd()
	TaskDispatcher.cancelTask(self.onTargetProgressAddFxShowEnd, self)
	self:refreshTarget()
	self:checkGameOver()
end

function MoLiDeErGameView:checkGameOver()
	local gameInfoMo = self._infoMo

	if gameInfoMo.isEpisodeFinish and gameInfoMo.passStar ~= 0 then
		TaskDispatcher.runDelay(self.onGameOver, self, 1)
	end
end

function MoLiDeErGameView:onGameOver()
	self:_lockScreen(false)
	TaskDispatcher.cancelTask(self.onGameOver, self)
	ViewMgr.instance:openView(ViewName.MoLiDeErResultView)
end

function MoLiDeErGameView:refreshTarget(showProgressState)
	local gameInfoMo = MoLiDeErGameModel.instance:getCurGameInfo()
	local showList = {
		MoLiDeErEnum.TargetId.Main,
		MoLiDeErEnum.TargetId.Extra
	}
	local gameConfig = self._gameConfig
	local targetItemList = self._targetItemList
	local targetResultItemList = self._targetResultItemList
	local resultItemCount = 0
	local itemCount = 0
	local haveResultItemCount = #targetResultItemList
	local haveItemCount = #targetItemList
	local targetParentGo = self._gotarget.transform.parent.gameObject

	for _, targetId in ipairs(showList) do
		local progressValue = gameInfoMo:getTargetProgress(targetId)
		local state = MoLiDeErHelper.getTargetState(progressValue)
		local item
		local showAnim = false

		if state == MoLiDeErEnum.ProgressChangeType.Percentage or showProgressState and gameInfoMo:isNewCompleteTarget(targetId) then
			itemCount = itemCount + 1

			if haveItemCount < itemCount then
				local targetGo = gohelper.clone(self._gotarget2, targetParentGo)

				item = MonoHelper.addNoUpdateLuaComOnceToGo(targetGo, MoLiDeErTargetItem)

				table.insert(targetItemList, item)
			else
				item = targetItemList[itemCount]
			end

			showAnim = self._targetProgressFxDic[targetId] == true and showProgressState
		else
			resultItemCount = resultItemCount + 1

			if haveResultItemCount < resultItemCount then
				local targetGo = gohelper.clone(self._gotarget3, targetParentGo)

				item = MonoHelper.addNoUpdateLuaComOnceToGo(targetGo, MoLiDeErTargetResultItem)

				table.insert(targetResultItemList, item)
			else
				item = targetResultItemList[resultItemCount]
			end

			showAnim = gameInfoMo:isNewCompleteTarget(targetId) or gameInfoMo:isNewFailTarget(targetId)
		end

		if targetId == MoLiDeErEnum.TargetId.Main then
			if not gameConfig.winConditionStr then
				local conditionStr = gameConfig.extraConditionStr

				if targetId == MoLiDeErEnum.TargetId.Main then
					if not gameConfig.winCondition then
						local condition = gameConfig.extraCondition

						item:setActive(true)
						item:refreshUI(conditionStr, condition, targetId, gameInfoMo, showAnim)
					end
				end
			end
		end
	end

	if itemCount < haveItemCount then
		for i = itemCount + 1, haveItemCount do
			local item = targetItemList[i]

			item:setActive(false)
		end
	end

	if resultItemCount < haveResultItemCount then
		for i = resultItemCount + 1, haveResultItemCount do
			local item = targetResultItemList[i]

			item:setActive(false)
		end
	end
end

function MoLiDeErGameView:refreshExistEvent(eventInfos)
	local count = #eventInfos
	local itemList = self._eventItemList
	local itemCount = #itemList
	local currentRound = MoLiDeErGameModel.instance:getCurRound()
	local dispatchCount = 0

	for index, eventInfo in ipairs(eventInfos) do
		local item

		if itemCount < index then
			local itemGo = gohelper.clone(self._goeventItem, self._goeventMap)

			item = MonoHelper.addNoUpdateLuaComOnceToGo(itemGo, MoLiDeErEventItem)

			table.insert(itemList, item)
		else
			item = itemList[index]
		end

		item:setActive(true)

		local state = self:checkTeamDispatchState(eventInfo.eventId)
		local showAnim = state ~= MoLiDeErEnum.TeamDispatchState.Dispatching

		if state == MoLiDeErEnum.TeamDispatchState.Dispatch then
			dispatchCount = dispatchCount + 1
		end

		item:setData(eventInfo.eventId, eventInfo.isChose, eventInfo.eventEndRound, currentRound, eventInfo.teamId, showAnim)
		MoLiDeErGameController.instance:dispatchEvent(MoLiDeErEvent.GuideNewEvent, eventInfo.eventId)
	end

	if dispatchCount > 0 then
		AudioMgr.instance:trigger(AudioEnum2_8.MoLiDeEr.play_ui_leimi_decrypt_correct)
	end

	self._existItemCount = count

	if count < itemCount then
		for i = count + 1, itemCount do
			local item = itemList[i]

			if item == nil then
				logError(string.format("索引越界 itemCount :%s  index: %s", i, tostring(#itemList)))
			else
				item:setActive(false)
			end
		end
	end
end

function MoLiDeErGameView:refreshFinishEvent()
	self:_lockScreen(true, MoLiDeErEnum.DelayTime.BlackScreenTime)

	local finishEventList = self._infoMo.newFinishEventList
	local finishCount = 0

	if finishEventList and #finishEventList > 0 then
		local itemList = self._eventItemList
		local itemCount = #itemList
		local currentRound = MoLiDeErGameModel.instance:getCurRound()

		for _, finishInfo in ipairs(finishEventList) do
			local finishEventId = finishInfo.finishedEventId

			if finishEventId ~= nil and finishEventId ~= 0 then
				finishCount = finishCount + 1

				local item
				local itemIndex = finishCount + self._existItemCount

				if itemCount < itemIndex then
					local itemGo = gohelper.clone(self._goeventItem, self._goeventMap)

					item = MonoHelper.addNoUpdateLuaComOnceToGo(itemGo, MoLiDeErEventItem)

					table.insert(itemList, item)
				else
					item = itemList[itemIndex]
				end

				item:setActive(true)
				item:setData(finishEventId, false, currentRound, currentRound, nil)
				item:showAnim(MoLiDeErEnum.AnimName.GameViewEventItemFinish, true)
				self:checkTeamDispatchState(finishEventId)
			end
		end
	end

	self._finishItemCount = finishCount

	if finishCount > 0 then
		AudioMgr.instance:trigger(AudioEnum2_8.MoLiDeEr.play_ui_yuzhou_level_lit)
		TaskDispatcher.runDelay(self.onFinishTaskShowTimeEnd, self, MoLiDeErEnum.DelayTime.FinishEventShow)
	else
		self:onFinishTaskShowTimeEnd()
	end
end

function MoLiDeErGameView:onFinishTaskShowTimeEnd()
	TaskDispatcher.cancelTask(self.onFinishTaskShowTimeEnd, self)

	if self._finishItemCount > 0 then
		self:_lockScreen(false)
		MoLiDeErGameController.instance:showFinishEvent()
		logNormal("莫莉德尔 角色活动 事件角色动画播放完毕")
		self.addEventCb(self, MoLiDeErGameController.instance, MoLiDeErEvent.GameFinishEventShowEnd, self.onFinishEventShowEnd, self)
	else
		self:onFinishEventViewShowEnd()
	end
end

function MoLiDeErGameView:onFinishEventShowEnd()
	self.removeEventCb(self, MoLiDeErGameController.instance, MoLiDeErEvent.GameFinishEventShowEnd, self.onFinishEventShowEnd, self)

	if self._finishItemCount > 0 then
		AudioMgr.instance:trigger(AudioEnum2_8.MoLiDeEr.play_ui_molu_arm_repair)

		local itemList = self._eventItemList
		local startIndex = self._existItemCount + 1
		local endIndex = startIndex + self._finishItemCount - 1

		for i = startIndex, endIndex do
			local item = itemList[i]

			if item == nil then
				logError(string.format("索引越界 index:%s itemCount :%s  existCount: %s finishItemCount : %s", i, tostring(#itemList), self._existItemCount, self._finishItemCount))
			else
				item:showAnim(MoLiDeErEnum.AnimName.GameViewEventItemClose, true)
			end
		end
	end

	self:onFinishEventViewShowEnd()
end

function MoLiDeErGameView:onFinishEventViewShowEnd()
	local gameInfoMo = self._infoMo
	local isEpisodeEnd = self._isEpisodeEnd

	if isEpisodeEnd then
		if not MoLiDeErEnum.DelayTime.BlackScreenTime3 then
			local delayTime = MoLiDeErEnum.DelayTime.BlackScreenTime2

			self:_lockScreen(true, delayTime)
			self:delayShowInfo()
			self:checkTargetProgressFx()

			if isEpisodeEnd then
				local itemList = self._eventItemList
				local startIndex = self._existItemCount + 1
				local endIndex = startIndex + self._finishItemCount - 1

				for i = startIndex, endIndex do
					local item = itemList[i]

					if item == nil then
						logError(string.format("索引越界 index:%s itemCount :%s  existCount: %s finishItemCount : %s", i, tostring(#itemList), self._existItemCount, self._finishItemCount))
					else
						item:setActive(false)
					end
				end

				return
			end

			local newEventCount = 0
			local newLineCount = 0
			local eventInfos = gameInfoMo.newEventList

			if #eventInfos > 0 then
				for index, eventInfo in ipairs(eventInfos) do
					local preEventId = eventInfo.preEventId

					if preEventId and preEventId ~= 0 then
						newEventCount = newEventCount + 1

						local preEventConfig = MoLiDeErConfig.instance:getEventConfig(preEventId)
						local curEventConfig = MoLiDeErConfig.instance:getEventConfig(eventInfo.eventId)
						local prePos = string.splitToNumber(preEventConfig.position, "#")
						local curPos = string.splitToNumber(curEventConfig.position, "#")

						if not MoLiDeErHelper.checkIsInSamePosition(prePos, curPos) then
							logNormal("莫莉德尔 角色活动 显示延展路线效果 前置id: " .. tostring(preEventId) .. "新事件id:" .. tostring(eventInfo.eventId))
							self:doEventLineTween(prePos, curPos)

							newLineCount = newLineCount + 1
						end
					end
				end
			end

			if newEventCount > 0 then
				TaskDispatcher.runDelay(self.onNewTaskLineShowTimeEnd, self, MoLiDeErEnum.DelayTime.NewEventShow)

				if newLineCount > 0 then
					AudioMgr.instance:trigger(AudioEnum2_8.MoLiDeEr.play_ui_fuleyuan_lines_extend)
				end
			elseif self._finishItemCount > 0 then
				TaskDispatcher.runDelay(self.onNewTaskLineShowTimeEnd, self, MoLiDeErEnum.DelayTime.Close)
			else
				self:onNewTaskLineShowTimeEnd()
			end
		end
	end
end

function MoLiDeErGameView:onNewTaskLineShowTimeEnd()
	TaskDispatcher.cancelTask(self.onNewTaskLineShowTimeEnd, self)

	local itemList = self._eventItemList
	local itemCount = #itemList
	local startIndex = self._existItemCount + 1
	local endIndex = startIndex + self._finishItemCount - 1
	local currentRound = MoLiDeErGameModel.instance:getCurRound()

	for i = startIndex, endIndex do
		local item = itemList[i]

		if item == nil then
			logError(string.format("索引越界 index:%s itemCount :%s  existCount: %s finishItemCount : %s", i, tostring(#itemList), self._existItemCount, self._finishItemCount))
		else
			item:setActive(false)
		end
	end

	local eventInfos = self._infoMo.newEventList

	if eventInfos and eventInfos[1] then
		for index, eventInfo in ipairs(eventInfos) do
			local item
			local itemIndex = index + self._existItemCount + self._finishItemCount

			if itemCount < itemIndex then
				local itemGo = gohelper.clone(self._goeventItem, self._goeventMap)

				item = MonoHelper.addNoUpdateLuaComOnceToGo(itemGo, MoLiDeErEventItem)

				table.insert(itemList, item)
			else
				item = itemList[itemIndex]
			end

			item:setActive(true)
			item:setAtFirst()
			item:setData(eventInfo.eventId, eventInfo.isChose, eventInfo.eventEndRound, currentRound, eventInfo.teamId)
			item:showAnim(MoLiDeErEnum.AnimName.GameViewEventItemOpen, true)
			MoLiDeErGameController.instance:dispatchEvent(MoLiDeErEvent.GuideNewEvent, eventInfo.eventId)
		end

		TaskDispatcher.runDelay(self.onNewTaskShowTimeEnd, self, MoLiDeErEnum.DelayTime.BlackEnd)
		AudioMgr.instance:trigger(AudioEnum2_8.MoLiDeEr.play_ui_fuleyuan_newlevels_unlock)
	else
		self:onNewTaskShowTimeEnd()
	end
end

function MoLiDeErGameView:onNewTaskShowTimeEnd()
	TaskDispatcher.cancelTask(self.onNewTaskShowTimeEnd, self)
	self:_lockScreen(false)
end

function MoLiDeErGameView:refreshTeam()
	local item = self._dispatchItem

	item:setData(MoLiDeErEnum.DispatchState.Main)
end

function MoLiDeErGameView:onEventChange(eventId)
	if eventId ~= nil then
		local gameInfoMo = MoLiDeErGameModel.instance:getCurGameInfo()
		local eventInfo = gameInfoMo:getEventInfo(eventId)

		if eventInfo.isChose then
			if not MoLiDeErEnum.DispatchState.Dispatching then
				local state = MoLiDeErEnum.DispatchState.Dispatch

				ViewMgr.instance:openView(ViewName.MoLiDeErEventView, {
					eventId = eventId,
					state = state,
					optionId = eventInfo.optionId
				})
			end
		end
	end
end

function MoLiDeErGameView:checkTeamDispatchState(eventId)
	local gameInfoMo = self._infoMo

	if gameInfoMo.newDispatchEventDic and gameInfoMo.newDispatchEventDic[eventId] then
		MoLiDeErGameController.instance:dispatchEvent(MoLiDeErEvent.UIDispatchTeam, gameInfoMo.newDispatchEventDic[eventId])
		logNormal("莫莉德尔 角色活动 派出小队动效 id:" .. tostring(gameInfoMo.newDispatchEventDic[eventId]))

		return MoLiDeErEnum.TeamDispatchState.Dispatch
	elseif gameInfoMo.newBackTeamEventDic and gameInfoMo.newBackTeamEventDic[eventId] then
		MoLiDeErGameController.instance:dispatchEvent(MoLiDeErEvent.UIWithDrawTeam, gameInfoMo.newBackTeamEventDic[eventId])
		logNormal("莫莉德尔 角色活动 回收小队动效 id:" .. tostring(gameInfoMo.newBackTeamEventDic[eventId]))

		return MoLiDeErEnum.TeamDispatchState.WithDraw
	end

	return MoLiDeErEnum.TeamDispatchState.Dispatching
end

function MoLiDeErGameView:onViewOpen(viewName)
	if viewName == ViewName.MoLiDeErEventView then
		gohelper.setActive(self._goDispatch, false)
	end
end

function MoLiDeErGameView:onViewClose(viewName)
	if viewName == ViewName.MoLiDeErEventView then
		gohelper.setActive(self._goDispatch, true)
	end
end

function MoLiDeErGameView:forceCloseLock()
	logError("莫莉德尔 角色活动 事件出现表现超时 已强制关闭遮罩")
	self:_lockScreen(false)
	self:refreshUI(true)
end

function MoLiDeErGameView:onGameExit()
	self:closeThis()
end

function MoLiDeErGameView:onGameReset()
	self:refreshUI(true)
end

function MoLiDeErGameView:onGameSkip()
	self:closeThis()
end

function MoLiDeErGameView:_lockScreen(lock, time)
	if lock then
		TaskDispatcher.runDelay(self.forceCloseLock, self, time)
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock("MoLiDeErGameView")
		logNormal("莫莉德尔 角色活动 开始锁屏")
	else
		TaskDispatcher.cancelTask(self.forceCloseLock, self)
		UIBlockMgrExtend.setNeedCircleMv(true)
		UIBlockMgr.instance:endBlock("MoLiDeErGameView")
		logNormal("莫莉德尔 角色活动 结束锁屏")
	end
end

function MoLiDeErGameView:getOrReturnSolidLine(lineGo)
	if lineGo == nil then
		lineGo = self._unUseLineSolidList[1] == nil and gohelper.clone(self._goLineVirtual, self._goLineParent) or table.remove(self._unUseLineSolidList)

		table.insert(self._useLineSolidList, lineGo)
		gohelper.setActive(lineGo, true)

		return lineGo
	else
		tabletool.removeValue(self._useLineSolidList, lineGo)
		table.insert(self._unUseLineSolidList, lineGo)
		gohelper.setActive(lineGo, false)
	end
end

function MoLiDeErGameView:getOrReturnTargetFxLine(fxGo)
	if fxGo == nil then
		fxGo = self._unUseTargetFxList[1] == nil and gohelper.clone(self._goTargetFx, self._goeventMap) or table.remove(self._unUseTargetFxList)

		table.insert(self._useTargetFxList, fxGo)
		gohelper.setActive(fxGo, true)

		return fxGo
	else
		tabletool.removeValue(self._useTargetFxList, fxGo)
		table.insert(self._unUseTargetFxList, fxGo)
		gohelper.setActive(fxGo, false)
	end
end

function MoLiDeErGameView:doEventLineTween(prePos, curPos)
	local prePosX = prePos[1] + MoLiDeErEnum.EventCenterOffset.X
	local prePosY = prePos[2] + MoLiDeErEnum.EventCenterOffset.Y
	local curPosX = curPos[1] + MoLiDeErEnum.EventCenterOffset.X
	local curPosY = curPos[2] + MoLiDeErEnum.EventCenterOffset.Y
	local distance = math.sqrt((prePosX - curPosX)^2 + (prePosY - curPosY)^2)
	local angle = math.atan2(curPosY - prePosY, curPosX - prePosX) * (180 / math.pi)

	logNormal("莫莉德尔角色活动 线条开始位置 angle: " .. tostring(angle) .. "x: " .. tostring(prePosX) .. "y: " .. tostring(prePosY))

	local solidLineGo = self:getOrReturnSolidLine()

	transformhelper.setEulerAngles(solidLineGo.transform, 0, 0, angle)
	transformhelper.setLocalPos(solidLineGo.transform, prePosX, prePosY, 0)
	recthelper.setWidth(solidLineGo.transform, 0)
	transformhelper.setLocalScale(solidLineGo.transform, 1, 1, 1)

	local param = {
		go = solidLineGo,
		posX = curPosX,
		posY = curPosY
	}
	local tweenId = ZProj.TweenHelper.DOWidth(solidLineGo.transform, distance, MoLiDeErEnum.DelayTime.NewEventShow, self.onTweenLineEnd, self, param, EaseType.Linear)

	table.insert(self._tweenIdList, tweenId)
end

function MoLiDeErGameView:onTweenLineEnd(param)
	self:doEventLineTweenFade(param)
end

function MoLiDeErGameView:doEventLineTweenFade(param)
	local go = param.go
	local _, _, curAngleZ = transformhelper.getEulerAngles(go.transform)
	local finalAngleZ

	transformhelper.setEulerAngles(go.transform, 0, 0, curAngleZ < 180 and curAngleZ + 180 or curAngleZ - 180)
	transformhelper.setLocalScale(go.transform, 1, -1, 1)
	transformhelper.setLocalPos(go.transform, param.posX, param.posY, 0)

	local tweenId = ZProj.TweenHelper.DOWidth(go.transform, 0, MoLiDeErEnum.DelayTime.BlackEnd, self.onTweenLineFadeEnd, self, param, EaseType.Linear)

	table.insert(self._tweenIdList, tweenId)
end

function MoLiDeErGameView:onTweenLineFadeEnd(param)
	self:getOrReturnSolidLine(param.go)
end

function MoLiDeErGameView:addTitleTips(msg)
	table.insert(self._cacheMsgList, msg)

	if not self.hadTask then
		self:_showToast()
		TaskDispatcher.runRepeat(self._showToast, self, self._showNextToastInterval)

		self.hadTask = true
	end
end

function MoLiDeErGameView:_showToast()
	local msg = table.remove(self._cacheMsgList, 1)

	if not msg then
		TaskDispatcher.cancelTask(self._showToast, self)

		self.hadTask = false

		return
	end

	local newItem = table.remove(self._unUsedTipsItem, 1)

	if not newItem then
		local go = gohelper.clone(self._goTips, self._goTipsParent)

		newItem = MonoHelper.addNoUpdateLuaComOnceToGo(go, MoLiDeErTipItem)
	end

	local item

	if #self._usedTipsItem >= self._maxCount then
		self:recycleToast(self._usedTipsItem[1], true)
	end

	table.insert(self._usedTipsItem, newItem)
	newItem:setMsg(msg)
	newItem:setActive(true)
	newItem:appearAnimation()
end

function MoLiDeErGameView:recycleToast(item)
	local index = tabletool.indexOf(self._usedTipsItem, item)

	if index then
		table.remove(self._usedTipsItem, index)
	end

	item:reset()
	table.insert(self._unUsedTipsItem, item)
end

function MoLiDeErGameView:onClose()
	TaskDispatcher.cancelTask(self.onFinishTaskShowTimeEnd, self)
	TaskDispatcher.cancelTask(self.onNewTaskLineShowTimeEnd, self)
	TaskDispatcher.cancelTask(self.onNewTaskShowTimeEnd, self)
	TaskDispatcher.cancelTask(self.onTitleCountTimeEnd, self)
	TaskDispatcher.cancelTask(self._showToast, self)
	TaskDispatcher.cancelTask(self.onGameOver, self)
	TaskDispatcher.cancelTask(self.forceCloseLock, self)
	TaskDispatcher.cancelTask(self.onTargetFxAllShowEnd, self)
	TaskDispatcher.cancelTask(self.onTargetProgressAddFxShowEnd, self)
	MoLiDeErGameModel.instance:resetSelect()

	if self._tweenIdList[1] then
		for _, tweenId in ipairs(self._tweenIdList) do
			ZProj.TweenHelper.KillById(tweenId, false)
		end
	end

	self._tweenIdList = nil

	for _, tweenId in ipairs(self._targetFxTweenList) do
		ZProj.TweenHelper.KillById(tweenId)
	end

	self._targetFxTweenList = nil
end

function MoLiDeErGameView:onDestroyView()
	return
end

return MoLiDeErGameView
