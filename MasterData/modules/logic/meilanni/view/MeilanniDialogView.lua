-- chunkname: @modules/logic/meilanni/view/MeilanniDialogView.lua

module("modules.logic.meilanni.view.MeilanniDialogView", package.seeall)

local MeilanniDialogView = class("MeilanniDialogView", BaseView)

function MeilanniDialogView:onInitView()
	self._scrolldialog = gohelper.findChildScrollRect(self.viewGO, "top_right/#scroll_dialog")
	self._goscrollcontainer = gohelper.findChild(self.viewGO, "top_right/#scroll_dialog/viewport/#go_scrollcontainer")
	self._goscrollcontent = gohelper.findChild(self.viewGO, "top_right/#scroll_dialog/viewport/#go_scrollcontainer/#go_scrollcontent")
	self._goblock = gohelper.findChild(self.viewGO, "#go_block")
	self._goblockhelp = gohelper.findChild(self.viewGO, "top_left_block/#go_block_help")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MeilanniDialogView:addEvents()
	return
end

function MeilanniDialogView:removeEvents()
	return
end

function MeilanniDialogView:_btnresetOnClick()
	return
end

function MeilanniDialogView:_editableInitView()
	local viewport = gohelper.findChild(self.viewGO, "top_right/#scroll_dialog/viewport")

	self._viewportHeight = recthelper.getHeight(viewport.transform)
end

function MeilanniDialogView:onUpdateParam()
	return
end

function MeilanniDialogView:onOpen()
	self._dialogItemMap = self:getUserDataTb_()
	self._dialogItemList = self:getUserDataTb_()
	self._mapId = MeilanniModel.instance:getCurMapId()
	self._mapInfo = MeilanniModel.instance:getMapInfo(self._mapId)

	self.addEventCb(self, MeilanniController.instance, MeilanniEvent.clickEventItem, self._clickEventItem, self)
	self.addEventCb(self, MeilanniController.instance, MeilanniEvent.episodeInfoUpdate, self._episodeInfoUpdate, self)
	self.addEventCb(self, MeilanniController.instance, MeilanniEvent.dialogChange, self._dialogChange, self)
	self.addEventCb(self, MeilanniController.instance, MeilanniEvent.resetDialogPos, self._resetDialogPos, self)
	self.addEventCb(self, MeilanniController.instance, MeilanniEvent.dialogClose, self._dialogClose, self)
	self.addEventCb(self, MeilanniController.instance, MeilanniEvent.resetMap, self._resetMap, self)
	self.addEventCb(self, MeilanniAnimationController.instance, MeilanniEvent.dialogListAnimChange, self._dialogListAnimChange, self)
	self:_showAllEpisodeHistory()
end

function MeilanniDialogView:_dialogListAnimChange(isPlay)
	gohelper.setActive(self._goblock, isPlay)
	gohelper.setActive(self._goblockhelp, isPlay)
	TaskDispatcher.cancelTask(self._hideBlock, self)

	if isPlay then
		TaskDispatcher.runDelay(self._hideBlock, self, 20)
	else
		self:_dialogChange()
	end
end

function MeilanniDialogView:_hideBlock()
	gohelper.setActive(self._goblock, false)
	gohelper.setActive(self._goblockhelp, false)
end

function MeilanniDialogView:_resetMap()
	self._dialogItemMap = self:getUserDataTb_()
	self._dialogItemList = self:getUserDataTb_()
	self._episodeInfo = nil

	gohelper.destroyAllChildren(self._goscrollcontent)
	recthelper.setHeight(self._goscrollcontainer.transform, self._viewportHeight)

	self._scrolldialog.verticalNormalizedPosition = 1

	self:_showAllEpisodeHistory()
end

function MeilanniDialogView:_dialogClose()
	self:_delayRefreshDialog(0.1)
end

function MeilanniDialogView:_dialogChange(dialogItem)
	self:_delayRefreshDialog(0.1)
end

function MeilanniDialogView:_delayRefreshDialog(time)
	TaskDispatcher.cancelTask(self._refreshDialog, self)
	TaskDispatcher.runDelay(self._refreshDialog, self, time)
end

function MeilanniDialogView:_resetDialogPos()
	if self._tweenFloatId then
		return
	end

	local from = self._scrolldialog.verticalNormalizedPosition
	local to = 0

	self:_tweenScroll(from, to, self._tweenFrame)
end

function MeilanniDialogView:_refreshDialog()
	local contentHeight = recthelper.getHeight(self._goscrollcontent.transform)

	recthelper.setHeight(self._goscrollcontainer.transform, contentHeight)
	self:_adjustContainerHeight()

	local containerHeight = recthelper.getHeight(self._goscrollcontainer.transform)

	if self._prevHeight then
		if MeilanniAnimationController.instance:isPlaying() then
			containerHeight = math.max(containerHeight, self._prevHeight)
		elseif containerHeight < self._prevHeight and self._prevHeight - containerHeight <= 160 then
			containerHeight = self._prevHeight
		end
	end

	recthelper.setHeight(self._goscrollcontainer.transform, containerHeight)

	self._prevHeight = containerHeight

	self:_startTween()
end

function MeilanniDialogView:_startTween()
	local contentHeight = recthelper.getHeight(self._goscrollcontent.transform)

	if contentHeight <= self._viewportHeight then
		local from = recthelper.getAnchorY(self._goscrollcontainer.transform)
		local to = math.max(contentHeight - self._viewportHeight, 0)

		self:_tweenScroll(from, to, self._tweenFrameAnchorY)
	else
		local from = self._scrolldialog.verticalNormalizedPosition
		local to = 0

		self:_tweenScroll(from, to, self._tweenFrame)
	end
end

function MeilanniDialogView:_tweenScroll(from, to, frameHandler)
	if not self._firstTween then
		self._firstTween = true

		self:_tweenFinish()

		return
	end

	if from == to then
		return
	end

	if self._tweenFloatId then
		ZProj.TweenHelper.KillById(self._tweenFloatId)
	end

	self._tweenFloatId = ZProj.TweenHelper.DOTweenFloat(from, to, 0.8, frameHandler, self._tweenFinish, self, nil, EaseType.OutQuint)
end

function MeilanniDialogView:_tweenFrameAnchorY(value)
	recthelper.setAnchorY(self._goscrollcontainer.transform, value)
end

function MeilanniDialogView:_tweenFrame(value)
	self._scrolldialog.verticalNormalizedPosition = value
end

function MeilanniDialogView:_tweenFinish()
	self._scrolldialog.verticalNormalizedPosition = 0
	self._tweenFloatId = nil
end

function MeilanniDialogView:_adjustContainerHeight()
	local topDialogItem

	for i = #self._dialogItemList, 1, -1 do
		local dialogItem = self._dialogItemList[i]

		if gohelper.isNil(dialogItem.viewGO) or not dialogItem:getEpisodeInfo() then
			table.remove(self._dialogItemList, i)
		else
			local isTopDialog = dialogItem:isTopDialog()

			if isTopDialog then
				topDialogItem = dialogItem

				break
			end
		end
	end

	if topDialogItem then
		local tr = topDialogItem.viewGO.transform
		local y = recthelper.getAnchorY(tr)
		local targetHeight = math.abs(y) + self._viewportHeight
		local containerHeight = recthelper.getHeight(self._goscrollcontainer.transform)
		local value = math.max(targetHeight, containerHeight)

		recthelper.setHeight(self._goscrollcontainer.transform, value)
	end
end

function MeilanniDialogView:_episodeInfoUpdate(eventId)
	local episodeInfo = self._mapInfo:getCurEpisodeInfo()

	if self._episodeInfo then
		if eventId then
			MeilanniAnimationController.instance:addDelayCall(self._showEventHistoryDelay, self, {
				self._mapInfo:getEpisodeInfo(self._episodeInfo.episodeId),
				eventId
			}, MeilanniEnum.selectedTime, MeilanniAnimationController.historyLayer)
		end

		if self._episodeInfo.isFinish and self._episodeInfo.confirm then
			if self:_checkShowEpisodeSkipDialogs(self._episodeInfo) then
				MeilanniAnimationController.instance:addDelayCall(self._delayCallShowEpisodeSkipDialogs, self, self._episodeInfo, MeilanniEnum.skipTime, MeilanniAnimationController.epilogueLayer)
			end

			if self:_checkShowEpilogue(self._episodeInfo) then
				MeilanniAnimationController.instance:addDelayCall(self._showEpilogue, self, self._episodeInfo, MeilanniEnum.epilogueTime, MeilanniAnimationController.epilogueLayer)
			end
		end
	end

	if self:_checkShowPreface(episodeInfo) then
		MeilanniAnimationController.instance:addDelayCall(self._showPreface, self, episodeInfo, MeilanniEnum.prefaceTime, MeilanniAnimationController.prefaceLayer)
	end

	if self:_showConfirm(episodeInfo) then
		MeilanniAnimationController.instance:addDelayCall(self._delayCallCheckConfirm, self, episodeInfo, MeilanniEnum.confirmTime, MeilanniAnimationController.prefaceLayer)
	end

	MeilanniAnimationController.instance:addDelayCall(self._dispatchGuideDayEvent, self, nil, 0, MeilanniAnimationController.prefaceLayer)
	MeilanniAnimationController.instance:endAnimation(MeilanniAnimationController.endLayer)
end

function MeilanniDialogView:_delayCallCheckConfirm(episodeInfo)
	self:_showEndDialog(episodeInfo)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_Insight_close)
end

function MeilanniDialogView:_checkConfirm(episodeInfo)
	if self:_showConfirm(episodeInfo) then
		self:_showEndDialog(episodeInfo)
	end
end

function MeilanniDialogView:_showConfirm(episodeInfo)
	if episodeInfo and episodeInfo.isFinish and not episodeInfo.confirm then
		return true
	end

	local mapInfo = MeilanniModel.instance:getMapInfo(self._mapId)

	if not episodeInfo.isFinish and not episodeInfo.confirm and mapInfo.score <= 0 then
		return true
	end
end

function MeilanniDialogView:_dispatchGuideDayEvent()
	local episodeInfo = self._mapInfo:getCurEpisodeInfo()

	if not episodeInfo then
		return
	end

	if episodeInfo.episodeId == 10101 then
		MeilanniController.instance:dispatchEvent(MeilanniEvent.guideEnterMapDay1)
	elseif episodeInfo.episodeId == 10102 then
		MeilanniController.instance:dispatchEvent(MeilanniEvent.guideEnterMapDay2)
	end
end

function MeilanniDialogView:_clickEventItem(eventItem)
	local elementInfo = eventItem._info
	local id = elementInfo.eventId
	local type = elementInfo:getType()

	if type == MeilanniEnum.ElementType.Battle then
		MeilanniController.instance:startBattle(id)
	elseif type == MeilanniEnum.ElementType.Dialog then
		local episodeInfo = self._mapInfo:getCurEpisodeInfo()

		if episodeInfo.leftActPoint - episodeInfo.specialEventNum <= 0 and elementInfo.config.type == 0 then
			GameFacade.showToast(ToastEnum.MeilanniDialog)

			return
		end

		eventItem:setSelected(true)
		MeilanniController.instance:dispatchEvent(MeilanniEvent.setElementsVisible, false, eventItem)
		self:_playDialog(eventItem)
	end
end

function MeilanniDialogView:_playDialog(eventItem)
	local episodeInfo = self._mapInfo:getCurEpisodeInfo()
	local dialogItem = self:_getCacheDialogItem(episodeInfo, eventItem._eventId)

	dialogItem:playDialog(eventItem)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_Insight_close)

	dialogItem.viewGO.name = string.format("meilannidialogitem_%s_%s", episodeInfo.episodeId, eventItem._eventId)
end

function MeilanniDialogView:_getCacheDialogItem(episodeInfo, eventId)
	local dialogItem = self._dialogItemMap[eventId]

	if dialogItem and gohelper.isNil(dialogItem.viewGO) then
		dialogItem = nil
	end

	dialogItem = dialogItem or self:_getDialogItem(episodeInfo)
	self._dialogItemMap[eventId] = dialogItem

	return dialogItem
end

function MeilanniDialogView:_showEmeny(episodeInfo)
	if self._episodeInfo and episodeInfo.episodeId == self._episodeInfo.episodeId then
		return
	end

	local prevEpisodeInfo = self._episodeInfo
	local showEmeny = episodeInfo.episodeConfig.showBoss == 1

	if showEmeny and prevEpisodeInfo and prevEpisodeInfo.episodeConfig.showBoss ~= 1 then
		TaskDispatcher.cancelTask(self._showBossInfoView, self)
		TaskDispatcher.runDelay(self._showBossInfoView, self, 0.8)
	end
end

function MeilanniDialogView:_showBossInfoView()
	MeilanniController.instance:openMeilanniBossInfoView({
		mapId = self._mapId
	})
end

function MeilanniDialogView:_showPreface(episodeInfo)
	if self._episodeInfo and episodeInfo.episodeId == self._episodeInfo.episodeId then
		return
	end

	self._episodeInfo = episodeInfo

	local episodeConfig = episodeInfo.episodeConfig

	if string.nilorempty(episodeConfig.preface) then
		return
	end

	local dialogItem = self:_getDialogItem(episodeInfo)

	dialogItem:playDesc(episodeConfig.preface)

	dialogItem.viewGO.name = string.format("meilannidialogitem_%s_preface", episodeInfo.episodeId)
end

function MeilanniDialogView:_checkShowPreface(episodeInfo)
	if self._episodeInfo and episodeInfo.episodeId == self._episodeInfo.episodeId then
		return
	end

	local episodeConfig = episodeInfo.episodeConfig

	if string.nilorempty(episodeConfig.preface) then
		return
	end

	return true
end

function MeilanniDialogView:_showEpilogue(episodeInfo)
	if not self:_checkShowEpilogue(episodeInfo) then
		return
	end

	local episodeConfig = episodeInfo.episodeConfig
	local dialogItem = self:_getDialogItem(episodeInfo)

	dialogItem:showEpilogue(episodeConfig.epilogue)
end

function MeilanniDialogView:_checkShowEpilogue(episodeInfo)
	if not episodeInfo then
		return
	end

	local episodeConfig = episodeInfo.episodeConfig

	if string.nilorempty(episodeConfig.epilogue) then
		return
	end

	return true
end

function MeilanniDialogView:_showDialogHistory(episodeInfo, eventInfo, index, eventIndex)
	local dialogItem = self:_getCacheDialogItem(episodeInfo, eventInfo.eventId)

	dialogItem:showHistory(eventInfo, index, eventIndex)
end

function MeilanniDialogView:_showSkipDialog(episodeInfo, eventInfo, index, eventIndex)
	local dialogItem = self:_getDialogItem(episodeInfo)

	dialogItem:showSkipDialog(eventInfo, index, eventIndex)
end

function MeilanniDialogView:_showEndDialog(episodeInfo, eventInfo, index, eventIndex)
	local dialogItem = self:_getDialogItem(episodeInfo)

	dialogItem:showEndDialog(eventInfo)
end

function MeilanniDialogView:_getDialogItem(episodeInfo)
	local itemPath = self.viewContainer:getSetting().otherRes[2]
	local itemGo = self:getResInst(itemPath, self._goscrollcontent)
	local dialogItem = MonoHelper.addNoUpdateLuaComOnceToGo(itemGo, MeilanniDialogItem)

	dialogItem:setEpisodeInfo(episodeInfo)
	table.insert(self._dialogItemList, dialogItem)

	return dialogItem
end

function MeilanniDialogView:_showAllEpisodeHistory()
	local num = #self._mapInfo.episodeInfos

	MeilanniModel.instance:setDialogItemFadeIndex(-1)

	for i, v in ipairs(self._mapInfo.episodeInfos) do
		if i == num then
			MeilanniModel.instance:setDialogItemFadeIndex(0)
			self:_showEpisodeHistory(v)
			self:_checkConfirm(v)
		else
			self:_showEpisodeHistory(v)
		end
	end

	MeilanniModel.instance:setDialogItemFadeIndex(nil)
	self:_dispatchGuideDayEvent()
end

function MeilanniDialogView:_showEpisodeHistory(episodeInfo)
	self:_showPreface(episodeInfo)

	local prevEventId
	local eventIndex = 1

	for i, episodeHistory in ipairs(episodeInfo.historylist) do
		local eventId = episodeHistory.eventId
		local index = episodeHistory.index
		local eventInfo = episodeInfo:getEventInfo(eventId)
		local interactParam = eventInfo.interactParam[index + 1]
		local interactType = interactParam[1]

		if interactType == MeilanniEnum.ElementType.Dialog then
			self:_showDialogHistory(episodeInfo, eventInfo, index, eventIndex)

			if prevEventId ~= eventId then
				prevEventId = eventId
				eventIndex = eventIndex + 1
			end
		end
	end

	if episodeInfo.isFinish and episodeInfo.confirm then
		self:_showEpisodeSkipDialogs(episodeInfo)
		self:_showEpilogue(episodeInfo)
	end
end

function MeilanniDialogView:_showEventHistoryDelay(param)
	self:_showEventHistory(param[1], param[2])
end

function MeilanniDialogView:_showEventHistory(episodeInfo, targetEventId)
	if not targetEventId then
		return
	end

	local dialogItem = self._dialogItemMap[targetEventId]

	if dialogItem then
		dialogItem:clearConfig()
	end

	for i, episodeHistory in ipairs(episodeInfo.historylist) do
		local eventId = episodeHistory.eventId

		if eventId == targetEventId then
			local index = episodeHistory.index
			local eventInfo = episodeInfo:getEventInfo(eventId)
			local interactParam = eventInfo.interactParam[index + 1]
			local interactType = interactParam[1]

			if interactType == MeilanniEnum.ElementType.Dialog then
				self:_showDialogHistory(episodeInfo, eventInfo, index)
			end
		end
	end
end

function MeilanniDialogView:_delayCallShowEpisodeSkipDialogs(episodeInfo)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_Insight_close)
	self:_showEpisodeSkipDialogs(episodeInfo)
	self:_delayRefreshDialog(0)
end

function MeilanniDialogView:_showEpisodeSkipDialogs(episodeInfo)
	if not episodeInfo.isFinish then
		return
	end

	local eventIndex = episodeInfo.historyLen + 1

	for i, eventInfo in ipairs(episodeInfo.events) do
		if not eventInfo.isFinish and eventInfo:getSkipDialog() then
			self:_showSkipDialog(episodeInfo, eventInfo, nil, eventIndex)

			eventIndex = eventIndex + 1
		end
	end
end

function MeilanniDialogView:_checkShowEpisodeSkipDialogs(episodeInfo)
	if not episodeInfo.isFinish then
		return
	end

	for i, eventInfo in ipairs(episodeInfo.events) do
		if not eventInfo.isFinish and eventInfo:getSkipDialog() then
			return true
		end
	end
end

function MeilanniDialogView:onClose()
	self.removeEventCb(self, MeilanniController.instance, MeilanniEvent.clickEventItem, self._clickEventItem, self)
	self.removeEventCb(self, MeilanniController.instance, MeilanniEvent.episodeInfoUpdate, self._episodeInfoUpdate, self)
	self.removeEventCb(self, MeilanniController.instance, MeilanniEvent.dialogChange, self._dialogChange, self)
	self.removeEventCb(self, MeilanniController.instance, MeilanniEvent.resetDialogPos, self._resetDialogPos, self)
	self.removeEventCb(self, MeilanniController.instance, MeilanniEvent.dialogClose, self._dialogClose, self)
	self.removeEventCb(self, MeilanniController.instance, MeilanniEvent.resetMap, self._resetMap, self)
	TaskDispatcher.cancelTask(self._refreshDialog, self)
	TaskDispatcher.cancelTask(self._showBossInfoView, self)
	TaskDispatcher.cancelTask(self._hideBlock, self)

	if self._tweenFloatId then
		ZProj.TweenHelper.KillById(self._tweenFloatId)
	end

	MeilanniAnimationController.instance:close()
end

function MeilanniDialogView:onDestroyView()
	return
end

return MeilanniDialogView
