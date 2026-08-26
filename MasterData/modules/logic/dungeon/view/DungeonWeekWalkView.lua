-- chunkname: @modules/logic/dungeon/view/DungeonWeekWalkView.lua

module("modules.logic.dungeon.view.DungeonWeekWalkView", package.seeall)

local DungeonWeekWalkView = class("DungeonWeekWalkView", BaseView)

function DungeonWeekWalkView:onInitView()
	self._goempty = gohelper.findChild(self.viewGO, "anim/rewards/#go_empty")
	self._gohasrewards = gohelper.findChild(self.viewGO, "anim/rewards/#go_hasrewards")
	self._gorewards = gohelper.findChild(self.viewGO, "anim/rewards/#go_hasrewards/Scroll View/Viewport/#go_rewards")
	self._btnshop = gohelper.findChildButtonWithAudio(self.viewGO, "anim/#btn_shop")
	self._btnstart = gohelper.findChildButtonWithAudio(self.viewGO, "anim/#btn_start")
	self._simageline = gohelper.findChildSingleImage(self.viewGO, "anim/#simage_line")
	self._goeasy = gohelper.findChild(self.viewGO, "anim/map/scenetype/#go_easy")
	self._gohard = gohelper.findChild(self.viewGO, "anim/map/scenetype/#go_hard")
	self._txtscenetype = gohelper.findChildText(self.viewGO, "anim/map/scenetype/#txt_scenetype")
	self._txtcurprogress = gohelper.findChildText(self.viewGO, "anim/map/#txt_curprogress")
	self._btnreward = gohelper.findChildButtonWithAudio(self.viewGO, "anim/#btn_reward")
	self._golingqu = gohelper.findChild(self.viewGO, "anim/#btn_reward/#go_lingqu")
	self._gorewardredpoint = gohelper.findChild(self.viewGO, "anim/#btn_reward/#go_rewardredpoint")
	self._txttaskprogress = gohelper.findChildText(self.viewGO, "anim/#btn_reward/#txt_taskprogress")
	self._txtmaptaskprogress = gohelper.findChildText(self.viewGO, "anim/#txt_maptaskprogress")
	self._gomapprogressitem = gohelper.findChild(self.viewGO, "anim/mapprogresslist/#go_mapprogressitem")
	self._txtresettime = gohelper.findChildText(self.viewGO, "anim/#txt_resettime")
	self._simagebgimgnext = gohelper.findChildSingleImage(self.viewGO, "transition/ani/#simage_bgimg_next")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DungeonWeekWalkView:addEvents()
	self._btnshop:AddClickListener(self._btnshopOnClick, self)
	self._btnstart:AddClickListener(self._btnstartOnClick, self)
	self._btnreward:AddClickListener(self._btnrewardOnClick, self)
end

function DungeonWeekWalkView:removeEvents()
	self._btnshop:RemoveClickListener()
	self._btnstart:RemoveClickListener()
	self._btnreward:RemoveClickListener()
end

function DungeonWeekWalkView:_btnrewardOnClick()
	WeekWalkController.instance:openWeekWalkRewardView()
end

function DungeonWeekWalkView:_btnshopOnClick()
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Bank) then
		self:_openStoreView()
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Bank))
	end
end

function DungeonWeekWalkView:_updateTaskStatus()
	local canGet = WeekWalkTaskListModel.instance:canGetReward(WeekWalkEnum.TaskType.Week)

	gohelper.setActive(self._golingqu, canGet)
	gohelper.setActive(self._gorewardredpoint, canGet)
end

function DungeonWeekWalkView:_openStoreView()
	StoreController.instance:openStoreView(StoreEnum.StoreId.WeekWalk)
end

function DungeonWeekWalkView:_btnstartOnClick()
	self:openWeekWalkView()
end

function DungeonWeekWalkView:_initImgs()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "bg/#bg")
	self._simagexingdian1 = gohelper.findChildSingleImage(self.viewGO, "bg/#xingdian1")
	self._simagexingdian2 = gohelper.findChildSingleImage(self.viewGO, "bg/#xingdian2")
	self._simagerightdownglow = gohelper.findChildSingleImage(self.viewGO, "bg/#rightdown_glow")
	self._simagecentertopglow = gohelper.findChildSingleImage(self.viewGO, "bg/#centertop_glow")
	self._simagelefttopglow = gohelper.findChildSingleImage(self.viewGO, "bg/#lefttop_glow")
	self._simagelefttopglow2 = gohelper.findChildSingleImage(self.viewGO, "bg/#lefttop_glow2")
	self._simageleftdownglow = gohelper.findChildSingleImage(self.viewGO, "bg/#leftdown_glow")
	self._simagerihtttopglow = gohelper.findChildSingleImage(self.viewGO, "bg/#rihtttop_glow")
	self._simagerihtttopblack = gohelper.findChildSingleImage(self.viewGO, "bg/#rihtttop_black")
	self._simagecenterdown = gohelper.findChildSingleImage(self.viewGO, "bg/#centerdown")

	self._simagebg:LoadImage(ResUrl.getWeekWalkBg("full/weekwalkbg.jpg"))
	self._simagexingdian1:LoadImage(ResUrl.getWeekWalkBg("xingdian.png"))
	self._simagexingdian2:LoadImage(ResUrl.getWeekWalkBg("xingdian.png"))
	self._simagerightdownglow:LoadImage(ResUrl.getWeekWalkBg("rightdown_glow.png"))
	self._simagecentertopglow:LoadImage(ResUrl.getWeekWalkBg("centertop_hlow.png"))
	self._simagelefttopglow:LoadImage(ResUrl.getWeekWalkBg("lefttop_glow.png"))
	self._simagelefttopglow2:LoadImage(ResUrl.getWeekWalkBg("lefttop_glow2.png"))
	self._simageleftdownglow:LoadImage(ResUrl.getWeekWalkBg("leftdown_glow.png"))
	self._simagerihtttopglow:LoadImage(ResUrl.getWeekWalkBg("righttop_glow.png"))
	self._simagerihtttopblack:LoadImage(ResUrl.getWeekWalkBg("leftdown_black.png"))
	self._simagecenterdown:LoadImage(ResUrl.getWeekWalkBg("centerdown.png"))
	self._simagebgimgnext:LoadImage(ResUrl.getWeekWalkBg("full/weekwalkbg.jpg"))
end

function DungeonWeekWalkView:_editableInitView()
	WeekWalkController.instance:requestTask()
	self:_showBonus()
	self:_updateTaskStatus()
	self:_showDeadline()
	WeekWalkController.instance:startCheckTime()
	self:_initImgs()

	self._viewAnim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	self._simageline:LoadImage(ResUrl.getWeekWalkBg("hw2.png"))
	self:_showProgress()
	gohelper.addUIClickAudio(self._btnstart.gameObject, AudioEnum.WeekWalk.play_artificial_ui_entrance)
	gohelper.addUIClickAudio(self._btnreward.gameObject, AudioEnum.WeekWalk.play_artificial_ui_taskopen)
	gohelper.addUIClickAudio(self._btnshop.gameObject, AudioEnum.UI.play_ui_checkpoint_sources_open)
	self:_initOnOpen()
end

function DungeonWeekWalkView:_updateDegrade()
	local level = WeekWalkModel.instance:getLevel()
	local nums = WeekWalkModel.instance:getChangeLevel()

	gohelper.setActive(self._btndegrade.gameObject, level >= 2 and nums <= 0)
end

function DungeonWeekWalkView:_showProgress()
	local info = WeekWalkModel.instance:getInfo()
	local map, index = info:getNotFinishedMap()
	local sceneConfig = lua_weekwalk_scene.configDict[map.sceneId]

	self._txtcurprogress.text = string.format("【%s】", sceneConfig.battleName)
	self._txtscenetype.text = string.format("%s%s", sceneConfig.typeName, sceneConfig.name)

	if map then
		local cur, total = map:getCurStarInfo()

		self._txtmaptaskprogress.text = string.format("%s/%s", cur, total)
	else
		self._txtmaptaskprogress.text = "0/10"
	end

	local isShallow = WeekWalkModel.isShallowMap(map.sceneId)

	gohelper.setActive(self._goeasy, isShallow)
	gohelper.setActive(self._gohard, not isShallow)

	self._mapFinishItemTab = self._mapFinishItemTab or self:getUserDataTb_()

	local mapInfos = info:getMapInfos()
	local startIndex = 1
	local endIndex = 10

	if not isShallow then
		local info = WeekWalkModel.instance:getInfo()
		local deepLayerList = WeekWalkConfig.instance:getDeepLayer(info.issueId)

		startIndex = 11
		endIndex = startIndex + #deepLayerList - 1
	end

	for k, v in pairs(self._mapFinishItemTab) do
		gohelper.setActive(v, false)
	end

	for i = startIndex, endIndex do
		local item = self._mapFinishItemTab[i]

		if not item then
			item = gohelper.cloneInPlace(self._gomapprogressitem, "item_" .. i)
			self._mapFinishItemTab[i] = item
		end

		gohelper.setActive(item, true)

		local finishImg = gohelper.findChild(item, "finish")
		local mapInfo = mapInfos[i]
		local isFinish = mapInfo and mapInfo.isFinished > 0

		gohelper.setActive(finishImg, isFinish)

		local _unfinishImg = gohelper.findChildImage(item, "unfinish")
		local _finishImg = gohelper.findChildImage(item, "finish")

		if not UISpriteSetMgr.instance:getWeekWalkSpriteSetUnit() then
			self:_setImgAlpha(_unfinishImg, 0)
			self:_setImgAlpha(_finishImg, 0)
		end

		UISpriteSetMgr.instance:setWeekWalkSprite(_unfinishImg, isShallow and "btn_dian2" or "btn_dian4", true, 1)
		UISpriteSetMgr.instance:setWeekWalkSprite(_finishImg, isShallow and "btn_dian1" or "btn_dian3", true, 1)
		gohelper.setActive(gohelper.findChild(item, "finish_light_deepdream01"), not isShallow and isFinish)
		gohelper.setActive(gohelper.findChild(item, "finish_light"), isShallow and isFinish)
	end
end

function DungeonWeekWalkView:_setImgAlpha(image, alpha)
	local color = image.color

	color.a = alpha
	image.color = color
end

function DungeonWeekWalkView.getWeekTaskProgress()
	local progress, maxProgress = 0, 0
	local rewardSet = {}

	WeekWalkTaskListModel.instance:showTaskList(WeekWalkEnum.TaskType.Week)

	local list = WeekWalkTaskListModel.instance:getList()

	for i, v in ipairs(list) do
		local taskMo = WeekWalkTaskListModel.instance:getTaskMo(v.id)

		if taskMo and (taskMo.finishCount > 0 or taskMo.hasFinished) then
			local rewardList = GameUtil.splitString2(v.bonus, true, "|", "#")

			for _, reward in ipairs(rewardList) do
				local type, id, num = reward[1], reward[2], reward[3]
				local key = string.format("%s_%s", type, id)
				local exitReward = rewardSet[key]

				if not exitReward then
					rewardSet[key] = reward
				else
					exitReward[3] = exitReward[3] + num
					rewardSet[key] = exitReward
				end
			end
		end

		if taskMo then
			progress = math.max(taskMo.progress or 0, progress)
		end

		local config = lua_task_weekwalk.configDict[v.id]

		if config then
			maxProgress = math.max(config.maxProgress or 0, maxProgress)
		end
	end

	local list = {}

	for i, reward in pairs(rewardSet) do
		table.insert(list, reward)
	end

	table.sort(list, DungeonWeekWalkView._sort)

	return progress, maxProgress, list
end

function DungeonWeekWalkView._sort(a, b)
	local a_config = ItemModel.instance:getItemConfig(a[1], a[2])
	local b_config = ItemModel.instance:getItemConfig(b[1], b[2])

	if a_config.rare ~= b_config.rare then
		return a_config.rare > b_config.rare
	end

	return a[3] > b[3]
end

function DungeonWeekWalkView:_showBonus()
	if not WeekWalkTaskListModel.instance:hasTaskList() then
		return
	end

	local progress, maxProgress, list = DungeonWeekWalkView.getWeekTaskProgress()

	self._txttaskprogress.text = string.format("%s/%s", progress, maxProgress)

	gohelper.destroyAllChildren(self._gorewards)

	for i, reward in ipairs(list) do
		local item = IconMgr.instance:getCommonItemIcon(self._gorewards)

		item:setMOValue(reward[1], reward[2], reward[3])
		item:isShowCount(true)
		item:setCountFontSize(31)
	end

	local hasReward = #list > 0

	gohelper.setActive(self._goempty, not hasReward)
	gohelper.setActive(self._gohasrewards, hasReward)
end

function DungeonWeekWalkView:onUpdateParam()
	self._viewAnim:Play("dungeonweekwalk_in", 0, 0)
end

function DungeonWeekWalkView:onShow()
	self.viewContainer:setNavigateButtonViewHelpId()
	self:_showWeekWalkSettlementView()

	if self._bgmId then
		return
	end
end

function DungeonWeekWalkView:_onFinishGuide(guideId)
	if guideId == 501 then
		self:_showWeekWalkSettlementView()
	end
end

function DungeonWeekWalkView:_showWeekWalkSettlementView()
	local loadingState = GameGlobalMgr.instance:getLoadingState()

	if loadingState and loadingState:getLoadingViewName() then
		return
	end

	if WeekWalkModel.instance:getSkipShowSettlementView() then
		WeekWalkModel.instance:setSkipShowSettlementView(false)

		return
	end

	if GuideController.instance:isGuiding() then
		return
	end

	local info = WeekWalkModel.instance:getInfo()

	if info.isPopShallowSettle then
		WeekWalkController.instance:openWeekWalkShallowSettlementView()

		return
	end

	if info.isPopDeepSettle then
		WeekWalkController.instance:checkOpenWeekWalkDeepLayerNoticeView()

		return
	end
end

function DungeonWeekWalkView:onHide()
	self.viewContainer:resetNavigateButtonViewHelpId()
end

function DungeonWeekWalkView:onOpen()
	HelpController.instance:registerCallback(HelpEvent.RefreshHelp, self._refreshHelpFunc, self._refreshTarget)
	self:onShow()
end

function DungeonWeekWalkView:_showDeadline()
	TaskDispatcher.cancelTask(self._onRefreshDeadline, self)

	self._endTime = WeekWalkController.getTaskEndTime(WeekWalkEnum.TaskType.Week)

	if not self._endTime then
		return
	end

	TaskDispatcher.runRepeat(self._onRefreshDeadline, self, 1)
	self:_onRefreshDeadline()
end

function DungeonWeekWalkView:_onRefreshDeadline()
	local limitSec = self._endTime - ServerTime.now()

	if limitSec <= 0 then
		WeekWalkController.instance:requestTask(true)
		TaskDispatcher.cancelTask(self._onRefreshDeadline, self)
	end

	local time, format = TimeUtil.secondToRoughTime2(math.floor(limitSec))
	local tag = {
		time,
		format
	}

	self._txtresettime.text = GameUtil.getSubPlaceholderLuaLang(luaLang("dungeonweekwalkview_resettime"), tag)
end

function DungeonWeekWalkView:_onGetInfo()
	self:_showDeadline()
end

function DungeonWeekWalkView:_onWeekwalkTaskUpdate()
	if ViewMgr.instance:isOpen(ViewName.WeekWalkRewardView) or ViewMgr.instance:isOpen(ViewName.WeekWalkLayerRewardView) then
		return
	end

	self:_updateTaskStatus()
	self:_showBonus()
	self:_showDeadline()
end

function DungeonWeekWalkView:_initOnOpen()
	local parentNavigateButtonView = self.viewContainer._navigateButtonView

	self._refreshHelpFunc = parentNavigateButtonView.showHelpBtnIcon
	self._refreshTarget = parentNavigateButtonView

	self.addEventCb(self, WeekWalkController.instance, WeekWalkEvent.OnSelectLevel, self._OnSelectLevel, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self, LuaEventSystem.Low)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self, LuaEventSystem.Low)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self, LuaEventSystem.Low)
	self.addEventCb(self, WeekWalkController.instance, WeekWalkEvent.OnWeekwalkTaskUpdate, self._onWeekwalkTaskUpdate, self)
	self.addEventCb(self, WeekWalkController.instance, WeekWalkEvent.OnGetInfo, self._onGetInfo, self)
	self.addEventCb(self, GuideController.instance, GuideEvent.FinishGuide, self._onFinishGuide, self)
end

function DungeonWeekWalkView:_OnSelectLevel()
	self._dropLevel.dropDown.enabled = false

	local nums = WeekWalkModel.instance:getChangeLevel()

	if nums > 0 then
		return
	end

	self:openWeekWalkView()
end

function DungeonWeekWalkView:openWeekWalkView()
	module_views_preloader.WeekWalkLayerViewPreload(function()
		self:delayOpenWeekWalkView()
	end)
end

function DungeonWeekWalkView:delayOpenWeekWalkView()
	WeekWalkController.instance:openWeekWalkLayerView()
end

function DungeonWeekWalkView:_onOpenViewFinish(viewName)
	if viewName == ViewName.WeekWalkLayerView or viewName == ViewName.StoreView then
		local dungeonView = ViewMgr.instance:getContainer(ViewName.DungeonView)
		local top_left = gohelper.findChild(dungeonView.viewGO, "top_left")

		gohelper.setActive(top_left, true)
	end
end

function DungeonWeekWalkView:_onOpenView(viewName)
	if viewName == ViewName.WeekWalkLayerView then
		-- block empty
	end

	if viewName == ViewName.WeekWalkLayerView or viewName == ViewName.StoreView then
		self._viewAnim:Play("dungeonweekwalk_out", 0, 0)

		local dungeonView = ViewMgr.instance:getContainer(ViewName.DungeonView)

		gohelper.setAsLastSibling(dungeonView.viewGO)

		local top_left = gohelper.findChild(dungeonView.viewGO, "top_left")

		gohelper.setActive(top_left, false)
	end
end

function DungeonWeekWalkView:_onCloseView(viewName)
	if viewName == ViewName.WeekWalkLayerView then
		self:_showProgress()
		self._viewAnim:Play("dungeonweekwalk_in", 0, 0)
	elseif viewName == ViewName.StoreView then
		self._viewAnim:Play("dungeonweekwalk_in", 0, 0)
	elseif viewName == ViewName.WeekWalkRewardView then
		self:_onWeekwalkTaskUpdate()
	end
end

function DungeonWeekWalkView:onClose()
	self:onHide()
	HelpController.instance:unregisterCallback(HelpEvent.RefreshHelp, self._refreshHelpFunc, self._refreshTarget)
end

function DungeonWeekWalkView:_clearOnDestroy()
	TaskDispatcher.cancelTask(self.delayOpenWeekWalkView, self)
	TaskDispatcher.cancelTask(self._openStoreView, self)
	self.removeEventCb(self, WeekWalkController.instance, WeekWalkEvent.OnSelectLevel, self._OnSelectLevel, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self, LuaEventSystem.Low)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self, LuaEventSystem.Low)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self, LuaEventSystem.Low)
	self.removeEventCb(self, WeekWalkController.instance, WeekWalkEvent.OnWeekwalkTaskUpdate, self._onWeekwalkTaskUpdate, self)
	self.removeEventCb(self, GuideController.instance, GuideEvent.FinishGuide, self._onFinishGuide, self)
	TaskDispatcher.cancelTask(self._onRefreshDeadline, self)
end

function DungeonWeekWalkView:onDestroyView()
	self:_clearOnDestroy()
	self._simagebg:UnLoadImage()
	self._simageline:UnLoadImage()
	self._simagexingdian1:UnLoadImage()
	self._simagexingdian2:UnLoadImage()
	self._simagerightdownglow:UnLoadImage()
	self._simagecentertopglow:UnLoadImage()
	self._simagelefttopglow:UnLoadImage()
	self._simagelefttopglow2:UnLoadImage()
	self._simageleftdownglow:UnLoadImage()
	self._simagerihtttopglow:UnLoadImage()
	self._simagerihtttopblack:UnLoadImage()
	self._simagecenterdown:UnLoadImage()
	self._simagebgimgnext:UnLoadImage()
end

return DungeonWeekWalkView
