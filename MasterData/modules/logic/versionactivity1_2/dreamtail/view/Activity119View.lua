-- chunkname: @modules/logic/versionactivity1_2/dreamtail/view/Activity119View.lua

module("modules.logic.versionactivity1_2.dreamtail.view.Activity119View", package.seeall)

local Activity119View = class("Activity119View", BaseView)
local ViewShowMode = {
	Hard = 2,
	LockHard = 3,
	Normal = 1
}

function Activity119View:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_bg")
	self._txtremainTime = gohelper.findChildText(self.viewGO, "bg/#txt_remainTime")
	self._simagebookleftbg = gohelper.findChildSingleImage(self.viewGO, "bookleft/bg/#simage_bookleftbg")
	self._simagepageNormal = gohelper.findChildSingleImage(self.viewGO, "bookleft/bg/exchange/#simage_pageNormal")
	self._simagepageHard = gohelper.findChildSingleImage(self.viewGO, "bookleft/bg/exchange/#simage_pageHard")
	self._gocategory = gohelper.findChild(self.viewGO, "bookleft/category/#go_category")
	self._gocategoryItem = gohelper.findChild(self.viewGO, "bookleft/category/#go_category/#go_categoryItem")
	self._simageleftpage = gohelper.findChildSingleImage(self.viewGO, "bookleft/#simage_leftpage")
	self._simageleftpageline = gohelper.findChildSingleImage(self.viewGO, "bookleft/#simage_leftpageline")
	self._goframehard = gohelper.findChild(self.viewGO, "bookleft/leftup/exchange/#go_framehard")
	self._goframenormal = gohelper.findChild(self.viewGO, "bookleft/leftup/exchange/#go_framenormal")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "bookleft/leftup/#simage_icon")
	self._txtpageIndex = gohelper.findChildText(self.viewGO, "bookleft/leftup/#txt_pageIndex")
	self._txtpagename = gohelper.findChildText(self.viewGO, "bookleft/leftup/#txt_pagename")
	self._goselectHard = gohelper.findChild(self.viewGO, "bookleft/leftmiddle/#go_selectHard")
	self._goselctNormal = gohelper.findChild(self.viewGO, "bookleft/leftmiddle/#go_selctNormal")
	self._golockHard = gohelper.findChild(self.viewGO, "bookleft/leftmiddle/#go_lockHard")
	self._leftmiddleAnim = ZProj.ProjAnimatorPlayer.Get(gohelper.findChild(self.viewGO, "bookleft/leftmiddle"))
	self._btnnormal = gohelper.findChildButtonWithAudio(self.viewGO, "bookleft/leftmiddle/#btn_normal")
	self._btnhard = gohelper.findChildButtonWithAudio(self.viewGO, "bookleft/leftmiddle/#btn_hard")
	self._txtrecommendLevel = gohelper.findChildText(self.viewGO, "bookleft/leftdown/desc/txt/#txt_recommendLevel")
	self._txtdesc = gohelper.findChildText(self.viewGO, "bookleft/leftdown/desc/#txt_desc")
	self._gosamplehero = gohelper.findChild(self.viewGO, "bookleft/leftdown/samplehero/#scroll_samplehero/Viewport/#go_samplehero")
	self._gosampleHeroItem = gohelper.findChild(self.viewGO, "bookleft/leftdown/samplehero/#scroll_samplehero/Viewport/#go_samplehero/#go_sampleHeroItem")
	self._gonormal = gohelper.findChild(self.viewGO, "bookright/bg/nomal")
	self._gohard = gohelper.findChild(self.viewGO, "bookright/bg/hard")
	self._simagebookrightbghard = gohelper.findChildSingleImage(self.viewGO, "bookright/bg/hard/#simage_bookrightbghard")
	self._simagebookrightpagehard = gohelper.findChildSingleImage(self.viewGO, "bookright/bg/hard/#simage_bookrightpagehard")
	self._simagebookrightbgnormal = gohelper.findChildSingleImage(self.viewGO, "bookright/bg/nomal/#simage_bookrightbgnormal")
	self._simagebookrightpagenormal = gohelper.findChildSingleImage(self.viewGO, "bookright/bg/nomal/#simage_bookrightpagenormal")
	self._simagerightpageline = gohelper.findChildSingleImage(self.viewGO, "bookright/bg/#simage_rightpageline")
	self._txtnormalTaskDesc = gohelper.findChildText(self.viewGO, "bookright/normalpoint/content/#txt_normalTaskDesc")
	self._gonormalComplete = gohelper.findChild(self.viewGO, "bookright/normalpoint/#go_normalComplete")
	self._gohardpoint = gohelper.findChild(self.viewGO, "bookright/#go_hardpoint")
	self._txthardTaskDesc1 = gohelper.findChildText(self.viewGO, "bookright/#go_hardpoint/hardpoint1/content/#txt_hardTaskDesc1")
	self._gohardComplete1 = gohelper.findChild(self.viewGO, "bookright/#go_hardpoint/hardpoint1/#go_hardComplete1")
	self._txthardTaskDesc2 = gohelper.findChildText(self.viewGO, "bookright/#go_hardpoint/hardpoint2/content/#txt_hardTaskDesc2")
	self._gohardComplete2 = gohelper.findChild(self.viewGO, "bookright/#go_hardpoint/hardpoint2/#go_hardComplete2")
	self._golockhard = gohelper.findChild(self.viewGO, "bookright/#go_lockhard")
	self._goreward = gohelper.findChild(self.viewGO, "bookright/#go_reward")
	self._btnstarthard = gohelper.findChildButtonWithAudio(self.viewGO, "btn/#btn_starthard")
	self._btnstartnormal = gohelper.findChildButtonWithAudio(self.viewGO, "btn/#btn_startnormal")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity119View:addEvents()
	self._btnnormal:AddClickListener(self._btnnormalOnClick, self)
	self._btnhard:AddClickListener(self._btnhardOnClick, self)
	self._btnstarthard:AddClickListener(self._btnstarthardOnClick, self)
	self._btnstartnormal:AddClickListener(self._btnstartnormalOnClick, self)
	self._eventWrap:AddEventListener("onSwitch", self.onAnimSwitch, self)
	self.addEventCb(self, Activity119Controller.instance, Activity119Event.TabChange, self.onTabChange, self)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self.onUpdateLeftTime, self)
	TaskController.instance:registerCallback(TaskEvent.UpdateTaskList, self._onUpdateTaskList, self)
end

function Activity119View:removeEvents()
	self._btnnormal:RemoveClickListener()
	self._btnhard:RemoveClickListener()
	self._btnstarthard:RemoveClickListener()
	self._btnstartnormal:RemoveClickListener()
	self._eventWrap:RemoveAllEventListener()
	self.removeEventCb(self, Activity119Controller.instance, Activity119Event.TabChange, self.onTabChange, self)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, self.onUpdateLeftTime, self)
	TaskController.instance:unregisterCallback(TaskEvent.UpdateTaskList, self._onUpdateTaskList, self)
end

function Activity119View:_btnnormalOnClick()
	local preMode = self._toMode

	self._toMode = self:isHardUnLock() and ViewShowMode.Normal or ViewShowMode.LockHard

	local data = Activity119Model.instance:getData()

	if data.lastSelectModel ~= 1 then
		data.lastSelectModel = 1

		Activity119Model.instance:saveData()
	end

	if not preMode or preMode == self._toMode or self._toMode == ViewShowMode.LockHard or self._toMode ~= ViewShowMode.Hard and preMode ~= ViewShowMode.Hard then
		self._animtor.enabled = true

		self._animtor:Play("tonomal", 0, 1)
		self:updateShow(self._toMode)

		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_click)
	UIBlockMgr.instance:startBlock("Activity119ViewSwitch")

	self._animtor.enabled = true

	self._animtor:Play("tonomal", 0, 0)
end

function Activity119View:_btnhardOnClick()
	if not self:isHardUnLock() then
		GameFacade.showToast(ToastEnum.Act119HardLock)

		return
	end

	local data = Activity119Model.instance:getData()

	if data.lastSelectModel ~= 2 then
		data.lastSelectModel = 2

		Activity119Model.instance:saveData()
	end

	local preMode = self._toMode

	self._toMode = ViewShowMode.Hard

	if not preMode or preMode == self._toMode then
		self:updateShow(self._toMode)

		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_click)
	UIBlockMgr.instance:startBlock("Activity119ViewSwitch")

	self._animtor.enabled = true

	self._animtor:Play("tohard", 0, 0)
end

function Activity119View:onAnimSwitch()
	UIBlockMgr.instance:endBlock("Activity119ViewSwitch")
	self:updateShow(self._toMode)
end

function Activity119View:updateShow(showMode)
	self:resetTrialHeroPos()

	self._isHardMode = showMode == ViewShowMode.Hard

	gohelper.setActive(self._golockHard, showMode == ViewShowMode.LockHard)
	gohelper.setActive(self._golockhard, false)
	gohelper.setActive(self._gohardpoint, true)
	gohelper.setActive(self._btnstartnormal.gameObject, showMode ~= ViewShowMode.Hard)
	gohelper.setActive(self._btnstarthard.gameObject, showMode == ViewShowMode.Hard)

	local episodeCO = self._config.normalCO

	if showMode == ViewShowMode.Hard then
		episodeCO = self._config.hardCO
	end

	local episodeCO2 = DungeonConfig.instance:getEpisodeCO(episodeCO.id)
	local battleCO = lua_battle.configDict[episodeCO2.battleId]
	local monsterGroupIds = battleCO and string.splitToNumber(battleCO.monsterGroupIds, "#")
	local monsterGroupId = monsterGroupIds and monsterGroupIds[1]
	local monsterGroupCO = monsterGroupId and lua_monster_group.configDict[monsterGroupId]
	local monster = monsterGroupCO and monsterGroupCO.monster
	local monsterId = monster and string.splitToNumber(monster, "#")[1]
	local monsterCO = monsterId and lua_monster.configDict[monsterId]

	self._txtrecommendLevel.text = monsterCO and HeroConfig.instance:getCommonLevelDisplay(monsterCO.level) or ""
	self._txtdesc.text = episodeCO.des

	HeroGroupTrialModel.instance:setTrialByBattleId(episodeCO2.battleId)
	self:updateTrialHero()
end

function Activity119View:updateTrialHero()
	gohelper.setActive(self._gosampleHeroItem, false)

	self.heroItems = self.heroItems or {}

	local list = HeroGroupTrialModel.instance:getList()

	for i = 1, #list do
		local heroItem = self.heroItems[i]

		if not heroItem then
			heroItem = Activity119TrialHeroItem.New()

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

function Activity119View:updateTaskInfo()
	local taskList = self._config.taskList

	self._txtnormalTaskDesc.text = taskList[1].desc
	self._txthardTaskDesc1.text = taskList[2].desc
	self._txthardTaskDesc2.text = taskList[3].desc

	local isUnLock = self:isHardUnLock()

	for i = 1, 3 do
		self.rewards[i]:setBonus(taskList[i].bonus, taskList[i].id, i == 1 or isUnLock)
	end

	self:updateTaskStatus()
	UnityEngine.Canvas.ForceUpdateCanvases()
	self:calcTxtLen()
end

function Activity119View:calcTxtLen()
	if not self._txtnormalTaskDesc then
		return
	end

	self:updateLineLen(gohelper.findChildTextMesh(self.viewGO, "bookright/normalpoint/content/titletxt"), self._txtnormalTaskDesc, self._gonormalComplete)
	self:updateLineLen(gohelper.findChildTextMesh(self.viewGO, "bookright/#go_hardpoint/hardpoint1/content/titletxt"), self._txthardTaskDesc1, self._gohardComplete1)
	self:updateLineLen(gohelper.findChildTextMesh(self.viewGO, "bookright/#go_hardpoint/hardpoint2/content/titletxt"), self._txthardTaskDesc2, self._gohardComplete2)
end

function Activity119View:updateLineLen(title, desc, lineGo)
	local line1 = gohelper.findChild(lineGo, "img_complete1")
	local line2 = gohelper.findChild(lineGo, "img_complete2")
	local line3 = gohelper.findChild(lineGo, "img_complete3")
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

function Activity119View:_onUpdateTaskList(msg)
	for _, info in ipairs(msg.taskInfo) do
		if info.type == TaskEnum.TaskType.Activity119 then
			return self:updateTaskStatus()
		end
	end
end

function Activity119View:updateTaskStatus()
	local taskList = self._config.taskList

	for i = 1, 3 do
		local taskMO = TaskModel.instance:getTaskById(taskList[i].id)
		local status = 1

		if taskMO then
			if taskMO.finishCount > 0 then
				status = 3
			elseif taskMO.hasFinished then
				status = 2
			end
		end

		self.rewards[i]:updateTaskStatus(status)

		self.taskCanvasGroups[i].alpha = status == 3 and 0.4 or 1

		if i == 1 then
			gohelper.setActive(self._gonormalComplete, status == 3)
		elseif i == 2 then
			gohelper.setActive(self._gohardComplete1, status == 3)
		elseif i == 3 then
			gohelper.setActive(self._gohardComplete2, status == 3)
		end
	end
end

function Activity119View:_btnstarthardOnClick()
	if not ActivityModel.instance:isActOnLine(VersionActivity1_2Enum.ActivityId.DreamTail) then
		GameFacade.showToast(ToastEnum.ActivityEnd)

		return
	end

	local episodeId = self._config.hardCO.id
	local config = DungeonConfig.instance:getEpisodeCO(episodeId)

	DungeonFightController.instance:enterFight(config.chapterId, episodeId)
end

function Activity119View:_btnstartnormalOnClick()
	if not ActivityModel.instance:isActOnLine(VersionActivity1_2Enum.ActivityId.DreamTail) then
		GameFacade.showToast(ToastEnum.ActivityEnd)

		return
	end

	local episodeId = self._config.normalCO.id
	local config = DungeonConfig.instance:getEpisodeCO(episodeId)

	DungeonFightController.instance:enterFight(config.chapterId, episodeId)
end

function Activity119View:_editableInitView()
	self._eventWrap = gohelper.onceAddComponent(self.viewGO, typeof(ZProj.AnimationEventWrap))
	self._animtor = gohelper.onceAddComponent(self.viewGO, typeof(UnityEngine.Animator))

	self._simagebg:LoadImage(ResUrl.getDreamTailImage("bg"))
	self._simagebookleftbg:LoadImage(ResUrl.getDreamTailImage("bg_book_nor_left"))
	self._simagepageNormal:LoadImage(ResUrl.getDreamTailImage("bg_book_nor_lefttag"))
	self._simagepageHard:LoadImage(ResUrl.getDreamTailImage("bg_book_dif_lefttag"))
	self._simageleftpage:LoadImage(ResUrl.getDreamTailImage("bg_book_nor_lefttop"))
	self._simageleftpageline:LoadImage(ResUrl.getDreamTailImage("deco_left"))
	self._simagebookrightbgnormal:LoadImage(ResUrl.getDreamTailImage("bg_book_nor_right"))
	self._simagebookrightpagenormal:LoadImage(ResUrl.getDreamTailImage("bg_book_nor_righttop"))
	self._simagebookrightbghard:LoadImage(ResUrl.getDreamTailImage("bg_book_dificult_right"))
	self._simagebookrightpagehard:LoadImage(ResUrl.getDreamTailImage("bg_book_dif_righttop"))
	self._simagerightpageline:LoadImage(ResUrl.getDreamTailImage("deco_right"))
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_swath_open)
	gohelper.addUIClickAudio(self._btnstarthard.gameObject, AudioEnum.HeroGroupUI.Play_UI_Formation_Action)
	gohelper.addUIClickAudio(self._btnstartnormal.gameObject, AudioEnum.HeroGroupUI.Play_UI_Formation_Action)

	self._openDt = os.clock()

	gohelper.setActive(self._gocategoryItem, false)

	self.tabs = {}

	for i = 1, 7 do
		local tab = Activity119TabItem.New()
		local go = gohelper.cloneInPlace(self._gocategoryItem, "Tab" .. i)

		gohelper.setActive(go, true)
		tab:init(go, i)

		self.tabs[i] = tab
	end

	gohelper.setActive(self._goreward, false)

	self.rewards = {}

	for i = 1, 3 do
		local reward = Activity119RewardItem.New()
		local root = gohelper.findChild(self.viewGO, "bookright/reward" .. i)
		local go = gohelper.clone(self._goreward, root, "RewardItem")

		gohelper.setActive(go, true)
		reward:init(go)

		self.rewards[i] = reward
	end

	self.taskCanvasGroups = self:getUserDataTb_()
	self.taskCanvasGroups[1] = gohelper.onceAddComponent(gohelper.findChild(self.viewGO, "bookright/normalpoint/content"), typeof(UnityEngine.CanvasGroup))
	self.taskCanvasGroups[2] = gohelper.onceAddComponent(gohelper.findChild(self.viewGO, "bookright/#go_hardpoint/hardpoint1/content"), typeof(UnityEngine.CanvasGroup))
	self.taskCanvasGroups[3] = gohelper.onceAddComponent(gohelper.findChild(self.viewGO, "bookright/#go_hardpoint/hardpoint2/content"), typeof(UnityEngine.CanvasGroup))

	self:onUpdateLeftTime()

	local data = Activity119Model.instance:getData()

	self:onTabChange(data.lastSelectDay)
	TaskDispatcher.runRepeat(self.refreshTime, self, 60, -1)
end

function Activity119View:onOpenFinish()
	for i = 1, 7 do
		self.tabs[i]:playUnLockAnim()
	end
end

function Activity119View:onUpdateLeftTime()
	local actInfo = ActivityModel.instance:getActMO(VersionActivity1_2Enum.ActivityId.DreamTail)

	if not actInfo or not self.tabs then
		return
	end

	local nowDay = math.ceil((ServerTime.now() - actInfo:getRealStartTimeStamp()) / 86400)
	local data = Activity119Model.instance:getData()
	local co = Activity119Config.instance:getConfig(VersionActivity1_2Enum.ActivityId.DreamTail, data.lastSelectDay)

	if not co or nowDay < co.normalCO.openDay then
		data.lastSelectDay = 1

		Activity119Model.instance:saveData()
	end

	for i = 1, 7 do
		self.tabs[i]:updateLock(nowDay)
	end

	if os.clock() - self._openDt > 1 then
		for i = 1, 7 do
			self.tabs[i]:playUnLockAnim()
		end
	end

	self:refreshTime()
end

function Activity119View:refreshTime()
	local actInfoMo = ActivityModel.instance:getActMO(VersionActivity1_2Enum.ActivityId.DreamTail)

	self._txtremainTime.text = (not actInfoMo or not actInfoMo.online) and luaLang("versionactivity_1_2_114enterview_isend") or string.format(luaLang("remain"), actInfoMo:getRemainTimeStr2ByEndTime())
end

function Activity119View:isHardUnLock()
	return DungeonModel.instance:hasPassLevel(self._config.normalCO.id)
end

function Activity119View:onTabChange(tabIndex)
	if self.curIndex == tabIndex then
		return
	end

	self._leftmiddleAnim:Stop()

	local data = Activity119Model.instance:getData()

	if data.lastSelectDay ~= tabIndex then
		data.lastSelectDay = tabIndex

		Activity119Model.instance:saveData()
	end

	if self.curIndex then
		self.tabs[self.curIndex]:changeSelect(false)
	end

	self._config = Activity119Config.instance:getConfig(VersionActivity1_2Enum.ActivityId.DreamTail, tabIndex)
	self.curIndex = tabIndex

	self.tabs[self.curIndex]:changeSelect(true)

	if data.lastSelectModel == 1 or not self:isHardUnLock() then
		self:_btnnormalOnClick()
	else
		self:_btnhardOnClick()
	end

	self._simageicon:LoadImage(ResUrl.getDreamTailImage(self._config.normalCO.icon))

	self._txtpageIndex.text = string.format("%02d", self.curIndex)
	self._txtpagename.text = self._config.normalCO.name

	self:updateTaskInfo()
	TaskDispatcher.cancelTask(self.playUnLockAnim, self)

	if self:isHardUnLock() and not tabletool.indexOf(data.unLockHardList, tabIndex) then
		table.insert(data.unLockHardList, tabIndex)
		Activity119Model.instance:saveData()

		if os.clock() - self._openDt > 1 then
			self._leftmiddleAnim:Play(UIAnimationName.Unlock, self.onUnLockEnd, self)
		else
			self._leftmiddleAnim:Play(UIAnimationName.Idle)
			TaskDispatcher.runDelay(self.playUnLockAnim, self, 1)
		end
	else
		self._leftmiddleAnim:Play(UIAnimationName.Idle)
	end

	self:resetTrialHeroPos()
end

function Activity119View:resetTrialHeroPos()
	local trans = self._gosamplehero.transform
	local pos = trans.localPosition

	transformhelper.setLocalPosXY(trans, 0, pos.y)
end

function Activity119View:playUnLockAnim()
	TaskDispatcher.cancelTask(self.playUnLockAnim, self)
	self._leftmiddleAnim:Play(UIAnimationName.Unlock, self.onUnLockEnd, self)
end

function Activity119View:onUnLockEnd()
	return
end

function Activity119View:onDestroyView()
	TaskDispatcher.cancelTask(self.refreshTime, self)
	self._simagebg:UnLoadImage()
	self._simagebookleftbg:UnLoadImage()
	self._simagepageNormal:UnLoadImage()
	self._simagepageHard:UnLoadImage()
	self._simageleftpage:UnLoadImage()
	self._simageleftpageline:UnLoadImage()
	self._simagebookrightbgnormal:UnLoadImage()
	self._simagebookrightpagenormal:UnLoadImage()
	self._simagebookrightbghard:UnLoadImage()
	self._simagebookrightpagehard:UnLoadImage()
	self._simagerightpageline:UnLoadImage()
	self._simageicon:UnLoadImage()
	UIBlockMgr.instance:endBlock("Activity119ViewSwitch")
	TaskDispatcher.cancelTask(self.playUnLockAnim, self)

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
end

return Activity119View
