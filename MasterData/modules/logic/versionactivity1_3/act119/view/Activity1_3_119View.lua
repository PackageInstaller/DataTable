-- chunkname: @modules/logic/versionactivity1_3/act119/view/Activity1_3_119View.lua

module("modules.logic.versionactivity1_3.act119.view.Activity1_3_119View", package.seeall)

local Activity1_3_119View = class("Activity1_3_119View", BaseView)
local ViewShowMode = {
	Hard = 2,
	Normal = 1
}
local tabCount = 6
local rewordCount = 3

function Activity1_3_119View:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "Title/#simage_Title")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Title/#txt_LimitTime")
	self._simageBookLeft = gohelper.findChildSingleImage(self.viewGO, "Book/BookLower/#simage_BookLeft")
	self._simageBookRight = gohelper.findChildSingleImage(self.viewGO, "Book/BookLower/#simage_BookRight")
	self._simageFolderNormalBG = gohelper.findChildSingleImage(self.viewGO, "Book/Folder/#simage_FolderNormalBG")
	self._simageFolderHardBG = gohelper.findChildSingleImage(self.viewGO, "Book/Folder/#simage_FolderHardBG")
	self._goTabList = gohelper.findChild(self.viewGO, "Book/Folder/#go_TabList")
	self._goTabItem = gohelper.findChild(self.viewGO, "Book/Folder/#go_TabList/#go_TabItem")
	self._simagePhoto = gohelper.findChildSingleImage(self.viewGO, "Book/#simage_Photo")
	self._simagePageLeft = gohelper.findChildSingleImage(self.viewGO, "Book/BookPage/#simage_PageLeft")
	self._simagePageRight = gohelper.findChildSingleImage(self.viewGO, "Book/BookPage/#simage_PageRight")
	self._simagePhotoIcon = gohelper.findChildSingleImage(self.viewGO, "Book/BookInfo/PageLeft/LeftUp/#simage_Photo")
	self._simagePhotoNormalBG = gohelper.findChildSingleImage(self.viewGO, "Book/BookInfo/PageLeft/LeftUp/#simage_PhotoNormalBG")
	self._simagePhotoHardBG = gohelper.findChildSingleImage(self.viewGO, "Book/BookInfo/PageLeft/LeftUp/#simage_PhotoHardBG")
	self._txtPhotoBigNum = gohelper.findChildText(self.viewGO, "Book/BookInfo/PageLeft/LeftUp/#txt_PhotoBigNum")
	self._txtPhotoSmallNum = gohelper.findChildText(self.viewGO, "Book/BookInfo/PageLeft/LeftUp/#txt_PhotoBigNum/#txt_PhotoSmallNum")
	self._txtPhotoName = gohelper.findChildText(self.viewGO, "Book/BookInfo/PageLeft/LeftUp/#txt_PhotoBigNum/#txt_PhotoName")
	self._goNormalSelected = gohelper.findChild(self.viewGO, "Book/BookInfo/PageLeft/LeftMiddle/#go_NormalSelected")
	self._goHardSelected = gohelper.findChild(self.viewGO, "Book/BookInfo/PageLeft/LeftMiddle/#go_HardSelected")
	self._goHardLocked = gohelper.findChild(self.viewGO, "Book/BookInfo/PageLeft/LeftMiddle/#go_HardLocked")
	self._btnNormal = gohelper.findChildButtonWithAudio(self.viewGO, "Book/BookInfo/PageLeft/LeftMiddle/#btn_Normal")
	self._btnHard = gohelper.findChildButtonWithAudio(self.viewGO, "Book/BookInfo/PageLeft/LeftMiddle/#btn_Hard")
	self._txtRecommendLevelNum = gohelper.findChildText(self.viewGO, "Book/BookInfo/PageLeft/LeftDown/LevelInfo/txt_RecommendLevel/#txt_RecommendLevelNum")
	self._txtLevelDesc = gohelper.findChildText(self.viewGO, "Book/BookInfo/PageLeft/LeftDown/LevelInfo/#txt_LevelDesc")
	self._scrollSampleRole = gohelper.findChildScrollRect(self.viewGO, "Book/BookInfo/PageLeft/LeftDown/SampleRole/#scroll_SampleRole")
	self._goSampleRole = gohelper.findChild(self.viewGO, "Book/BookInfo/PageLeft/LeftDown/SampleRole/#scroll_SampleRole/Viewport/#go_SampleRole")
	self._goSampleRoleItem = gohelper.findChild(self.viewGO, "Book/BookInfo/PageLeft/LeftDown/SampleRole/#scroll_SampleRole/Viewport/#go_SampleRole/#go_SampleRoleItem")
	self._imageQualityBG = gohelper.findChildImage(self.viewGO, "Book/BookInfo/PageLeft/LeftDown/SampleRole/#scroll_SampleRole/Viewport/#go_SampleRole/#go_SampleRoleItem/#image_QualityBG")
	self._imageRoleIcon = gohelper.findChildImage(self.viewGO, "Book/BookInfo/PageLeft/LeftDown/SampleRole/#scroll_SampleRole/Viewport/#go_SampleRole/#go_SampleRoleItem/image_Mask/#image_RoleIcon")
	self._gosamplehero = gohelper.findChild(self.viewGO, "Book/BookInfo/PageLeft/LeftDown/SampleRole/#go_samplehero")
	self._txtNormalTaskDesc = gohelper.findChildText(self.viewGO, "Book/BookInfo/PageRight/NormalTask/Content/#txt_NormalTaskDesc")
	self._goNormalComplete = gohelper.findChild(self.viewGO, "Book/BookInfo/PageRight/NormalTask/#go_NormalComplete")
	self._txtHardTaskDesc1 = gohelper.findChildText(self.viewGO, "Book/BookInfo/PageRight/HardTask1/Content/#txt_NormalTaskDesc")
	self._gohardComplete1 = gohelper.findChild(self.viewGO, "Book/BookInfo/PageRight/HardTask1/#go_NormalComplete")
	self._txtHardTaskDesc2 = gohelper.findChildText(self.viewGO, "Book/BookInfo/PageRight/HardTask2/Content/#txt_NormalTaskDesc")
	self._gohardComplete2 = gohelper.findChild(self.viewGO, "Book/BookInfo/PageRight/HardTask2/#go_NormalComplete")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "bookleft/leftup/#simage_icon")
	self._goStartBtn = gohelper.findChild(self.viewGO, "Book/BookInfo/#go_StartBtn")
	self._btnStartNormal = gohelper.findChildButtonWithAudio(self.viewGO, "Book/BookInfo/#go_StartBtn/#btn_StartNormal")
	self._btnStartHard = gohelper.findChildButtonWithAudio(self.viewGO, "Book/BookInfo/#go_StartBtn/#btn_StartHard")
	self._goBackBtns = gohelper.findChild(self.viewGO, "#go_BackBtns")
	self._goTaskGroup1 = gohelper.findChild(self.viewGO, "Book/BookInfo/PageRight/NormalTask")
	self._goTaskGroup2 = gohelper.findChild(self.viewGO, "Book/BookInfo/PageRight/HardTask1")
	self._goTaskGroup3 = gohelper.findChild(self.viewGO, "Book/BookInfo/PageRight/HardTask2")
	self._goTaskRewardGroup = gohelper.findChild(self.viewGO, "Book/BookInfo/PageRight/Reward")
	self._gosampleHeroItem = gohelper.findChild(self.viewGO, "Book/BookInfo/PageLeft/LeftDown/SampleRole/#scroll_SampleRole/Viewport/#go_SampleRole/#go_SampleRoleItem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity1_3_119View:addEvents()
	self._btnNormal:AddClickListener(self._btnNormalOnClick, self)
	self._btnHard:AddClickListener(self._btnHardOnClick, self)
	self._btnStartNormal:AddClickListener(self._btnStartNormalOnClick, self)
	self._btnStartHard:AddClickListener(self._btnStartHardOnClick, self)
	self.addEventCb(self, Activity119Controller.instance, Activity119Event.TabChange, self.onTabChange, self)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self._updateLeftTime, self)
	TaskController.instance:registerCallback(TaskEvent.UpdateTaskList, self._onUpdateTaskList, self)
	TaskDispatcher.runRepeat(self._refreshTime, self, 60)
end

function Activity1_3_119View:removeEvents()
	self._btnNormal:RemoveClickListener()
	self._btnHard:RemoveClickListener()
	self._btnStartNormal:RemoveClickListener()
	self._btnStartHard:RemoveClickListener()
	self.removeEventCb(self, Activity119Controller.instance, Activity119Event.TabChange, self.onTabChange, self)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, self._updateLeftTime, self)
	TaskController.instance:unregisterCallback(TaskEvent.UpdateTaskList, self._onUpdateTaskList, self)
end

function Activity1_3_119View:_editableInitView()
	self._viewOpening = true
	self._animtor = gohelper.onceAddComponent(self.viewGO, typeof(UnityEngine.Animator))

	self._simageFullBG:LoadImage(ResUrl.getActivitiy119Icon("v1a3_bookview_fullbg"))
	self._simagePhoto:LoadImage(ResUrl.getActivitiy119Icon("v1a3_bookview_characterphoto"))
	self._simageBookLeft:LoadImage(ResUrl.getActivitiy119Icon("v1a3_bookview_leftlowerpagebg"))
	self._simageBookRight:LoadImage(ResUrl.getActivitiy119Icon("v1a3_bookview_rightlowerpagebg"))
	self._simageFolderNormalBG:LoadImage(ResUrl.getActivitiy119Icon("v1a3_bookview_normalleftsidepagebg"))
	self._simageFolderHardBG:LoadImage(ResUrl.getActivitiy119Icon("v1a3_bookview_hardleftsidepagebg"))
	self._simagePageLeft:LoadImage(ResUrl.getActivitiy119Icon("v1a3_bookview_leftupperpagebg"))
	self._simagePageRight:LoadImage(ResUrl.getActivitiy119Icon("v1a3_bookview_rightupperpagebg"))
	self._simagePhotoNormalBG:LoadImage(ResUrl.getActivitiy119Icon("v1a3_bookview_normallevelphotobg"))
	self._simagePhotoHardBG:LoadImage(ResUrl.getActivitiy119Icon("v1a3_bookview_hardlevelphotobg"))
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_swath_open)
	gohelper.addUIClickAudio(self._btnStartHard.gameObject, AudioEnum.HeroGroupUI.Play_UI_Formation_Action)
	gohelper.addUIClickAudio(self._btnStartNormal.gameObject, AudioEnum.HeroGroupUI.Play_UI_Formation_Action)
	self:initTabItems()
	self:initRewardItems()

	self.taskCanvasGroups = self:getUserDataTb_()
	self.taskCanvasGroups[1] = gohelper.onceAddComponent(gohelper.findChild(self.viewGO, "Book/BookInfo/PageRight/NormalTask/Content"), typeof(UnityEngine.CanvasGroup))
	self.taskCanvasGroups[2] = gohelper.onceAddComponent(gohelper.findChild(self.viewGO, "Book/BookInfo/PageRight/HardTask1/Content"), typeof(UnityEngine.CanvasGroup))
	self.taskCanvasGroups[3] = gohelper.onceAddComponent(gohelper.findChild(self.viewGO, "Book/BookInfo/PageRight/HardTask2/Content"), typeof(UnityEngine.CanvasGroup))
end

function Activity1_3_119View:onUpdateParam()
	return
end

function Activity1_3_119View:onOpen()
	self:_updateLeftTime()
	self:_updateTabState()

	local data = Activity119Model.instance:getData()

	self:onTabChange(data.lastSelectDay)

	self._viewOpening = false
end

function Activity1_3_119View:onClose()
	return
end

function Activity1_3_119View:onDestroyView()
	TaskDispatcher.cancelTask(self._refreshTime, self)
	TaskDispatcher.cancelTask(self._delayRefreshActionBtnView, self)
	TaskDispatcher.cancelTask(self._playUnLockAnim, self)

	for i = 1, #self.tabs do
		self.tabs[i]:dispose()
	end

	self.tabs = nil

	for i = 1, #self.heroItems do
		self.heroItems[i]:dispose()
	end

	self.heroItems = nil

	for i = 1, #self.rewards do
		self.rewards[i]:dispose()
	end

	self.rewards = nil

	self._simageFullBG:UnLoadImage()
	self._simagePhoto:UnLoadImage()
	self._simageBookLeft:UnLoadImage()
	self._simageBookRight:UnLoadImage()
	self._simageFolderNormalBG:UnLoadImage()
	self._simageFolderHardBG:UnLoadImage()
	self._simagePageLeft:UnLoadImage()
	self._simagePageRight:UnLoadImage()
	self._simagePhotoNormalBG:UnLoadImage()
	self._simagePhotoHardBG:UnLoadImage()
end

function Activity1_3_119View:initTabItems()
	gohelper.setActive(self._goTabItem, false)

	self.tabs = {}

	for i = 1, tabCount do
		local tab = Activity1_3_119TabItem.New()
		local go = gohelper.cloneInPlace(self._goTabItem, "tab_" .. i)

		gohelper.setActive(go, true)
		tab:init(go, i)

		self.tabs[i] = tab
	end
end

function Activity1_3_119View:initRewardItems()
	gohelper.setActive(self._goTaskRewardGroup, false)

	self.rewards = {}

	for i = 1, rewordCount do
		local reward = Activity1_3_119RewardItem.New()
		local root = self["_goTaskGroup" .. i]
		local go = gohelper.clone(self._goTaskRewardGroup, root, "RewardItem")

		transformhelper.setLocalPos(go.transform, 0, 0, 0)
		gohelper.setActive(go, true)
		reward:init(go)

		self.rewards[i] = reward
	end
end

function Activity1_3_119View:onTabChange(tabIndex)
	if self.curIndex == tabIndex then
		return
	end

	local data = Activity119Model.instance:getData()

	if data.lastSelectDay ~= tabIndex then
		data.lastSelectDay = tabIndex

		Activity119Model.instance:saveData()
	end

	if self.curIndex then
		self.tabs[self.curIndex]:changeSelect(false)
	end

	self._config = Activity119Config.instance:getConfig(VersionActivity1_3Enum.ActivityId.Act307, tabIndex)
	self.curIndex = tabIndex

	self.tabs[self.curIndex]:changeSelect(true)

	self._curMode = nil

	if data.lastSelectModel == ViewShowMode.Normal or not self:isHardUnLock() then
		self:_btnNormalOnClick()
	else
		self:_btnHardOnClick()
	end

	self:_refreshPageLeftDesc(self._config, self.curIndex)
	self:_refreshTaskInfo()
	self:_resetTrialHeroPos()
end

function Activity1_3_119View:_btnNormalOnClick()
	local preMode = self._curMode

	self._curMode = ViewShowMode.Normal

	local data = Activity119Model.instance:getData()

	if data.lastSelectModel ~= ViewShowMode.Normal then
		data.lastSelectModel = ViewShowMode.Normal

		Activity119Model.instance:saveData()
	end

	if not preMode or preMode ~= self._curMode then
		self._animtor.enabled = true

		self._animtor:Play("tonormal")
		self:_refreshModeInfo(self._curMode)
	end

	if preMode and preMode ~= self._curMode then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_click)
	end
end

function Activity1_3_119View:_btnHardOnClick()
	if not self:isHardUnLock() then
		GameFacade.showToast(ToastEnum.Act119HardLock)

		return
	end

	local data = Activity119Model.instance:getData()

	if data.lastSelectModel ~= ViewShowMode.Hard then
		data.lastSelectModel = ViewShowMode.Hard

		Activity119Model.instance:saveData()
	end

	local preMode = self._curMode

	self._curMode = ViewShowMode.Hard

	if not preMode or preMode ~= self._curMode then
		self._animtor.enabled = true

		self._animtor:Play("tohard")
		self:_refreshModeInfo(self._curMode)
	end

	if preMode and preMode ~= self._curMode then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_click)
	end
end

function Activity1_3_119View:_btnStartNormalOnClick()
	if not ActivityModel.instance:isActOnLine(VersionActivity1_3Enum.ActivityId.Act307) then
		GameFacade.showToast(ToastEnum.ActivityEnd)

		return
	end

	local episodeId = self._config.normalCO.id
	local config = DungeonConfig.instance:getEpisodeCO(episodeId)

	DungeonFightController.instance:enterFight(config.chapterId, episodeId)
end

function Activity1_3_119View:_btnStartHardOnClick()
	if not ActivityModel.instance:isActOnLine(VersionActivity1_3Enum.ActivityId.Act307) then
		GameFacade.showToast(ToastEnum.ActivityEnd)

		return
	end

	local episodeId = self._config.hardCO.id
	local config = DungeonConfig.instance:getEpisodeCO(episodeId)

	DungeonFightController.instance:enterFight(config.chapterId, episodeId)
end

function Activity1_3_119View:_refreshPageLeftDesc(pageCfg, tabIndex)
	self._simagePhotoIcon:LoadImage(ResUrl.getDreamTailImage(pageCfg.normalCO.icon))

	self._txtPhotoBigNum.text = string.format("%02d", tabIndex)
	self._txtPhotoSmallNum.text = string.format("TRAINING NO.%s", tabIndex)
	self._txtPhotoName.text = pageCfg.normalCO.name
end

function Activity1_3_119View:_refreshModeInfo(showMode)
	self:_resetTrialHeroPos()

	if showMode == ViewShowMode.Hard then
		if not self._config.hardCO then
			local episodeCO = self._config.normalCO
			local episodeCO2 = DungeonConfig.instance:getEpisodeCO(episodeCO.id)
			local battleCO = DungeonConfig.instance:getBattleCo(episodeCO2.id)
			local monsterGroupIds = battleCO and string.splitToNumber(battleCO.monsterGroupIds, "#")
			local monsterGroupId = monsterGroupIds and monsterGroupIds[1]
			local monsterGroupCO = monsterGroupId and lua_monster_group.configDict[monsterGroupId]
			local monster = monsterGroupCO and monsterGroupCO.monster
			local monsterId = monster and string.splitToNumber(monster, "#")[1]
			local monsterCO = monsterId and lua_monster.configDict[monsterId]

			self._txtRecommendLevelNum.text = monsterCO and HeroConfig.instance:getCommonLevelDisplay(monsterCO.level) or ""
			self._txtLevelDesc.text = episodeCO.des

			HeroGroupTrialModel.instance:setTrialByBattleId(episodeCO2.battleId)
			self:_updateTrialHeroItems()

			local data = Activity119Model.instance:getData()
			local playUnlockAnim = self:_checkAndPlayUnLockAnim(data, self.curIndex, self._viewOpening)

			if not playUnlockAnim then
				self:_refreshHardUnlockView()
			end

			TaskDispatcher.runDelay(self._delayRefreshActionBtnView, self, 0.2)
		end
	end
end

function Activity1_3_119View:_resetTrialHeroPos()
	local trans = self._gosamplehero.transform
	local pos = trans.localPosition

	transformhelper.setLocalPosXY(trans, 0, pos.y)
end

function Activity1_3_119View:_updateTrialHeroItems()
	gohelper.setActive(self._gosampleHeroItem, false)

	self.heroItems = self.heroItems or {}

	local list = HeroGroupTrialModel.instance:getList()

	for i = 1, #list do
		local heroItem = self.heroItems[i]

		if not heroItem then
			heroItem = Activity1_3_119TrialHeroItem.New()

			local go = gohelper.cloneInPlace(self._gosampleHeroItem, "Hero" .. i)

			heroItem:init(go, i)

			self.heroItems[i] = heroItem
		end

		gohelper.setActive(heroItem.go, true)
		heroItem:updateMO()
	end

	for i = #list + 1, #self.heroItems do
		gohelper.setActive(self.heroItems[i].go, false)
	end
end

function Activity1_3_119View:_refreshTaskInfo()
	local taskList = self._config.taskList

	self._txtNormalTaskDesc.text = taskList[1].desc
	self._txtHardTaskDesc1.text = taskList[2].desc
	self._txtHardTaskDesc2.text = taskList[3].desc

	local isUnLock = self:isHardUnLock()

	for i = 1, 3 do
		self.rewards[i]:setBonus(taskList[i].bonus, taskList[i].id, i == 1 or isUnLock)
	end

	self:_updateTaskStatus()
	self:calcTxtLen()
end

function Activity1_3_119View:_refreshHardUnlockView()
	gohelper.setActive(self._goHardLocked, not self:isHardUnLock())
end

function Activity1_3_119View:_delayRefreshActionBtnView()
	gohelper.setActive(self._btnStartNormal.gameObject, self._curMode ~= ViewShowMode.Hard)
	gohelper.setActive(self._btnStartHard.gameObject, self._curMode == ViewShowMode.Hard)
end

function Activity1_3_119View:_onUpdateTaskList(msg)
	for _, info in ipairs(msg.taskInfo) do
		if info.type == TaskEnum.TaskType.Activity119 then
			self:_updateTabState()
			self:_updateTaskStatus()
		end
	end
end

function Activity1_3_119View:_updateTaskStatus()
	local taskList = self._config.taskList

	for i = 1, 3 do
		local taskMO = TaskModel.instance:getTaskById(taskList[i].id)
		local status = Activity119Enum.TaskStatus.Unfinished

		if taskMO then
			if taskMO.finishCount > 0 then
				status = Activity119Enum.TaskStatus.GotReward
			elseif taskMO.hasFinished then
				status = Activity119Enum.TaskStatus.Finished
			end
		end

		self.rewards[i]:updateTaskStatus(status)

		self.taskCanvasGroups[i].alpha = status == Activity119Enum.TaskStatus.GotReward and 0.4 or 1

		if i == 1 then
			gohelper.setActive(self._goNormalComplete, status == Activity119Enum.TaskStatus.GotReward)
		elseif i == 2 then
			gohelper.setActive(self._gohardComplete1, status == Activity119Enum.TaskStatus.GotReward)
		elseif i == 3 then
			gohelper.setActive(self._gohardComplete2, status == Activity119Enum.TaskStatus.GotReward)
		end
	end
end

function Activity1_3_119View:calcTxtLen()
	if not self._txtnormalTaskDesc then
		return
	end

	self:updateLineLen(gohelper.findChildTextMesh(self.viewGO, "Book/BookInfo/PageRight/NormalTask/Content/txt_NormalTaskTitle"), self._txtnormalTaskDesc, self._goNormalComplete)
	self:updateLineLen(gohelper.findChildTextMesh(self.viewGO, "Book/BookInfo/PageRight/HardTask1/Content/txt_NormalTaskTitle"), self._txthardTaskDesc1, self._gohardComplete1)
	self:updateLineLen(gohelper.findChildTextMesh(self.viewGO, "Book/BookInfo/PageRight/HardTask2/Content/txt_NormalTaskTitle"), self._txthardTaskDesc2, self._gohardComplete2)
end

function Activity1_3_119View:updateLineLen(title, desc, lineGo)
	local line1 = gohelper.findChild(lineGo, "image_Complete1")
	local line2 = gohelper.findChild(lineGo, "image_Complete2")
	local line3 = gohelper.findChild(lineGo, "image_Complete3")
	local lineInfo = title:GetTextInfo(title.text).lineInfo

	recthelper.setWidth(line1.transform, lineInfo[0].length + 17)

	lineInfo = desc:GetTextInfo(desc.text).lineInfo

	recthelper.setWidth(line2.transform, lineInfo[0].length + 25)

	if lineInfo.Length <= 1 or lineInfo[1].length <= 1 then
		gohelper.setActive(line3, false)
	else
		gohelper.setActive(line3, true)
		recthelper.setWidth(line3.transform, lineInfo[1].length + 25)
	end
end

function Activity1_3_119View:_updateLeftTime()
	local actInfo = ActivityModel.instance:getActMO(VersionActivity1_3Enum.ActivityId.Act307)

	if not actInfo or not self.tabs then
		return
	end

	local nowDay = math.ceil((ServerTime.now() - actInfo:getRealStartTimeStamp()) / 86400)
	local data = Activity119Model.instance:getData()
	local co = Activity119Config.instance:getConfig(VersionActivity1_3Enum.ActivityId.Act307, data.lastSelectDay)

	if not co or nowDay < co.normalCO.openDay then
		data.lastSelectDay = 1

		Activity119Model.instance:saveData()
	end

	for i = 1, tabCount do
		self.tabs[i]:updateLock(nowDay)
	end

	self:_refreshTime()
end

function Activity1_3_119View:_refreshTime()
	local actInfoMo = ActivityModel.instance:getActMO(VersionActivity1_3Enum.ActivityId.Act307)

	self._txtLimitTime.text = (not actInfoMo or not actInfoMo.online) and luaLang("versionactivity_1_2_114enterview_isend") or string.format(luaLang("remain"), actInfoMo:getRemainTimeStr2ByEndTime())
end

function Activity1_3_119View:_updateTabState()
	for i = 1, tabCount do
		self.tabs[i]:updateFinishView()
	end
end

function Activity1_3_119View:_playUnLockAnim()
	TaskDispatcher.cancelTask(self._playUnLockAnim, self)

	self._animtor.enabled = true

	self._animtor:Play(UIAnimationName.Unlock)
end

function Activity1_3_119View:_checkAndPlayUnLockAnim(viewData, curTabIndex, delay)
	if self:isHardUnLock() and not tabletool.indexOf(viewData.unLockHardList, curTabIndex) then
		table.insert(viewData.unLockHardList, curTabIndex)
		Activity119Model.instance:saveData()

		if delay then
			TaskDispatcher.runDelay(self._playUnLockAnim, self, 1)
		else
			self:_playUnLockAnim()
		end

		return true
	end
end

function Activity1_3_119View:isHardUnLock()
	return DungeonModel.instance:hasPassLevel(self._config.normalCO.id)
end

return Activity1_3_119View
