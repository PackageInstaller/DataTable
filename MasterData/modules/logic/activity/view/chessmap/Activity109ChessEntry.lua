-- chunkname: @modules/logic/activity/view/chessmap/Activity109ChessEntry.lua

module("modules.logic.activity.view.chessmap.Activity109ChessEntry", package.seeall)

local Activity109ChessEntry = class("Activity109ChessEntry", BaseView)

function Activity109ChessEntry:onInitView()
	self._simagebg1 = gohelper.findChildSingleImage(self.viewGO, "#simage_bg1")
	self._simagebg2 = gohelper.findChildSingleImage(self.viewGO, "#simage_bg2")
	self._btntask = gohelper.findChildButton(self.viewGO, "#btn_task")
	self._goreddot = gohelper.findChild(self.viewGO, "#btn_task/#go_reddot")
	self._btnswitch = gohelper.findChildButtonWithAudio(self.viewGO, "switchmap/#btn_switch", AudioEnum.UI.play_ui_activity_dog_page)
	self._goepisodeitem = gohelper.findChild(self.viewGO, "info/#scroll_list/Viewport/maplist/#go_episodeitem")
	self._txtremaintime = gohelper.findChildTextMesh(self.viewGO, "remaintimebg/#txt_remaintime")
	self._golock = gohelper.findChild(self.viewGO, "switchmap/#go_lock")
	self._gounlock = gohelper.findChild(self.viewGO, "switchmap/#go_unlock")
	self._scrolllist = gohelper.findChildScrollRect(self.viewGO, "info/#scroll_list")
	self._gobottommask = gohelper.findChild(self.viewGO, "info/#go_bottommask")
	self._gotopmask = gohelper.findChild(self.viewGO, "info/#go_topmask")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity109ChessEntry:addEvents()
	self._btntask:AddClickListener(self._btntaskOnClick, self)
	self._btnswitch:AddClickListener(self._btnswitchOnClick, self)
	self.addEventCb(self, Activity109ChessController.instance, ActivityEvent.Refresh109ActivityData, self._onRefresh109ActivityData, self)
	self.addEventCb(self, Activity109ChessController.instance, ActivityEvent.Play109EntryViewOpenAni, self._onPlay109EntryViewOpenAni, self)
	self.addEventCb(self, Activity109ChessController.instance, ActivityChessEvent.TaskJump, self._handleTaskJump, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self._onRefreshActivityState, self)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self.dailyRefresh, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onFinishTask, self)
	self._scrolllist:AddOnValueChanged(self._onScrollValueChanged, self)
end

function Activity109ChessEntry:removeEvents()
	self._btntask:RemoveClickListener()
	self._btnswitch:RemoveClickListener()
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, self.dailyRefresh, self)
	self._scrolllist:RemoveOnValueChanged()
end

function Activity109ChessEntry:_editableInitView()
	self._ani = gohelper.onceAddComponent(self.viewGO, typeof(UnityEngine.Animator))
	self._scrolllist_rect = gohelper.findChildScrollRect(self.viewGO, "info/#scroll_list")
	self._scrolllist_ani = gohelper.findChildComponent(self.viewGO, "info/#scroll_list", typeof(UnityEngine.Animator))

	self._simagebg2:LoadImage(ResUrl.getVersionactivitychessIcon("full/img_shangceng"))

	self._image_bg1 = gohelper.findChildSingleImage(self.viewGO, "image_bg1")
	self._image_bg2 = gohelper.findChildSingleImage(self.viewGO, "image_bg2")

	self._image_bg1:LoadImage(ResUrl.getVersionactivitychessIcon("bg_01"))
	self._image_bg2:LoadImage(ResUrl.getVersionactivitychessIcon("bg_02"))

	self._episodeGoList = self:getUserDataTb_()
	self._goswitchicon1 = gohelper.findChild(self.viewGO, "switchmap/page1/switchicon1")
	self._goswitchicon = gohelper.findChild(self.viewGO, "switchmap/page1/switchicon")
end

function Activity109ChessEntry:_onRefreshActivityState(actId)
	if string.nilorempty(actId) or actId == 0 then
		return
	end

	if actId ~= Activity109Model.instance:getCurActivityID() then
		return
	end

	local status = ActivityHelper.getActivityStatus(actId)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		GameFacade.showMessageBox(MessageBoxIdDefine.EndActivity, MsgBoxEnum.BoxType.Yes, Activity109ChessEntry.yesCallback)
	end
end

function Activity109ChessEntry.yesCallback()
	ViewMgr.instance:closeView(ViewName.Activity109ChessEntry)
end

function Activity109ChessEntry:onDestroyView()
	self._simagebg1:UnLoadImage()
	self._simagebg2:UnLoadImage()
	self._image_bg1:UnLoadImage()
	self._image_bg2:UnLoadImage()

	for _, v in pairs(self._episodeGoList) do
		local episode_click = gohelper.findChildButton(v, "btn_click")

		episode_click:RemoveClickListener()

		local story_click = gohelper.findChildButton(v, "btn_story")

		story_click:RemoveClickListener()
	end
end

function Activity109ChessEntry:_btnswitchOnClick()
	local before_select = self._cur_select_stage

	self._cur_select_stage = self._cur_select_stage + 1
	self._cur_select_stage = self._cur_select_stage > 2 and 1 or self._cur_select_stage

	local is_open, time_offset = self:_stageIsOpen(self._cur_select_stage)

	if not is_open then
		self._cur_select_stage = before_select

		self:_showNoOpenToast(time_offset)

		return
	end

	self:_refreshEpisodeData()
	self:_playAni(self._cur_select_stage == 1 and "switch_youlun" or "switch_wudu")
	self._scrolllist_ani:Play(UIAnimationName.Click, 0, 0)

	self._scrolllist.verticalNormalizedPosition = 1
end

function Activity109ChessEntry:_showNoOpenToast(time_offset)
	time_offset = math.floor(time_offset)

	local day = math.floor(time_offset / 86400)
	local hour = math.floor(time_offset % 86400 / 3600)

	if day > 0 then
		GameFacade.showToast(ToastEnum.Chess2, day)
	elseif hour > 0 then
		GameFacade.showToast(ToastEnum.Chess3, hour)
	else
		GameFacade.showToast(ToastEnum.Chess4)
	end
end

function Activity109ChessEntry:_playAni(name)
	self._ani.enabled = true

	self._ani:Play(name, 0, 0)
end

function Activity109ChessEntry:_onPlay109EntryViewOpenAni()
	local name = self._cur_select_stage == 1 and "back2" or "back1"

	self:_playAni(name, 0, 0)
	self:_dimBgm(false)
end

function Activity109ChessEntry:_onRefresh109ActivityData()
	self:_refreshEpisodeData()
end

function Activity109ChessEntry:dailyRefresh()
	Activity109Rpc.instance:sendGetAct109InfoRequest(Activity109Model.instance:getCurActivityID())
end

function Activity109ChessEntry:_dimBgm(state)
	if state then
		AudioMgr.instance:trigger(AudioEnum.ChessGame.muisc_obscure_open)
	else
		AudioMgr.instance:trigger(AudioEnum.ChessGame.muisc_obscure_close)
	end
end

function Activity109ChessEntry:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_dog_open)

	self._cur_select_episode_id = self.viewParam

	local act_id = Activity109Model.instance:getCurActivityID()

	self._activity_data = ActivityModel.instance:getActivityInfo()[act_id]
	self._cur_select_stage = 1
	self._episode_list = {}

	for i, v in ipairs(Activity109Config.instance:getEpisodeList(act_id)) do
		self._episode_list[v.chapterId] = self._episode_list[v.chapterId] or {}

		table.insert(self._episode_list[v.chapterId], v)
	end

	if self._cur_select_episode_id then
		for i = 1, #self._episode_list do
			for index, config in ipairs(self._episode_list[i]) do
				if config.id == self._cur_select_episode_id then
					self._cur_select_stage = i

					break
				end
			end
		end
	elseif not Activity109Model.instance:isAllClear() and GuideModel.instance:isGuideFinish(ActivityChessEnum.GuideIDForSwitchButton) then
		self._cur_select_stage = self:_getMaxOpenChapter()
	end

	self:_refreshEpisodeData()
	self:_showLeftTime()
	TaskDispatcher.runRepeat(self._showLeftTime, self, 60)
	RedDotController.instance:addRedDot(self._goreddot, RedDotEnum.DotNode.VersionActivityPiKeLeSiTask)
end

function Activity109ChessEntry:_onFinishTask()
	return
end

function Activity109ChessEntry:_refreshTaskRed()
	gohelper.setActive(self._goreddot, Activity109ChessEntry.getTaskRedState())
end

function Activity109ChessEntry.getTaskRedState()
	local task_list = Activity109Config.instance:getTaskList()
	local show_red = false

	for i, v in ipairs(task_list) do
		local task_data = Activity109Model.instance:getTaskData(v.id)

		if task_data and task_data.finishCount == 0 and task_data.hasFinished then
			show_red = true

			break
		end
	end

	return show_red
end

function Activity109ChessEntry:_getMaxOpenChapter()
	local max_open_chapter = 1
	local chapter_id_list = Activity109Model.instance:getChapterList()

	for i, chapter_id in ipairs(chapter_id_list) do
		if not self:_stageIsOpen(chapter_id) then
			break
		end

		max_open_chapter = chapter_id

		if not Activity109Model.instance:isChapterClear(chapter_id) then
			break
		end
	end

	return max_open_chapter
end

function Activity109ChessEntry:_showLeftTime()
	self._txtremaintime.text = string.format(luaLang("activity_warmup_remain_time"), self._activity_data:getRemainTimeStr())
end

function Activity109ChessEntry:_refreshSwitchBtnData()
	local bg_str = self._cur_select_stage == 1 and "bg_01" or "bg_02"

	self._simagebg1:LoadImage(ResUrl.getVersionactivitychessIcon(bg_str))
	gohelper.setActive(gohelper.findChild(self.viewGO, "switchmap/page1"), self._cur_select_stage == 1)
	gohelper.setActive(gohelper.findChild(self.viewGO, "switchmap/page2"), self._cur_select_stage == 2)

	local is_open = self:_stageIsOpen(2)

	gohelper.setActive(self._golock, not is_open)
	gohelper.setActive(self._gounlock, is_open)
	gohelper.setActive(self._goswitchicon, is_open)
	gohelper.setActive(self._goswitchicon1, is_open)
end

function Activity109ChessEntry:_refreshEpisodeData()
	self:_refreshSwitchBtnData()

	local list = self:_getCurEpisodeList()

	for i = 1, #list do
		local config = list[i]
		local obj = self._episodeGoList[i]

		if not obj then
			obj = gohelper.cloneInPlace(self._goepisodeitem, "episodeitem" .. i)

			table.insert(self._episodeGoList, i, obj)
		end

		gohelper.setActive(obj, true)

		local bg = gohelper.findChildImage(obj, "bg")
		local txt_mapname = gohelper.findChildTextMesh(obj, "txt_mapname")
		local stars = gohelper.findChild(obj, "stars")
		local starsCanvasGroup = gohelper.onceAddComponent(stars, typeof(UnityEngine.CanvasGroup))
		local episode_data = Activity109Model.instance:getEpisodeData(config.id)
		local episode_click = gohelper.findChildButtonWithAudio(obj, "btn_click")
		local episode_finished = episode_data and episode_data.star > 0
		local nostory = config.storyBefore == 0
		local go_lock = gohelper.findChild(obj, "go_lock")
		local story_click = gohelper.findChildButtonWithAudio(obj, "btn_story")

		gohelper.setActive(go_lock, not episode_data)
		gohelper.setActive(story_click.gameObject, episode_finished and not nostory)
		story_click:AddClickListener(self._onStoryBtnClick, self, config.storyBefore)
		episode_click:AddClickListener(self._onEpisodeBtnClick, self, i)

		if config.storyBefore ~= 0 then
			UISpriteSetMgr.instance:setActivityChessMapSprite(bg, "img_yeqian1")
		else
			UISpriteSetMgr.instance:setActivityChessMapSprite(bg, episode_data and "img_yeqian2" or "img_yeqian2suo")
		end

		starsCanvasGroup.alpha = episode_finished and 1 or 0.4
		txt_mapname.text = string.format("<%s>%s</color>", nostory and "#633118" or "#2E2924", config.name)

		ZProj.UGUIHelper.SetColorAlpha(txt_mapname, episode_data and 1 or 0.55)

		for index = 1, 2 do
			gohelper.setActive(gohelper.findChild(obj, "stars/go_star" .. index .. "/full"), episode_data and index <= episode_data.star)
		end

		local index = gohelper.findChildImage(obj, "index")

		if episode_data then
			if not config.orderId then
				local indexImgName = config.orderId .. "_lock"

				UISpriteSetMgr.instance:setActivityChessMapSprite(index, indexImgName, true)

				local spdecorate = gohelper.findChildImage(obj, "spdecorate")

				gohelper.setActive(spdecorate, false)

				if nostory then
					gohelper.setActive(spdecorate, true)
					UISpriteSetMgr.instance:setActivityChessMapSprite(spdecorate, episode_data and "bg_bodian1" or "bg_bodian2", true)
				end
			end
		end
	end

	self:_initScrollMask()
end

function Activity109ChessEntry:_getCurEpisodeList()
	self._cur_list = self._episode_list[self._cur_select_stage]

	return self._cur_list
end

function Activity109ChessEntry:_stageIsOpen(stage)
	local episode_config = self._episode_list[stage][1]
	local open_time = self._activity_data:getRealStartTimeStamp() + (episode_config.openDay - 1) * 24 * 60 * 60
	local episode_data = Activity109Model.instance:getEpisodeData(episode_config.id)

	if not episode_data and open_time > ServerTime.now() then
		return false, open_time - ServerTime.now()
	end

	return true
end

function Activity109ChessEntry:_focusOnEpisode(stage, episode_id)
	local target_index = 1
	local episode_config_list = self._episode_list[stage]

	if not episode_config_list then
		return
	end

	local list_count = #episode_config_list

	if list_count == 0 then
		return
	end

	for i = 1, list_count do
		if episode_config_list[i].id == episode_id then
			target_index = i

			break
		end
	end

	self._scrolllist_rect.verticalNormalizedPosition = 1 - (target_index - 1) / (list_count - 1)
end

Activity109ChessEntry.UI_CLICK_BLOCK_KEY = "Activity109ChessEntryClick"

function Activity109ChessEntry:_onEpisodeBtnClick(index)
	if Activity109ChessController.instance:checkCanStartEpisode(self._cur_list[index].id) then
		self:_playAni(UIAnimationName.Click)

		self._delayEpisodeId = self._cur_list[index].id

		UIBlockMgr.instance:startBlock(Activity109ChessEntry.UI_CLICK_BLOCK_KEY)
		TaskDispatcher.runDelay(self._delayAfterEnterAnim, self, 0.2)
	end
end

function Activity109ChessEntry:_onStoryBtnClick(story)
	if story then
		StoryController.instance:playStories({
			story
		}, nil, nil)
	end
end

function Activity109ChessEntry:_handleTaskJump(task_cfg)
	if task_cfg.listenerType ~= ActivityChessEnum.TaskTypeClearEpisode then
		return
	end

	local episode_id = tonumber(task_cfg.listenerParam)
	local episode_cfg = Activity109Config.instance:getEpisodeCo(Activity109Model.instance:getCurActivityID(), episode_id)

	if not episode_cfg then
		return
	end

	local stage_index = episode_cfg.chapterId
	local is_open, time_offset = self:_stageIsOpen(stage_index)

	if not is_open then
		self:_showNoOpenToast(time_offset)

		return
	end

	if self._cur_select_stage ~= stage_index then
		self:_btnswitchOnClick()
	end

	self:_focusOnEpisode(stage_index, episode_id)
end

function Activity109ChessEntry:_delayAfterEnterAnim()
	TaskDispatcher.cancelTask(self._delayAfterEnterAnim, self)
	UIBlockMgr.instance:endBlock(Activity109ChessEntry.UI_CLICK_BLOCK_KEY)

	if self._delayEpisodeId then
		Activity109ChessController.instance:startNewEpisode(self._delayEpisodeId)

		self._delayEpisodeId = nil
	end

	self:_dimBgm(true)
end

function Activity109ChessEntry:onClose()
	UIBlockMgr.instance:endBlock(Activity109ChessEntry.UI_CLICK_BLOCK_KEY)
	TaskDispatcher.cancelTask(self._showLeftTime, self)
	TaskDispatcher.cancelTask(self._delayAfterEnterAnim, self)
	self:_dimBgm(false)
end

function Activity109ChessEntry:_btntaskOnClick()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity109
	}, self._taskCallback, self)
end

function Activity109ChessEntry:_taskCallback()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mission_open)
	ViewMgr.instance:openView(ViewName.Activity109ChessTask)
end

function Activity109ChessEntry:_onScrollValueChanged(value)
	local scrollValue = gohelper.getRemindFourNumberFloat(self._scrolllist.verticalNormalizedPosition)

	gohelper.setActive(self._gobottommask, self.couldScroll and scrollValue > 0)
	gohelper.setActive(self._gotopmask, self.couldScroll and scrollValue < 1)
end

function Activity109ChessEntry:_initScrollMask()
	local _gomailcontent = gohelper.findChild(self._scrolllist.gameObject, "Viewport/maplist")

	ZProj.UGUIHelper.RebuildLayout(_gomailcontent.transform)

	local _curmailcontentHeight = recthelper.getHeight(_gomailcontent.transform)
	local _scrollHeight = recthelper.getHeight(self._scrolllist.transform)

	self.couldScroll = _scrollHeight < _curmailcontentHeight

	local scrollValue = gohelper.getRemindFourNumberFloat(self._scrolllist.verticalNormalizedPosition)

	gohelper.setActive(self._gobottommask, self.couldScroll and scrollValue > 0)
	gohelper.setActive(self._gotopmask, self.couldScroll and scrollValue < 1)
end

return Activity109ChessEntry
