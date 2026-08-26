-- chunkname: @modules/logic/versionactivity3_1/gaosiniao/view/V3a1_GaoSiNiao_LevelView.lua

local csAnimatorPlayer = SLFramework.AnimatorPlayer

module("modules.logic.versionactivity3_1.gaosiniao.view.V3a1_GaoSiNiao_LevelView", package.seeall)

local V3a1_GaoSiNiao_LevelView = class("V3a1_GaoSiNiao_LevelView", BaseView)

function V3a1_GaoSiNiao_LevelView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simageStageBG = gohelper.findChildSingleImage(self.viewGO, "#simage_StageBG")
	self._simageMask = gohelper.findChildSingleImage(self.viewGO, "#simage_Mask")
	self._gopath = gohelper.findChild(self.viewGO, "#go_path")
	self._goscrollcontent = gohelper.findChild(self.viewGO, "#go_path/#go_scrollcontent")
	self._gostages = gohelper.findChild(self.viewGO, "#go_path/#go_scrollcontent/#go_stages")
	self._gotitle = gohelper.findChild(self.viewGO, "#go_title")
	self._simagetitle = gohelper.findChildSingleImage(self.viewGO, "#go_title/#simage_title")
	self._txtlimittime = gohelper.findChildText(self.viewGO, "#go_title/image_LimitTimeBG/#txt_limittime")
	self._btntask = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_task")
	self._goreddotreward = gohelper.findChild(self.viewGO, "#btn_task/#go_reddotreward")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")
	self._btnEndless = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Endless")
	self._btnTrial = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Try/image_TryBtn")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a1_GaoSiNiao_LevelView:addEvents()
	self._btntask:AddClickListener(self._btntaskOnClick, self)
	self._btnTrial:AddClickListener(self._btnTrialOnClick, self)
	self._btnEndless:AddClickListener(self._btnEndlessOnClick, self)
end

function V3a1_GaoSiNiao_LevelView:removeEvents()
	self._btntask:RemoveClickListener()
	self._btnEndless:RemoveClickListener()
	self._btnTrial:RemoveClickListener()
end

function V3a1_GaoSiNiao_LevelView:_btnTrialOnClick()
	if ActivityHelper.isOpen(self:_actId()) then
		local episodeId = self.config.tryoutEpisode

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

function V3a1_GaoSiNiao_LevelView:_clickLock()
	local toastId, toastParamList = OpenHelper.getToastIdAndParam(self.config.openId)

	if toastId and toastId ~= 0 then
		GameFacade.showToastWithTableParam(toastId, toastParamList)
	end
end

function V3a1_GaoSiNiao_LevelView:ctor(...)
	V3a1_GaoSiNiao_LevelView.super.ctor(self, ...)

	self._itemObjList = {}
end

function V3a1_GaoSiNiao_LevelView:_actId()
	return self.viewContainer:actId()
end

function V3a1_GaoSiNiao_LevelView:_taskType()
	return self.viewContainer:taskType()
end

function V3a1_GaoSiNiao_LevelView:_enterGame(episodeId)
	self.viewContainer:enterGame(episodeId)
end

function V3a1_GaoSiNiao_LevelView:_btntaskOnClick()
	local viewParam = {
		actId = self:_actId(),
		taskType = self:_taskType()
	}

	ViewMgr.instance:openView(ViewName.V3a1_GaoSiNiao_TaskView, viewParam)
end

function V3a1_GaoSiNiao_LevelView:_btnEndlessOnClick()
	local episodeCO = self:_spCO()
	local episodeId = episodeCO.episodeId

	self:_enterGame(episodeId)
end

function V3a1_GaoSiNiao_LevelView:_onReceiveAct210EpisodePush()
	return
end

function V3a1_GaoSiNiao_LevelView:_onReceiveGetAct210InfoReply()
	self:onUpdateParam()
end

function V3a1_GaoSiNiao_LevelView:_onReceiveAct210FinishEpisodeReply(msg)
	self:onUpdateParam()
end

function V3a1_GaoSiNiao_LevelView:_editableInitView()
	self._btnEndlessGo = self._btnEndless.gameObject
	self.config = ActivityConfig.instance:getActivityCo(self:_actId())
	self._gotaskani = gohelper.findChild(self.viewGO, "#btn_task/ani")
	self._animTask = self._gotaskani:GetComponent(typeof(UnityEngine.Animator))

	local goPathFmt = "stage%s/Point/#go_StageItemContainer"

	self._goStageItemContainerList = self:getUserDataTb_()

	local i = 0

	repeat
		i = i + 1

		local go_StageItemContainer = gohelper.findChild(self._gostages, string.format(goPathFmt, i))
		local isNil = gohelper.isNil(go_StageItemContainer)

		if not isNil then
			table.insert(self._goStageItemContainerList, go_StageItemContainer)
		end
	until isNil

	self._animatorPlayerPath = csAnimatorPlayer.Get(self._gopath)
	self._animatorPlayerEndless = csAnimatorPlayer.Get(self._btnEndlessGo)

	local uid = 0

	RedDotController.instance:addRedDot(self._goreddotreward, RedDotEnum.DotNode.V3a1GaoSiNiaoTask, uid)
	self:setActive_btnEndlessGo(false)
end

function V3a1_GaoSiNiao_LevelView:_clearCacheListData()
	self._tmpSPCO = nil
	self._tmpDataList = nil
end

function V3a1_GaoSiNiao_LevelView:onUpdateParam()
	self:_clearCacheListData()
	self:_refreshLeftTime()
	self:_refresh()
	TaskDispatcher.cancelTask(self._refreshLeftTime, self)
	TaskDispatcher.runRepeat(self._refreshLeftTime, self, TimeUtil.OneMinuteSecond)
end

function V3a1_GaoSiNiao_LevelView:onOpen()
	AudioMgr.instance:trigger(AudioEnum3_1.GaoSiNiao.play_ui_mingdi_gsn_open)
	self:onUpdateParam()
	self.addEventCb(self, GaoSiNiaoController.instance, GaoSiNiaoEvent.onReceiveAct210EpisodePush, self._onReceiveAct210EpisodePush, self)
	self.addEventCb(self, GaoSiNiaoController.instance, GaoSiNiaoEvent.onReceiveGetAct210InfoReply, self._onReceiveGetAct210InfoReply, self)
	self.addEventCb(self, GaoSiNiaoController.instance, GaoSiNiaoEvent.onReceiveAct210FinishEpisodeReply, self._onReceiveAct210FinishEpisodeReply, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
end

function V3a1_GaoSiNiao_LevelView:onOpenFinish()
	GameUtil.onDestroyViewMember(self, "_onOpenFinishFlow")

	self._onOpenFinishFlow = V3a1_GaoSiNiao_LevelView_OpenFinishFlow.New()

	self._onOpenFinishFlow:start(self)
end

function V3a1_GaoSiNiao_LevelView:onClose()
	TaskDispatcher.cancelTask(self._refreshLeftTime, self)
	GameUtil.onDestroyViewMember(self, "_onOpenFinishFlow")
end

function V3a1_GaoSiNiao_LevelView:onDestroyView()
	GameUtil.onDestroyViewMember(self, "_onOpenFinishFlow")
	TaskDispatcher.cancelTask(self._refreshLeftTime, self)
	GameUtil.onDestroyViewMemberList(self, "_itemObjList")
end

function V3a1_GaoSiNiao_LevelView:_refresh()
	self:_refreshItemList()
	self:_refreshTask()
end

function V3a1_GaoSiNiao_LevelView:_refreshEndlessBtn()
	local isOpen = self.viewContainer:isSpEpisodeOpen()

	self:setActive_btnEndlessGo(isOpen)
end

function V3a1_GaoSiNiao_LevelView:setActive_btnEndlessGo(isActive)
	gohelper.setActive(self._btnEndlessGo, isActive)
end

function V3a1_GaoSiNiao_LevelView:_refreshLeftTime()
	self._txtlimittime.text = ActivityHelper.getActivityRemainTimeStr(self:_actId())
end

function V3a1_GaoSiNiao_LevelView:onStageItemClick(stageItemObj)
	local episodeId = stageItemObj:episodeId()
	local isOpen = stageItemObj:isEpisodeOpen()

	if not isOpen then
		GameFacade.showToast(ToastEnum.Act163LevelLocked)

		return
	end

	self:_enterGame(episodeId)
end

function V3a1_GaoSiNiao_LevelView:_spCO()
	if not self._tmpSPCO then
		self:_getDataList()
	end

	return self._tmpSPCO
end

function V3a1_GaoSiNiao_LevelView:_getDataList()
	if not self._tmpDataList then
		local episodeCOList, _SPCOList = self.viewContainer:getEpisodeCOList()

		self._tmpDataList = episodeCOList

		if _SPCOList then
			self._tmpSPCO = _SPCOList[1] or nil
		end
	end

	return self._tmpDataList
end

function V3a1_GaoSiNiao_LevelView:_refreshItemList()
	local list = self:_getDataList()
	local maxN = #self._goStageItemContainerList
	local currentEpisodeIdToPlay = self.viewContainer:currentEpisodeIdToPlay()

	for i, data in ipairs(list) do
		local item

		if maxN < i then
			break
		end

		local parentGO = self._goStageItemContainerList[i]

		if i > #self._itemObjList then
			item = self:_create_V3a1_GaoSiNiao_LevelViewStageItem(parentGO, i)

			table.insert(self._itemObjList, item)
		else
			item = self._itemObjList[i]
		end

		item:onUpdateMO(data)

		local isShow = item:isEpisodeOpen()
		local isShowCurrent = currentEpisodeIdToPlay == item:episodeId()

		if isShow and isShowCurrent then
			isShow = item:hasPlayedUnlockedAnimPath()
		end

		item:setActive(isShow)
		item:setActive_goCurrent(isShowCurrent)
	end

	local n = math.min(maxN, #self._itemObjList)

	for i = #list + 1, n do
		local item = self._itemObjList[i]

		item:setActive(false)
	end
end

function V3a1_GaoSiNiao_LevelView:_create_V3a1_GaoSiNiao_LevelViewStageItem(parentGO, index)
	local viewSetting = self.viewContainer:getSetting()
	local resPath = viewSetting.otherRes.v3a1_gaosiniao_levelviewstageitem
	local go = self.viewContainer:getResInst(resPath, parentGO, V3a1_GaoSiNiao_LevelViewStageItem.__cname)
	local item = V3a1_GaoSiNiao_LevelViewStageItem.New({
		parent = self,
		baseViewContainer = self.viewContainer
	})

	item:setIndex(index)
	item:init(go)

	return item
end

local kPathAnimPrefix = "level"

local function _animName_Path(animIndex)
	return kPathAnimPrefix .. tostring(animIndex)
end

function V3a1_GaoSiNiao_LevelView:_playAnim_Path(name, cb, cbObj)
	self._animatorPlayerPath:Play(name, cb or function()
		return
	end, cbObj)
end

function V3a1_GaoSiNiao_LevelView:playAnim_PathUnlock(animIndex, cb, cbObj)
	AudioMgr.instance:trigger(AudioEnum3_1.GaoSiNiao.play_ui_mingdi_gsn_level)

	local animName = _animName_Path(animIndex)

	self:_playAnim_Path(animName, cb, cbObj)
end

function V3a1_GaoSiNiao_LevelView:playAnim_PathIdle(animIndex, cb, cbObj)
	if animIndex < 0 then
		if cb then
			cb(cbObj)
		end

		return
	end

	local animName = _animName_Path(animIndex) .. "_idle"

	self:_playAnim_Path(animName, cb, cbObj)
end

function V3a1_GaoSiNiao_LevelView:_playAnim_Endless(name, cb, cbObj)
	self._animatorPlayerEndless:Play(name, cb or function()
		return
	end, cbObj)
end

function V3a1_GaoSiNiao_LevelView:playAnim_EndlessIdle(cb, cbObj)
	self:setActive_btnEndlessGo(true)
	self:_playAnim_Endless(UIAnimationName.Idle, cb, cbObj)
end

function V3a1_GaoSiNiao_LevelView:playAnim_EndlessUnlock(cb, cbObj)
	AudioMgr.instance:trigger(AudioEnum3_1.GaoSiNiao.play_ui_mingdi_gsn_fenghe)
	self:setActive_btnEndlessGo(true)
	self:_playAnim_Endless(UIAnimationName.Unlock, cb, cbObj)
end

function V3a1_GaoSiNiao_LevelView:_onCloseView(viewName)
	if viewName == ViewName.V3a1_GaoSiNiao_TaskView then
		self:_onCloseTask()
	end
end

function V3a1_GaoSiNiao_LevelView:_refreshTask()
	local uid = 0

	if RedDotModel.instance:isDotShow(RedDotEnum.DotNode.V3a1GaoSiNiaoTask, uid) then
		self._animTask:Play(UIAnimationName.Loop)
	else
		self._animTask:Play(UIAnimationName.Idle, 0, 0)
	end
end

function V3a1_GaoSiNiao_LevelView:_onCloseTask()
	self:_refreshTask()
end

return V3a1_GaoSiNiao_LevelView
