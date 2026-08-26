-- chunkname: @modules/logic/dungeon/view/DungeonWeekWalk_2View.lua

module("modules.logic.dungeon.view.DungeonWeekWalk_2View", package.seeall)

local DungeonWeekWalk_2View = class("DungeonWeekWalk_2View", BaseView)

function DungeonWeekWalk_2View:onInitView()
	self._btnenterbtn = gohelper.findChildButtonWithAudio(self.viewGO, "anim/shallowbox/#btn_enterbtn")
	self._btnreward = gohelper.findChildButtonWithAudio(self.viewGO, "anim/shallowbox/#btn_reward")
	self._golingqu = gohelper.findChild(self.viewGO, "anim/shallowbox/#btn_reward/#go_lingqu")
	self._gorewardredpoint = gohelper.findChild(self.viewGO, "anim/shallowbox/#btn_reward/#go_rewardredpoint")
	self._txttaskprogress = gohelper.findChildText(self.viewGO, "anim/shallowbox/#btn_reward/#txt_taskprogress")
	self._btnstart = gohelper.findChildButtonWithAudio(self.viewGO, "anim/deepbox/#btn_start")
	self._goeasy = gohelper.findChild(self.viewGO, "anim/deepbox/map/scenetype/#go_easy")
	self._gohard = gohelper.findChild(self.viewGO, "anim/deepbox/map/scenetype/#go_hard")
	self._txtscenetype = gohelper.findChildText(self.viewGO, "anim/deepbox/map/scenetype/#txt_scenetype")
	self._txtcurprogress = gohelper.findChildText(self.viewGO, "anim/deepbox/map/#txt_curprogress")
	self._txtcurrency1 = gohelper.findChildText(self.viewGO, "anim/deepbox/rewardPreview/#txt_currency1")
	self._txttotal1 = gohelper.findChildText(self.viewGO, "anim/deepbox/rewardPreview/#txt_currency1/#txt_total1")
	self._gonormal1 = gohelper.findChild(self.viewGO, "anim/deepbox/rewardPreview/#txt_currency1/btn/normal")
	self._gocanget1 = gohelper.findChild(self.viewGO, "anim/deepbox/rewardPreview/#txt_currency1/btn/#go_canget1")
	self._gohasget1 = gohelper.findChild(self.viewGO, "anim/deepbox/rewardPreview/#txt_currency1/btn/#go_hasget1")
	self._btnclick1 = gohelper.findChildButtonWithAudio(self.viewGO, "anim/deepbox/rewardPreview/#txt_currency1/btn/#btn_click1")
	self._txttime = gohelper.findChildText(self.viewGO, "anim/deepbox/limittime/#txt_time")
	self._txtmaptaskprogress = gohelper.findChildText(self.viewGO, "anim/deepbox/#txt_maptaskprogress")
	self._gomapprogressitem = gohelper.findChild(self.viewGO, "anim/deepbox/mapprogresslist/#go_mapprogressitem")
	self._btnstart2 = gohelper.findChildButtonWithAudio(self.viewGO, "anim/heartbox/#btn_start_2")
	self._goeasy2 = gohelper.findChild(self.viewGO, "anim/heartbox/map/scenetype/#go_easy2")
	self._gohard2 = gohelper.findChild(self.viewGO, "anim/heartbox/map/scenetype/#go_hard2")
	self._txtscenetype2 = gohelper.findChildText(self.viewGO, "anim/heartbox/map/scenetype/#txt_scenetype2")
	self._txtcurprogress2 = gohelper.findChildText(self.viewGO, "anim/heartbox/map/#txt_curprogress2")
	self._btnreward2 = gohelper.findChildButtonWithAudio(self.viewGO, "anim/heartbox/map/#btn_reward2")
	self._gobubble = gohelper.findChild(self.viewGO, "anim/heartbox/map/#btn_reward2/#go_bubble")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "anim/heartbox/map/#btn_reward2/#go_bubble/#simage_icon")
	self._gomapprogressitem2 = gohelper.findChild(self.viewGO, "anim/heartbox/mapprogresslist/#go_mapprogressitem2")
	self._txtcurrency2 = gohelper.findChildText(self.viewGO, "anim/heartbox/rewardPreview/#txt_currency2")
	self._txttotal2 = gohelper.findChildText(self.viewGO, "anim/heartbox/rewardPreview/#txt_currency2/#txt_total2")
	self._gonormal2 = gohelper.findChild(self.viewGO, "anim/heartbox/rewardPreview/#txt_currency2/btn/normal")
	self._gocanget2 = gohelper.findChild(self.viewGO, "anim/heartbox/rewardPreview/#txt_currency2/btn/#go_canget2")
	self._gohasget2 = gohelper.findChild(self.viewGO, "anim/heartbox/rewardPreview/#txt_currency2/btn/#go_hasget2")
	self._btnclick2 = gohelper.findChildButtonWithAudio(self.viewGO, "anim/heartbox/rewardPreview/#txt_currency2/btn/#btn_click2")
	self._txttime2 = gohelper.findChildText(self.viewGO, "anim/heartbox/limittime/#txt_time2")
	self._goitem1 = gohelper.findChild(self.viewGO, "anim/heartbox/badgelist/1/badgelayout/#go_item_1")
	self._goitem2 = gohelper.findChild(self.viewGO, "anim/heartbox/badgelist/2/badgelayout/#go_item_2")
	self._btnshop = gohelper.findChildButtonWithAudio(self.viewGO, "anim/#btn_shop")
	self._simagebgimgnext = gohelper.findChildSingleImage(self.viewGO, "transition/ani/#simage_bgimg_next")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DungeonWeekWalk_2View:addEvents()
	self._btnenterbtn:AddClickListener(self._btnenterbtnOnClick, self)
	self._btnreward:AddClickListener(self._btnrewardOnClick, self)
	self._btnstart:AddClickListener(self._btnstartOnClick, self)
	self._btnclick1:AddClickListener(self._btnclick1OnClick, self)
	self._btnstart2:AddClickListener(self._btnstart2OnClick, self)
	self._btnreward2:AddClickListener(self._btnreward2OnClick, self)
	self._btnclick2:AddClickListener(self._btnclick2OnClick, self)
	self._btnshop:AddClickListener(self._btnshopOnClick, self)
end

function DungeonWeekWalk_2View:removeEvents()
	self._btnenterbtn:RemoveClickListener()
	self._btnreward:RemoveClickListener()
	self._btnstart:RemoveClickListener()
	self._btnclick1:RemoveClickListener()
	self._btnstart2:RemoveClickListener()
	self._btnreward2:RemoveClickListener()
	self._btnclick2:RemoveClickListener()
	self._btnshop:RemoveClickListener()
end

function DungeonWeekWalk_2View:_btnclick1OnClick()
	if not self._openMapId1 then
		return
	end

	local mapId = self:_getLastMapId1()

	if mapId then
		WeekWalkController.instance:openWeekWalkLayerRewardView({
			mapId = mapId
		})

		return
	end

	WeekWalkController.instance:openWeekWalkLayerRewardView({
		mapId = self._openMapId1
	})
end

function DungeonWeekWalk_2View:_getLastMapId1()
	local info = WeekWalkModel.instance:getInfo()
	local deepLayerList = WeekWalkConfig.instance:getDeepLayer(info.issueId)
	local maxLayer = ResSplitConfig.instance:getMaxWeekWalkLayer()

	if deepLayerList then
		for i, v in ipairs(deepLayerList) do
			local mapId = v.id
			local taskType = WeekWalkRewardView.getTaskType(mapId)
			local canGetNum, unFinishNum = WeekWalkTaskListModel.instance:canGetRewardNum(taskType, mapId)
			local canGetReward = canGetNum > 0
			local hasGet = not canGetReward and unFinishNum <= 0

			if not hasGet or i == #deepLayerList then
				return mapId
			end
		end
	end
end

function DungeonWeekWalk_2View:_btnclick2OnClick()
	if not self._openMapId2 then
		return
	end

	local mapId = self:_getLastMapId2()

	if mapId then
		WeekWalk_2Controller.instance:openWeekWalk_2LayerRewardView({
			mapId = mapId
		})

		return
	end

	WeekWalk_2Controller.instance:openWeekWalk_2LayerRewardView({
		mapId = self._openMapId2
	})
end

function DungeonWeekWalk_2View:_getLastMapId2()
	local info = WeekWalk_2Model.instance:getInfo()

	for i = 1, WeekWalk_2Enum.MaxLayer do
		local layerInfo = info:getLayerInfoByLayerIndex(i)
		local mapId = layerInfo.id
		local taskType = WeekWalk_2Enum.TaskType.Season
		local canGetNum, unFinishNum = WeekWalk_2TaskListModel.instance:canGetRewardNum(taskType, mapId)
		local canGetReward = canGetNum > 0
		local hasGet = not canGetReward and unFinishNum <= 0

		if not hasGet or i == WeekWalk_2Enum.MaxLayer then
			return mapId
		end
	end
end

function DungeonWeekWalk_2View:_btnreward2OnClick()
	WeekWalk_2Controller.instance:openWeekWalk_2LayerRewardView({
		mapId = 0
	})
end

function DungeonWeekWalk_2View:_btnstart2OnClick()
	WeekWalk_2Controller.instance:openWeekWalk_2HeartLayerView()
end

function DungeonWeekWalk_2View:_btnenterbtnOnClick()
	module_views_preloader.WeekWalkLayerViewPreload(function()
		WeekWalkController.instance:openWeekWalkLayerView({
			layerId = 10
		})
	end)
end

function DungeonWeekWalk_2View:_btnrewardOnClick()
	WeekWalkController.instance:openWeekWalkRewardView()
end

function DungeonWeekWalk_2View:_btnshopOnClick()
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Bank) then
		self:_openStoreView()
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Bank))
	end
end

function DungeonWeekWalk_2View:_updateTaskStatus()
	local canGet = WeekWalkTaskListModel.instance:canGetReward(WeekWalkEnum.TaskType.Week)

	gohelper.setActive(self._golingqu, canGet)
	gohelper.setActive(self._gorewardredpoint, canGet)
end

function DungeonWeekWalk_2View:_openStoreView()
	StoreController.instance:openStoreView(StoreEnum.StoreId.WeekWalk)
end

function DungeonWeekWalk_2View:_btnstartOnClick()
	self:openWeekWalkView()
end

function DungeonWeekWalk_2View:_initImgs()
	self._simagexingdian1 = gohelper.findChildSingleImage(self.viewGO, "bg/#xingdian1")
	self._simagelefttopglow = gohelper.findChildSingleImage(self.viewGO, "bg/#lefttop_glow")
	self._simagelefttopglow2 = gohelper.findChildSingleImage(self.viewGO, "bg/#lefttop_glow2")
	self._simageleftdownglow = gohelper.findChildSingleImage(self.viewGO, "bg/#leftdown_glow")
	self._simagerihtttopglow = gohelper.findChildSingleImage(self.viewGO, "bg/#rihtttop_glow")
	self._simagerihtttopblack = gohelper.findChildSingleImage(self.viewGO, "bg/#rihtttop_black")
	self._simagecenterdown = gohelper.findChildSingleImage(self.viewGO, "bg/#centerdown")

	self._simagexingdian1:LoadImage(ResUrl.getWeekWalkBg("xingdian.png"))
	self._simagelefttopglow:LoadImage(ResUrl.getWeekWalkBg("lefttop_glow.png"))
	self._simagelefttopglow2:LoadImage(ResUrl.getWeekWalkBg("lefttop_glow2.png"))
	self._simageleftdownglow:LoadImage(ResUrl.getWeekWalkBg("leftdown_glow.png"))
	self._simagerihtttopglow:LoadImage(ResUrl.getWeekWalkBg("righttop_glow.png"))
	self._simagerihtttopblack:LoadImage(ResUrl.getWeekWalkBg("leftdown_black.png"))
	self._simagecenterdown:LoadImage(ResUrl.getWeekWalkBg("centerdown.png"))
end

function DungeonWeekWalk_2View:_editableInitView()
	WeekWalkController.instance:requestTask()
	self:_showBonus()
	self:_updateTaskStatus()
	self:_onWeekwalk_2TaskUpdate()
	self:_showDeadline()
	WeekWalkController.instance:startCheckTime()
	self:_initImgs()

	self._viewAnim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	self:_showProgress()
	self:_showProgress2()
	gohelper.addUIClickAudio(self._btnstart.gameObject, AudioEnum.WeekWalk.play_artificial_ui_entrance)
	gohelper.addUIClickAudio(self._btnreward.gameObject, AudioEnum.WeekWalk.play_artificial_ui_taskopen)
	gohelper.addUIClickAudio(self._btnshop.gameObject, AudioEnum.UI.play_ui_checkpoint_sources_open)
	self:_initOnOpen()
end

function DungeonWeekWalk_2View:_updateDegrade()
	local level = WeekWalkModel.instance:getLevel()
	local nums = WeekWalkModel.instance:getChangeLevel()

	gohelper.setActive(self._btndegrade.gameObject, level >= 2 and nums <= 0)
end

function DungeonWeekWalk_2View:_showProgress2()
	local info = WeekWalk_2Model.instance:getInfo()
	local map, index = info:getNotFinishedMap()

	if not map then
		logError("DungeonWeekWalk_2View _showProgress2 map is nil")

		return
	end

	local sceneConfig = map.sceneConfig

	self._txtcurprogress2.text = string.format("【%s】", sceneConfig.battleName)
	self._txtscenetype2.text = string.format("%s%s", sceneConfig.typeName, sceneConfig.name)
	self._mapFinishItemTab2 = self._mapFinishItemTab2 or self:getUserDataTb_()

	for k, v in pairs(self._mapFinishItemTab2) do
		gohelper.setActive(v, false)
	end

	for i = 1, WeekWalk_2Enum.MaxLayer do
		local item = self._mapFinishItemTab2[i]

		if not item then
			item = gohelper.cloneInPlace(self._gomapprogressitem2, "item_" .. i)
			self._mapFinishItemTab2[i] = item
		end

		gohelper.setActive(item, true)

		local finishGo = gohelper.findChild(item, "finish")
		local unfinishGo = gohelper.findChild(item, "unfinish")
		local mapInfo = info:getLayerInfoByLayerIndex(i)
		local isFinish = mapInfo and mapInfo.finished

		gohelper.setActive(finishGo, isFinish)
		gohelper.setActive(unfinishGo, not isFinish)
		gohelper.setActive(gohelper.findChild(item, "finish_light_deepdream01"), isFinish)
	end

	self._battleStar1List = self._battleStar1List or self:getUserDataTb_()
	self._battleStar2List = self._battleStar2List or self:getUserDataTb_()

	self:_showBattleInfo(self._battleStar1List, self._goitem1, map:getBattleInfoByIndex(WeekWalk_2Enum.BattleIndex.First))
	self:_showBattleInfo(self._battleStar2List, self._goitem2, map:getBattleInfoByIndex(WeekWalk_2Enum.BattleIndex.Second))

	local cur, total, canGetList, openMapId = WeekWalk_2TaskListModel.instance:getAllTaskInfo()

	self._openMapId2 = openMapId
	self._txtcurrency2.text = cur
	self._txttotal2.text = total

	local canGet = #canGetList > 0

	gohelper.setActive(self._gonormal2, not canGet)
	gohelper.setActive(self._gocanget2, canGet)
	gohelper.setActive(self._gohasget2, cur == total)
end

function DungeonWeekWalk_2View:_showBattleInfo(list, item1, battleInfo)
	gohelper.setActive(item1, false)

	for i = 1, WeekWalk_2Enum.MaxStar do
		local iconEffect = list[i]

		if not iconEffect then
			local item = gohelper.cloneInPlace(item1)
			local icon = gohelper.findChildImage(item, "1")

			gohelper.setActive(item, true)

			icon.enabled = false
			iconEffect = self.viewContainer:getResInst(self.viewContainer._viewSetting.otherRes.weekwalkheart_star, icon.gameObject)
			list[i] = iconEffect
		end

		local cupInfo = battleInfo:getCupInfo(i)

		if cupInfo then
			if not cupInfo.result then
				local star = 0

				WeekWalk_2Helper.setCupEffectByResult(iconEffect, star)
			end
		end
	end
end

function DungeonWeekWalk_2View:_showProgress()
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

	local mapInfos = info:getMapInfoLayer()
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

	local cur, total, canGetList, openMapId = WeekWalkTaskListModel.instance:getAllDeepTaskInfo()

	self._openMapId1 = openMapId
	self._txtcurrency1.text = cur
	self._txttotal1.text = total

	local canGet = #canGetList > 0

	gohelper.setActive(self._gonormal1, not canGet)
	gohelper.setActive(self._gocanget1, canGet)
	gohelper.setActive(self._gohasget1, cur == total)
end

function DungeonWeekWalk_2View:_setImgAlpha(image, alpha)
	local color = image.color

	color.a = alpha
	image.color = color
end

function DungeonWeekWalk_2View.getWeekTaskProgress()
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

	table.sort(list, DungeonWeekWalk_2View._sort)

	return progress, maxProgress, list
end

function DungeonWeekWalk_2View._sort(a, b)
	local a_config = ItemModel.instance:getItemConfig(a[1], a[2])
	local b_config = ItemModel.instance:getItemConfig(b[1], b[2])

	if a_config.rare ~= b_config.rare then
		return a_config.rare > b_config.rare
	end

	return a[3] > b[3]
end

function DungeonWeekWalk_2View:_showBonus()
	if not WeekWalkTaskListModel.instance:hasTaskList() then
		return
	end

	local progress, maxProgress, list = DungeonWeekWalk_2View.getWeekTaskProgress()

	self._txttaskprogress.text = string.format("%s/%s", progress, maxProgress)

	if self._gorewards then
		gohelper.destroyAllChildren(self._gorewards)

		for i, reward in ipairs(list) do
			local item = IconMgr.instance:getCommonItemIcon(self._gorewards)

			item:setMOValue(reward[1], reward[2], reward[3])
			item:isShowCount(true)
			item:setCountFontSize(31)
		end
	end

	local hasReward = #list > 0

	gohelper.setActive(self._goempty, not hasReward)
	gohelper.setActive(self._gohasrewards, hasReward)
end

function DungeonWeekWalk_2View:onUpdateParam()
	self._viewAnim:Play("dungeonweekwalk_in", 0, 0)
end

function DungeonWeekWalk_2View:onShow()
	self.viewContainer:setNavigateButtonViewHelpId()
	self:_showWeekWalkSettlementView()

	if self._bgmId then
		return
	end
end

function DungeonWeekWalk_2View:_onFinishGuide(guideId)
	if guideId == 501 then
		self:_showWeekWalkSettlementView()
	end
end

function DungeonWeekWalk_2View:_showWeekWalkSettlementView()
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

	WeekWalk_2Controller.instance:checkOpenWeekWalk_2DeepLayerNoticeView()
end

function DungeonWeekWalk_2View:onHide()
	self.viewContainer:resetNavigateButtonViewHelpId()
end

function DungeonWeekWalk_2View:onOpen()
	HelpController.instance:registerCallback(HelpEvent.RefreshHelp, self._refreshHelpFunc, self._refreshTarget)
	self:onShow()
end

function DungeonWeekWalk_2View:onOpenFinish()
	self.viewContainer:destoryTab(DungeonEnum.DungeonViewTabEnum.WeekWalk)
end

function DungeonWeekWalk_2View:_showDeadline()
	TaskDispatcher.cancelTask(self._onRefreshDeadline, self)

	self._endTaskTime = WeekWalkController.getTaskEndTime(WeekWalkEnum.TaskType.Week)
	self._endTime = WeekWalkModel.instance:getInfo().endTime
	self._heartEndTime = WeekWalk_2Model.instance:getInfo().endTime

	TaskDispatcher.runRepeat(self._onRefreshDeadline, self, 1)
	self:_onRefreshDeadline()
end

function DungeonWeekWalk_2View:_onRefreshDeadline()
	if self._endTaskTime then
		local limitSec = self._endTaskTime - ServerTime.now()

		if limitSec <= 0 then
			self._endTaskTime = nil

			WeekWalkController.instance:requestTask(true)
		end
	end

	local tip = luaLang("p_dungeonweekwalkview_device")

	if self._endTime then
		local limitSec = self._endTime - ServerTime.now()

		if limitSec <= 0 then
			self._endTime = nil

			TaskDispatcher.cancelTask(self._onRefreshDeadline, self)
		end

		local time, format = TimeUtil.secondToRoughTime2(math.floor(limitSec))

		self._txttime.text = tip .. time .. format
	end

	if self._heartEndTime then
		local limitSec = self._heartEndTime - ServerTime.now()

		if limitSec <= 0 then
			self._heartEndTime = nil

			TaskDispatcher.cancelTask(self._onRefreshDeadline, self)
		end

		local time, format = TimeUtil.secondToRoughTime2(math.floor(limitSec))

		self._txttime2.text = tip .. time .. format
	end
end

function DungeonWeekWalk_2View:_onGetInfo()
	self:_showDeadline()
end

function DungeonWeekWalk_2View:_onWeekwalkTaskUpdate()
	if ViewMgr.instance:isOpen(ViewName.WeekWalkRewardView) or ViewMgr.instance:isOpen(ViewName.WeekWalkLayerRewardView) then
		return
	end

	self:_updateTaskStatus()
	self:_showBonus()
	self:_showDeadline()
end

function DungeonWeekWalk_2View:_onWeekwalk_2TaskUpdate()
	local taskType = WeekWalk_2Enum.TaskType.Once
	local canGetNum, unFinishNum = WeekWalk_2TaskListModel.instance:canGetRewardNum(taskType)
	local canGetReward = canGetNum > 0

	gohelper.setActive(self._gobubble, true)

	self._gobubbleReddot = self._gobubbleReddot or gohelper.findChild(self.viewGO, "anim/heartbox/map/#btn_reward2/reddot")

	gohelper.setActive(self._gobubbleReddot, canGetReward)

	self._rewardAnimator = self._rewardAnimator or self._btnreward2.gameObject:GetComponent(typeof(UnityEngine.Animator))

	if self._rewardAnimator then
		self._rewardAnimator:Play(canGetReward and "reward" or "idle")
	end

	if canGetNum == 0 and unFinishNum == 0 then
		gohelper.setActive(self._btnreward2, false)
	end

	self:_showProgress()
	self:_showProgress2()
end

function DungeonWeekWalk_2View:_initOnOpen()
	local parentNavigateButtonView = self.viewContainer._navigateButtonView

	self._refreshHelpFunc = parentNavigateButtonView.showHelpBtnIcon
	self._refreshTarget = parentNavigateButtonView

	self.addEventCb(self, WeekWalkController.instance, WeekWalkEvent.OnSelectLevel, self._OnSelectLevel, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self, LuaEventSystem.Low)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self, LuaEventSystem.Low)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self, LuaEventSystem.Low)
	self.addEventCb(self, WeekWalkController.instance, WeekWalkEvent.OnWeekwalkTaskUpdate, self._onWeekwalkTaskUpdate, self)
	self.addEventCb(self, WeekWalk_2Controller.instance, WeekWalk_2Event.OnWeekwalkTaskUpdate, self._onWeekwalk_2TaskUpdate, self)
	self.addEventCb(self, WeekWalkController.instance, WeekWalkEvent.OnGetInfo, self._onGetInfo, self)
	self.addEventCb(self, WeekWalk_2Controller.instance, WeekWalk_2Event.OnGetInfo, self._onGetInfo, self)
end

function DungeonWeekWalk_2View:_OnSelectLevel()
	self._dropLevel.dropDown.enabled = false

	local nums = WeekWalkModel.instance:getChangeLevel()

	if nums > 0 then
		return
	end

	self:openWeekWalkView()
end

function DungeonWeekWalk_2View:openWeekWalkView()
	module_views_preloader.WeekWalkLayerViewPreload(function()
		self:delayOpenWeekWalkView()
	end)
end

function DungeonWeekWalk_2View:delayOpenWeekWalkView()
	WeekWalkController.instance:openWeekWalkLayerView()
end

function DungeonWeekWalk_2View:_onOpenViewFinish(viewName)
	if viewName == ViewName.WeekWalkLayerView or viewName == ViewName.WeekWalk_2HeartLayerView or viewName == ViewName.StoreView then
		local dungeonView = ViewMgr.instance:getContainer(ViewName.DungeonView)
		local top_left = gohelper.findChild(dungeonView.viewGO, "top_left")

		gohelper.setActive(top_left, true)
	end
end

function DungeonWeekWalk_2View:_onOpenView(viewName)
	if viewName == ViewName.WeekWalkLayerView then
		-- block empty
	end

	if viewName == ViewName.WeekWalkLayerView or viewName == ViewName.WeekWalk_2HeartLayerView or viewName == ViewName.StoreView then
		if viewName == ViewName.WeekWalk_2HeartLayerView then
			if ViewMgr.instance:isOpen(ViewName.WeekWalk_2HeartView) then
				return
			end

			self._viewAnim:Play("dungeonweekwalk_out2", 0, 0)
		else
			self._viewAnim:Play("dungeonweekwalk_out", 0, 0)
		end

		local dungeonView = ViewMgr.instance:getContainer(ViewName.DungeonView)

		gohelper.setAsLastSibling(dungeonView.viewGO)

		local top_left = gohelper.findChild(dungeonView.viewGO, "top_left")

		gohelper.setActive(top_left, false)
	end
end

function DungeonWeekWalk_2View:_onCloseView(viewName)
	if viewName == ViewName.WeekWalkLayerView then
		self:_showProgress()
		self:_showWeekWalkSettlementView()
		self._viewAnim:Play("dungeonweekwalk_in", 0, 0)
	elseif viewName == ViewName.StoreView then
		self._viewAnim:Play("dungeonweekwalk_in", 0, 0)
	elseif viewName == ViewName.WeekWalkRewardView then
		self:_onWeekwalkTaskUpdate()
	elseif viewName == ViewName.WeekWalk_2HeartLayerView then
		self:_showProgress2()
		self._viewAnim:Play("dungeonweekwalk_in", 0, 0)
	end
end

function DungeonWeekWalk_2View:onClose()
	self:onHide()
	HelpController.instance:unregisterCallback(HelpEvent.RefreshHelp, self._refreshHelpFunc, self._refreshTarget)
end

function DungeonWeekWalk_2View:_clearOnDestroy()
	TaskDispatcher.cancelTask(self.delayOpenWeekWalkView, self)
	TaskDispatcher.cancelTask(self._openStoreView, self)
	self.removeEventCb(self, WeekWalkController.instance, WeekWalkEvent.OnSelectLevel, self._OnSelectLevel, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self, LuaEventSystem.Low)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self, LuaEventSystem.Low)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self, LuaEventSystem.Low)
	self.removeEventCb(self, WeekWalkController.instance, WeekWalkEvent.OnWeekwalkTaskUpdate, self._onWeekwalkTaskUpdate, self)
	self.removeEventCb(self, WeekWalkController.instance, WeekWalkEvent.OnGetInfo, self._onGetInfo, self)
	self.removeEventCb(self, WeekWalk_2Controller.instance, WeekWalk_2Event.OnGetInfo, self._onGetInfo, self)
	self.removeEventCb(self, GuideController.instance, GuideEvent.FinishGuide, self._onFinishGuide, self)
	TaskDispatcher.cancelTask(self._onRefreshDeadline, self)
end

function DungeonWeekWalk_2View:onDestroyView()
	self:_clearOnDestroy()
	self._simagexingdian1:UnLoadImage()
	self._simagelefttopglow:UnLoadImage()
	self._simagelefttopglow2:UnLoadImage()
	self._simageleftdownglow:UnLoadImage()
	self._simagerihtttopglow:UnLoadImage()
	self._simagerihtttopblack:UnLoadImage()
	self._simagecenterdown:UnLoadImage()
end

return DungeonWeekWalk_2View
