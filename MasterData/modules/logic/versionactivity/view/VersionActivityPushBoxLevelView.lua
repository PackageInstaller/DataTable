-- chunkname: @modules/logic/versionactivity/view/VersionActivityPushBoxLevelView.lua

module("modules.logic.versionactivity.view.VersionActivityPushBoxLevelView", package.seeall)

local VersionActivityPushBoxLevelView = class("VersionActivityPushBoxLevelView", BaseView)

function VersionActivityPushBoxLevelView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._btntask = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_task")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._scrolllevels = gohelper.findChildScrollRect(self.viewGO, "#scroll_levels")
	self._golevel10 = gohelper.findChild(self.viewGO, "#scroll_levels/Viewport/Content/#go_level10")
	self._golevel9 = gohelper.findChild(self.viewGO, "#scroll_levels/Viewport/Content/#go_level9")
	self._golevel8 = gohelper.findChild(self.viewGO, "#scroll_levels/Viewport/Content/#go_level8")
	self._golevel7 = gohelper.findChild(self.viewGO, "#scroll_levels/Viewport/Content/#go_level7")
	self._golevel6 = gohelper.findChild(self.viewGO, "#scroll_levels/Viewport/Content/#go_level6")
	self._golevel5 = gohelper.findChild(self.viewGO, "#scroll_levels/Viewport/Content/#go_level5")
	self._golevel4 = gohelper.findChild(self.viewGO, "#scroll_levels/Viewport/Content/#go_level4")
	self._golevel3 = gohelper.findChild(self.viewGO, "#scroll_levels/Viewport/Content/#go_level3")
	self._golevel2 = gohelper.findChild(self.viewGO, "#scroll_levels/Viewport/Content/#go_level2")
	self._golevel1 = gohelper.findChild(self.viewGO, "#scroll_levels/Viewport/Content/#go_level1")
	self._gotaskred = gohelper.findChild(self.viewGO, "#btn_task/#go_task_red")
	self._txtremaintime = gohelper.findChildText(self.viewGO, "top/#txt_remaintime")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivityPushBoxLevelView:addEvents()
	self._btntask:AddClickListener(self._btntaskOnClick, self)
	self.addEventCb(self, PushBoxController.instance, PushBoxEvent.DataEvent.ReceiveTaskRewardReply, self._onReceiveTaskRewardReply, self)
end

function VersionActivityPushBoxLevelView:removeEvents()
	self._btntask:RemoveClickListener()
end

function VersionActivityPushBoxLevelView:_btntaskOnClick()
	ViewMgr.instance:openView(ViewName.VersionActivityPushBoxTaskView)
end

function VersionActivityPushBoxLevelView:_editableInitView()
	self._simagebg:LoadImage(ResUrl.getVersionActivityIcon("pushbox/full/bg"))

	self._ani = gohelper.onceAddComponent(self.viewGO, typeof(UnityEngine.Animator))
end

function VersionActivityPushBoxLevelView:onUpdateParam()
	return
end

function VersionActivityPushBoxLevelView:_playOpenAudio()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_role_culture_open)
end

function VersionActivityPushBoxLevelView:onOpen()
	if RedDotModel.instance:isDotShow(RedDotEnum.DotNode.VersionActivityPushBoxNewLevelOpen, 0) then
		GameFacade.showToast(ToastEnum.VersionActivityPushBoxNewLevelOpen)
	end

	TaskDispatcher.runDelay(self._playOpenAudio, self, 0.5)

	self._activity_data = ActivityModel.instance:getActivityInfo()[PushBoxModel.instance:getCurActivityID()]

	self.viewContainer._navigateButtonView:setOverrideClose(self._onNavigateCloseCallback, self)
	self.viewContainer._navigateButtonView:setOverrideHome(self._onNavigateHomeCallback, self)

	self._episode_list = PushBoxEpisodeConfig.instance:getEpisodeList()

	if self.viewParam then
		local jump_id = self.viewParam.id
		local next_lock_episode

		for i = 1, 10 do
			local go_finish = gohelper.findChildComponent(self["_golevel" .. i], "go_info/go_finish", typeof(UnityEngine.Animation))

			go_finish.enabled = false

			if not self._episode_list[i] then
				gohelper.setActive(self["_golevel" .. i], false)
			else
				if PushBoxModel.instance:getPassData(self._episode_list[i].id) then
					-- block empty
				else
					local go_info = gohelper.findChild(self["_golevel" .. i], "go_info")

					if not next_lock_episode then
						next_lock_episode = true

						gohelper.setActive(go_info, true)
					else
						gohelper.setActive(go_info, false)
						self["_golevel" .. i]:GetComponent(typeof(UnityEngine.Animator)):Play("in")
					end
				end

				if jump_id == self._episode_list[i].id then
					if i <= 5 then
						-- block empty
					else
						recthelper.setAnchorX(gohelper.findChild(self.viewGO, "#scroll_levels/Viewport/Content").transform, -950)
					end

					if self.viewParam.win then
						self._new_finish_episode = self._episode_list[i].id
					end
				end
			end
		end

		self:_refreshLevelData()
		self:_updateDeadline()
		TaskDispatcher.runRepeat(self._updateDeadline, self, 60)
	end
end

function VersionActivityPushBoxLevelView:_updateDeadline()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[PushBoxModel.instance:getCurActivityID()]

	self._txtremaintime.text = string.format(luaLang("remain"), actInfoMo:getRemainTimeStr2ByEndTime())
end

function VersionActivityPushBoxLevelView:_refreshLevelData()
	local lastLevelIsPass = false

	for i, config in ipairs(self._episode_list) do
		local id = config.id
		local pass_data = PushBoxModel.instance:getPassData(id)
		local obj = self["_golevel" .. i]
		local txt_title = gohelper.findChildTextMesh(obj, "go_info/txt_title")

		txt_title.text = config.name

		local go_lock = gohelper.findChild(obj, "go_info/go_lock")
		local go_finish = gohelper.findChild(obj, "go_info/go_finish")
		local simage_map = gohelper.findChildImage(obj, "simage_map")
		local txt_unlocktime = gohelper.findChildTextMesh(obj, "go_info/go_lock/go_speciallock/txt_unlocktime")
		local go_speciallock = gohelper.findChild(obj, "go_info/go_lock/go_speciallock")
		local go_normallock = gohelper.findChild(obj, "go_info/go_lock/go_normallock")
		local go_index = gohelper.findChild(obj, "go_info/txt_index")
		local maplock = gohelper.findChild(obj, "maplock")
		local map = gohelper.findChild(obj, "map")

		gohelper.setActive(maplock, not pass_data)
		gohelper.setActive(map, pass_data)

		local canvasgroup = maplock:GetComponent(typeof(UnityEngine.CanvasGroup))

		canvasgroup.alpha = lastLevelIsPass and 1 or 0.5

		if pass_data then
			UISpriteSetMgr.instance:setPushBoxSprite(simage_map, string.format("gk_%02d", i), true)
		else
			UISpriteSetMgr.instance:setPushBoxSprite(simage_map, string.format("gkj_%02d", i), true)

			local stage_is_opened = PushBoxModel.instance:getStageOpened(id)

			gohelper.setActive(go_speciallock, not stage_is_opened)
			gohelper.setActive(go_normallock, stage_is_opened)

			if not stage_is_opened then
				local start_time = PushBoxModel.instance:getEpisodeOpenTime(id)

				txt_unlocktime.text = os.date("%m.%d", start_time) .. luaLang("unlock")
			end
		end

		lastLevelIsPass = pass_data

		gohelper.setActive(go_finish, pass_data and pass_data.state == 1)
		gohelper.setActive(go_lock, not pass_data)
		gohelper.setActive(go_index, pass_data)

		local click = gohelper.findChildClickWithAudio(obj, "btn_click")

		click:AddClickListener(self._episodeClick, self, id)

		local go_selectedbg = gohelper.findChild(obj, "go_selectedbg")
		local go_selected = gohelper.findChild(obj, "go_selected")

		gohelper.setActive(go_selectedbg, false)
		gohelper.setActive(go_selected, false)

		if self._new_finish_episode == id then
			self._new_finish_obj = go_finish

			gohelper.setActive(go_finish, false)
			TaskDispatcher.runDelay(self._playNewFinish, self, 1.5)
		end
	end

	RedDotController.instance:addRedDot(self._gotaskred, RedDotEnum.DotNode.VersionActivityPushBoxTask)
end

function VersionActivityPushBoxLevelView:_refreshTaskRed()
	local task_list = PushBoxEpisodeConfig.instance:getTaskList()
	local show_red = false

	for i, v in ipairs(task_list) do
		local task_data = PushBoxModel.instance:getTaskData(v.taskId)

		if task_data and not task_data.hasGetBonus and task_data.progress >= v.maxProgress then
			show_red = true

			break
		end
	end

	gohelper.setActive(self._gotaskred, show_red)
end

function VersionActivityPushBoxLevelView:_onReceiveTaskRewardReply()
	return
end

function VersionActivityPushBoxLevelView:_playNewFinish()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_mark_finish)
	gohelper.setActive(self._new_finish_obj, true)

	local go_finish = gohelper.onceAddComponent(self._new_finish_obj, typeof(UnityEngine.Animation))

	go_finish.enabled = true

	go_finish:Rewind()
	go_finish:Play()
end

function VersionActivityPushBoxLevelView:_episodeClick(episode_id)
	if not PushBoxModel.instance:getPassData(episode_id) then
		local start_time = PushBoxModel.instance:getEpisodeOpenTime(episode_id)

		if start_time < ServerTime.now() then
			GameFacade.showToast(ToastEnum.ActivityPushBoxLevel)

			return
		else
			return
		end

		return
	end

	if self._activity_data:isExpired() then
		GameFacade.showToast(ToastEnum.BattlePass)

		return
	end

	local config = PushBoxEpisodeConfig.instance:getConfig(episode_id)

	self._game_mgr = GameSceneMgr.instance:getCurScene().gameMgr

	self._game_mgr:startGame(config.id)

	self._cur_select_config = config

	local index = tabletool.indexOf(self._episode_list, config)
	local obj = self["_golevel" .. index]
	local go_selectedbg = gohelper.findChild(obj, "go_info/go_selectedbg")
	local go_selected = gohelper.findChild(obj, "go_info/go_selected")

	gohelper.setActive(go_selectedbg, true)
	gohelper.setActive(go_selected, true)
	TaskDispatcher.runDelay(self._delaySelectEpisode, self, 0.3)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_level_chosen)
end

function VersionActivityPushBoxLevelView:_delaySelectEpisode()
	self._ani:Play("gameopen")
	TaskDispatcher.runDelay(self._delayEnterGame, self, 0.2)
end

function VersionActivityPushBoxLevelView:_delayEnterGame()
	recthelper.setAnchorX(self.viewGO.transform, 10000)
	self:onClose()
	GuideController.instance:dispatchEvent(GuideEvent["OnPushBoxEnter" .. self._cur_select_config.id])
	ViewMgr.instance:openView(ViewName.VersionActivityPushBoxGameView)
	self._game_mgr:playOpenAni()
end

function VersionActivityPushBoxLevelView:_onNavigateCloseCallback()
	if GameSceneMgr.instance:isPushBoxScene() then
		GameSceneMgr.instance:getCurScene().gameMgr:hideRoot()
	end

	self:onClose()
	MainController.instance:enterMainScene()
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivityEnterView)
		VersionActivityController.instance:directOpenVersionActivityEnterView()
	end)
end

function VersionActivityPushBoxLevelView:_onNavigateHomeCallback()
	if GameSceneMgr.instance:isPushBoxScene() then
		GameSceneMgr.instance:getCurScene().gameMgr:hideRoot()
	end

	NavigateButtonsView.homeClick()
end

function VersionActivityPushBoxLevelView:onClose()
	TaskDispatcher.cancelTask(self._playOpenAudio, self)
	TaskDispatcher.cancelTask(self._delaySelectEpisode, self)
	TaskDispatcher.cancelTask(self._delayEnterGame, self)
	TaskDispatcher.cancelTask(self._playNewFinish, self)
	TaskDispatcher.cancelTask(self._updateDeadline, self)

	if self._episode_list then
		for i, config in ipairs(self._episode_list) do
			local obj = self["_golevel" .. i]
			local click = gohelper.findChildClickWithAudio(obj, "btn_click")

			click:RemoveClickListener()
			obj:GetComponent(typeof(UnityEngine.Animator)):Play(UIAnimationName.Close)
		end
	end

	self.viewContainer._navigateButtonView:setOverrideClose(nil, nil)
	self.viewContainer._navigateButtonView:setOverrideHome(nil, nil)
	self:closeThis()
end

function VersionActivityPushBoxLevelView:onDestroyView()
	self._simagebg:UnLoadImage()
end

return VersionActivityPushBoxLevelView
