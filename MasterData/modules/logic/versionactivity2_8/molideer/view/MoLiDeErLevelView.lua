-- chunkname: @modules/logic/versionactivity2_8/molideer/view/MoLiDeErLevelView.lua

module("modules.logic.versionactivity2_8.molideer.view.MoLiDeErLevelView", package.seeall)

local MoLiDeErLevelView = class("MoLiDeErLevelView", BaseView)

function MoLiDeErLevelView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._gopath = gohelper.findChild(self.viewGO, "#go_path")
	self._goscrollcontent = gohelper.findChild(self.viewGO, "#go_path/#go_scrollcontent")
	self._gostages = gohelper.findChild(self.viewGO, "#go_path/#go_scrollcontent/#go_stages")
	self._gotitle = gohelper.findChild(self.viewGO, "#go_title")
	self._simagetitle = gohelper.findChildSingleImage(self.viewGO, "#go_title/#simage_title")
	self._txtLimitTimeContainer = gohelper.findChild(self.viewGO, "#go_title/image_LimitTimeBG")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "#go_title/image_LimitTimeBG/#txt_LimitTime")
	self._btntask = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_task")
	self._goreddotreward = gohelper.findChild(self.viewGO, "#btn_task/#go_reddotreward")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")
	self._goPathParent = gohelper.findChild(self.viewGO, "#go_path/#go_scrollcontent/path/path_2")
	self._btnTrial = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Try/#btn_Trial")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MoLiDeErLevelView:addEvents()
	self._btntask:AddClickListener(self._btntaskOnClick, self)
	self._btnTrial:AddClickListener(self._btnTrialOnClick, self)
	self.addEventCb(self, MoLiDeErController.instance, MoLiDeErEvent.OnFinishEpisode, self.onEpisodeFinish, self)
	self.addEventCb(self, MoLiDeErController.instance, MoLiDeErEvent.OnClickEpisodeItem, self.onClickEpisodeItem, self)
end

function MoLiDeErLevelView:removeEvents()
	self._btntask:RemoveClickListener()
	self._btnTrial:RemoveClickListener()
	self.removeEventCb(self, MoLiDeErController.instance, MoLiDeErEvent.OnFinishEpisode, self.onEpisodeFinish, self)
	self.removeEventCb(self, MoLiDeErController.instance, MoLiDeErEvent.OnClickEpisodeItem, self.onClickEpisodeItem, self)
end

function MoLiDeErLevelView:_btnTrialOnClick()
	if ActivityHelper.getActivityStatus(self.actId) == ActivityEnum.ActivityStatus.Normal then
		local episodeId = self.actConfig.tryoutEpisode

		if episodeId <= 0 then
			logError("没有配置对应的试用关卡")

			return
		end

		local config = DungeonConfig.instance:getEpisodeCO(episodeId)

		DungeonFightController.instance:enterFight(config.chapterId, episodeId)
	else
		self:_clickLock()
	end
end

function MoLiDeErLevelView:_clickLock()
	local toastId, toastParamList = OpenHelper.getToastIdAndParam(self.actConfig.openId)

	if toastId and toastId ~= 0 then
		GameFacade.showToastWithTableParam(toastId, toastParamList)
	end
end

function MoLiDeErLevelView:_btntaskOnClick()
	ViewMgr.instance:openView(ViewName.MoLiDeErTaskView)
end

function MoLiDeErLevelView:_editableInitView()
	self._taskAnimator = self._btntask.gameObject:GetComponentInChildren(typeof(UnityEngine.Animator))

	RedDotController.instance:addRedDot(self._goreddotreward, RedDotEnum.DotNode.V2a8MoLiDeEr, nil, self._refreshRedDot, self)
	self:_initLevelItem()

	self._viewAnimator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(self._txtLimitTimeContainer, false)
end

function MoLiDeErLevelView:_initLevelItem()
	self._levelItemList = {}

	local parentTran = self._gostages.transform
	local count = parentTran.childCount

	for i = 1, count do
		local itemParent = parentTran:GetChild(i - 1)
		local name = string.format("item_%s", i)
		local itemObj = self:getResInst(self.viewContainer._viewSetting.otherRes[1], itemParent.gameObject, name)
		local item = MonoHelper.addNoUpdateLuaComOnceToGo(itemObj, MoLiDeErLevelItem)

		table.insert(self._levelItemList, item)
	end

	self._pathAnimItemList = {}

	local pathParentTran = self._goPathParent.transform
	local pathCount = pathParentTran.childCount

	for i = 1, pathCount do
		local itemParent = pathParentTran:GetChild(i - 1)
		local animatorComp = itemParent:GetComponent(typeof(UnityEngine.Animator))

		itemParent.name = string.format("path_%s", i + 1)

		table.insert(self._pathAnimItemList, animatorComp)
	end
end

function MoLiDeErLevelView:onUpdateParam()
	return
end

function MoLiDeErLevelView:onOpen()
	TaskDispatcher.runRepeat(self.updateTime, self, TimeUtil.OneMinuteSecond)

	self._actId = MoLiDeErModel.instance:getCurActId()
	self.actId = self._actId
	self.actConfig = ActivityConfig.instance:getActivityCo(self.actId)

	self:updateTime()
	self:refreshUI()

	local episodeId = self.viewParam.episodeId

	if episodeId then
		self:onClickEpisodeItem(0, episodeId)
	end

	if self:_checkFirstEnter() then
		local item = self._levelItemList[1]

		item:setAnimState(MoLiDeErEnum.LevelState.Unlock, true)
		AudioMgr.instance:trigger(AudioEnum2_8.MoLiDeEr.play_ui_yuzhou_level_lit)
		self:_lockScreen(true)
		TaskDispatcher.runDelay(self._playFirstUnlock, self, 0.8)
	end
end

function MoLiDeErLevelView:refreshUI()
	local noGameEpisodeList = MoLiDeErConfig.instance:getEpisodeListById(self._actId)

	if #noGameEpisodeList ~= #self._levelItemList then
		logError("levelItem Count not match")

		return
	end

	local focusIndex = 1
	local focusEpisodeId
	local actId = self._actId

	for index, item in ipairs(self._levelItemList) do
		local config = noGameEpisodeList[index]
		local preEpisodeId = config.preEpisodeId
		local isPreFinish = MoLiDeErModel.instance:isEpisodeFinish(actId, preEpisodeId)
		local isFinish = MoLiDeErModel.instance:isEpisodeFinish(actId, config.episodeId)
		local isUnlock = preEpisodeId == nil or preEpisodeId == 0 or isPreFinish

		item:setActive(isUnlock)
		item:setData(index, config)

		if isUnlock then
			item:refreshUI(false)

			focusIndex = index
			focusEpisodeId = config.episodeId
		end

		self:setPathItemState(index, isFinish, false)
	end

	self:_focusStoryItem(focusEpisodeId)
end

function MoLiDeErLevelView:_focusStoryItem(focusEpisodeId)
	for index, item in ipairs(self._levelItemList) do
		local focus = item.episodeId == focusEpisodeId

		item:setFocus(focus)
	end
end

function MoLiDeErLevelView:setPathItemState(index, isFinish, playAnim)
	local pathAnimItem = self._pathAnimItemList[index]

	if pathAnimItem then
		gohelper.setActive(pathAnimItem.gameObject, isFinish)

		if not isFinish then
			return
		end

		if playAnim then
			if not MoLiDeErEnum.AnimName.LevelPathItemFinish then
				local animName = MoLiDeErEnum.AnimName.LevelPathItemFinished

				pathAnimItem:Play(animName, 0)
			end
		end
	end
end

function MoLiDeErLevelView:onClickEpisodeItem(index, episodeId)
	MoLiDeErController.instance:enterEpisode(self._actId, episodeId)
end

function MoLiDeErLevelView:onEpisodeFinish(actId, episodeId, isSkipGame)
	if actId ~= self._actId then
		return
	end

	if not isSkipGame then
		self:_checkRedDot()
	end

	self._finishEpisodeId = episodeId
	self._isSkipGame = isSkipGame

	self:_lockScreen(true)
	self._viewAnimator:Play(MoLiDeErEnum.AnimName.LevelViewOpen)
	TaskDispatcher.runDelay(self.onLevelOpenAnimTimeEnd, self, MoLiDeErEnum.LevelAnimTime.LevelViewOpen)
	TaskDispatcher.runDelay(self.forceEndBlock, self, MoLiDeErEnum.LevelAnimTime.LevelForceEndBlock)
end

function MoLiDeErLevelView:_checkRedDot()
	logNormal("莫莉德尔角色活动 关卡完成 请求红点")
	RedDotRpc.instance:sendGetRedDotInfosRequest({
		RedDotEnum.DotNode.V2a8MoLiDeErTask
	})
end

function MoLiDeErLevelView:forceEndBlock()
	logError("莫莉德尔角色活动 关卡解锁表现超时")
	self:_lockScreen(false)
end

function MoLiDeErLevelView:onLevelOpenAnimTimeEnd()
	TaskDispatcher.cancelTask(self.onLevelOpenAnimTimeEnd, self)

	local finishEpisodeId = self._finishEpisodeId
	local finishItem

	for _, item in ipairs(self._levelItemList) do
		if item.episodeId == finishEpisodeId then
			finishItem = item

			break
		end
	end

	if finishItem == nil then
		logError("莫莉德尔 角色活动 不存在对应关卡id的level item id:" .. tostring(finishEpisodeId))

		return
	end

	if not MoLiDeErModel.instance:isEpisodeFinish(self._actId, finishEpisodeId, true) or self._isSkipGame == true then
		logNormal("莫莉德尔 角色活动 非首次通关")

		if not self._isSkipGame then
			finishItem:setStarState(true)
		end

		self:onLevelUnlockAnimTimeEnd()

		self._isSkipGame = false

		return
	end

	finishItem:refreshUI(true)
	AudioMgr.instance:trigger(AudioEnum2_8.MoLiDeEr.play_ui_yuzhou_level_lit)

	local index = finishItem.index

	self:setPathItemState(index, true, true)

	if index < #self._levelItemList then
		TaskDispatcher.runDelay(self.onLevelFinishAnimTimeEnd, self, MoLiDeErEnum.LevelAnimTime.LevelItemFinish)
	else
		self:_focusStoryItem(finishItem.episodeId)
		TaskDispatcher.runDelay(self.onLevelUnlockAnimTimeEnd, self, MoLiDeErEnum.LevelAnimTime.LevelItemFinish)
	end
end

function MoLiDeErLevelView:onLevelFinishAnimTimeEnd()
	TaskDispatcher.cancelTask(self.onLevelFinishAnimTimeEnd, self)

	local finishEpisodeId = self._finishEpisodeId
	local finishItem

	for _, item in ipairs(self._levelItemList) do
		if item.preEpisodeId == finishEpisodeId then
			finishItem = item

			break
		end
	end

	if finishItem == nil then
		logError("莫莉德尔 角色活动 不存在对应关卡id的level item id:" .. tostring(finishEpisodeId))

		return
	end

	finishItem:setActive(true)
	finishItem:refreshUI(true)
	AudioMgr.instance:trigger(AudioEnum2_8.MoLiDeEr.play_ui_fuleyuan_newlevels_unlock)
	self:_focusStoryItem(finishItem.episodeId)
	TaskDispatcher.runDelay(self.onLevelUnlockAnimTimeEnd, self, MoLiDeErEnum.LevelAnimTime.LevelItemUnlock)
end

function MoLiDeErLevelView:onLevelUnlockAnimTimeEnd()
	TaskDispatcher.cancelTask(self.onLevelUnlockAnimTimeEnd, self)
	TaskDispatcher.cancelTask(self.forceEndBlock, self)

	self._finishEpisodeId = nil

	self:_lockScreen(false)
end

function MoLiDeErLevelView:_playFirstUnlock()
	TaskDispatcher.cancelTask(self._playFirstUnlock, self)
	self:_lockScreen(false)
end

function MoLiDeErLevelView:updateTime()
	local activityId = self._actId
	local actInfoMo = ActivityModel.instance:getActivityInfo()[activityId]

	if actInfoMo then
		local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

		if offsetSecond > 0 then
			if self._txtLimitTime ~= nil then
				self._txtLimitTime.text = TimeUtil.SecondToActivityTimeFormat(offsetSecond)
			end

			return
		end
	end

	TaskDispatcher.cancelTask(self.updateTime, self)
end

function MoLiDeErLevelView:_refreshRedDot(reddot)
	reddot:defaultRefreshDot()

	local showRedDot = reddot.show

	self._taskAnimator:Play(showRedDot and "loop" or "idle")
end

function MoLiDeErLevelView:_lockScreen(lock)
	if lock then
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock("MoLiDeErLevelView")
	else
		UIBlockMgr.instance:endBlock("MoLiDeErLevelView")
		UIBlockMgrExtend.setNeedCircleMv(true)
	end
end

function MoLiDeErLevelView:_checkFirstEnter()
	local item = self._levelItemList[2]

	if item and not MoLiDeErModel.instance:isEpisodeFinish(self._actId, item.preEpisodeId) then
		local key = string.format("ActMoLiDeErFirstEnter_%s", PlayerModel.instance:getMyUserId())
		local record = PlayerPrefsHelper.getNumber(key, 0)

		if record == 0 then
			PlayerPrefsHelper.setNumber(key, 1)

			return true
		end
	end

	return false
end

function MoLiDeErLevelView:onClose()
	TaskDispatcher.cancelTask(self.updateTime, self)
end

function MoLiDeErLevelView:onDestroyView()
	TaskDispatcher.cancelTask(self.updateTime, self)
end

return MoLiDeErLevelView
