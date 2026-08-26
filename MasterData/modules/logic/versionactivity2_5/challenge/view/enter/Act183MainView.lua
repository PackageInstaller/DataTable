-- chunkname: @modules/logic/versionactivity2_5/challenge/view/enter/Act183MainView.lua

module("modules.logic.versionactivity2_5.challenge.view.enter.Act183MainView", package.seeall)

local Act183MainView = class("Act183MainView", BaseView)
local UpdateActremainTimeInterval = 1
local UpdateDailyGroupInterval = 30

function Act183MainView:onInitView()
	self._gotopleft = gohelper.findChild(self.viewGO, "root/#go_topleft")
	self._txttime = gohelper.findChildText(self.viewGO, "root/left/#txt_time")
	self._btnreward = gohelper.findChildButtonWithAudio(self.viewGO, "root/left/#btn_reward")
	self._gotaskreddot = gohelper.findChild(self.viewGO, "root/left/#btn_reward/#go_taskreddot")
	self._btnrecord = gohelper.findChildButtonWithAudio(self.viewGO, "root/left/#btn_record")
	self._btnmedal = gohelper.findChildButtonWithAudio(self.viewGO, "root/left/#btn_medal")
	self._gomedalreddot = gohelper.findChild(self.viewGO, "root/left/#btn_medal/#go_medalreddot")
	self._gomain = gohelper.findChild(self.viewGO, "root/middle/#go_main")
	self._gonormal = gohelper.findChild(self.viewGO, "root/middle/#go_main/#go_normal")
	self._gohard = gohelper.findChild(self.viewGO, "root/middle/#go_main/#go_hard")
	self._btnentermain = gohelper.findChildButtonWithAudio(self.viewGO, "root/middle/#btn_entermain")
	self._scrolldaily = gohelper.findChildScrollRect(self.viewGO, "root/right/#scroll_daily")
	self._godailyitem = gohelper.findChild(self.viewGO, "root/right/#scroll_daily/Viewport/Content/#go_dailyitem")
	self._simagelevelpic = gohelper.findChildSingleImage(self.viewGO, "root/middle/#simage_LevelPic")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act183MainView:addEvents()
	self._btnreward:AddClickListener(self._btnrewardOnClick, self)
	self._btnrecord:AddClickListener(self._btnrecordOnClick, self)
	self._btnmedal:AddClickListener(self._btnmedalOnClick, self)
	self._btnentermain:AddClickListener(self._btnentermainOnClick, self)
end

function Act183MainView:removeEvents()
	self._btnreward:RemoveClickListener()
	self._btnrecord:RemoveClickListener()
	self._btnmedal:RemoveClickListener()
	self._btnentermain:RemoveClickListener()
end

function Act183MainView:_btnrewardOnClick()
	Act183Controller.instance:openAct183TaskView()
end

function Act183MainView:_btnrecordOnClick()
	Act183Controller.instance:openAct183ReportView()
end

function Act183MainView:_btnmedalOnClick()
	Act183Controller.instance:openAct183BadgeView()
end

function Act183MainView:_btnentermainOnClick()
	local lastEnterGroupType = Act183Helper.getLastEnterMainGroupTypeInLocal(self._actId, Act183Enum.GroupType.NormalMain)
	local groupEpisodeMo = self._mainGroupEpisodeTab[lastEnterGroupType]

	if not groupEpisodeMo then
		return
	end

	local status = groupEpisodeMo:getStatus()
	local isLocked = status == Act183Enum.GroupStatus.Locked

	if isLocked and lastEnterGroupType ~= Act183Enum.GroupType.NormalMain then
		logError(string.format("本地标记的上一次进入关卡组未解锁!!!, 保底进入普通日常关卡。lastEnterGroupType = %s, status = %s", lastEnterGroupType, status))

		lastEnterGroupType = Act183Enum.GroupType.NormalMain
		groupEpisodeMo = self._mainGroupEpisodeTab[Act183Enum.GroupType.NormalMain]
	end

	local selectGroupId = groupEpisodeMo and groupEpisodeMo:getGroupId()
	local selectGroupType = groupEpisodeMo and groupEpisodeMo:getGroupType()
	local params = Act183Helper.generateDungeonViewParams(selectGroupType, selectGroupId)

	Act183Controller.instance:openAct183DungeonView(params)
end

function Act183MainView:_editableInitView()
	self._actId = Act183Model.instance:getActivityId()
	self._info = Act183Model.instance:getActInfo()

	Act183Model.instance:initTaskStatusMap()

	self._rewardReddotAnim = gohelper.findChildComponent(self._btnreward.gameObject, "ani", gohelper.Type_Animator)

	RedDotController.instance:addRedDot(self._gotaskreddot, RedDotEnum.DotNode.V2a5_Act183Task, nil, self._taskReddotFunc, self)
	self.addEventCb(self, Act183Controller.instance, Act183Event.RefreshMedalReddot, self.initOrRefreshMedalReddot, self)

	local bannerIconNameCo = lua_challenge_const.configDict[Act183Enum.Const.MainBannerUrl]

	if bannerIconNameCo then
		if not bannerIconNameCo.value2 then
			local bannerIconName = ""

			self._simagelevelpic:LoadImage(ResUrl.getChallengeIcon(bannerIconName))
		end
	end
end

function Act183MainView:_taskReddotFunc(reddotIcon)
	reddotIcon:defaultRefreshDot()
	self._rewardReddotAnim:Play(reddotIcon.show and "loop" or "idle", 0, 0)
end

function Act183MainView:onOpen()
	self:initRemainTime()
	self:initMainGroupEntranceList()
	self:initDailyGroupEntranceList()
	self:initOrRefreshMedalReddot()
end

function Act183MainView:initRemainTime()
	self:showLeftTime()
	TaskDispatcher.runRepeat(self.showLeftTime, self, UpdateActremainTimeInterval)
end

function Act183MainView:showLeftTime()
	self._txttime.text = ActivityHelper.getActivityRemainTimeStr(self._actId)
end

function Act183MainView:initMainGroupEntranceList()
	local normalGroupEpisodes = self._info:getGroupEpisodeMos(Act183Enum.GroupType.NormalMain)
	local hardGroupEpisodes = self._info:getGroupEpisodeMos(Act183Enum.GroupType.HardMain)
	local normalGroupEpisode = normalGroupEpisodes and normalGroupEpisodes[1]
	local hardGroupEpisode = hardGroupEpisodes and hardGroupEpisodes[1]

	if not normalGroupEpisode or not hardGroupEpisode then
		return
	end

	self._mainGroupEpisodeTab = {
		[Act183Enum.GroupType.NormalMain] = normalGroupEpisode,
		[Act183Enum.GroupType.HardMain] = hardGroupEpisode
	}

	for groupType, groupMo in pairs(self._mainGroupEpisodeTab) do
		local chapterItem = Act183MainGroupEntranceItem.Get(self.viewGO, groupType)

		chapterItem:onUpdateMO(groupMo)
	end
end

function Act183MainView:initDailyGroupEntranceList()
	TaskDispatcher.cancelTask(self.initDailyGroupEntranceList, self)

	self._dailyGroupEpisodeMos = self._info:getGroupEpisodeMos(Act183Enum.GroupType.Daily)

	if self._dailyGroupEpisodeMos then
		self._dailyGroupEpisodeCount = #self._dailyGroupEpisodeMos or 0
	end

	if not self._dailyGroupEpisodeMos then
		return
	end

	local tickUp = false

	for index, dailyGroupMo in ipairs(self._dailyGroupEpisodeMos) do
		local groupItem = Act183DailyGroupEntranceItem.Get(self.viewGO, self._godailyitem, dailyGroupMo, index)
		local status = dailyGroupMo:getStatus()

		groupItem:onUpdateMO(dailyGroupMo)

		if status == Act183Enum.GroupStatus.Locked and not tickUp then
			groupItem:showUnlockCountDown()

			tickUp = true
		end
	end

	if tickUp then
		TaskDispatcher.runDelay(self.initDailyGroupEntranceList, self, UpdateDailyGroupInterval)
	end
end

function Act183MainView:initOrRefreshMedalReddot()
	self._medatReddot = self._medatReddot or RedDotController.instance:addNotEventRedDot(self._gomedalreddot, self._checkMedalReddot, self, RedDotEnum.Style.Normal)

	self._medatReddot:refreshRedDot()
end

function Act183MainView:_checkMedalReddot()
	local hasReadUnlockHeroIds = Act183Helper.getHasReadUnlockSupportHeroIdsInLocal(self._actId)
	local hasReadUnlockHeroIdMap = Act183Helper.listToMap(hasReadUnlockHeroIds)
	local unlockSupportHeroIds = self._info:getUnlockSupportHeroIds()

	if unlockSupportHeroIds then
		for _, unlockHeroId in ipairs(unlockSupportHeroIds) do
			if not hasReadUnlockHeroIdMap[unlockHeroId] then
				return true
			end
		end
	end
end

function Act183MainView:onClose()
	TaskDispatcher.cancelTask(self.showLeftTime, self)
	TaskDispatcher.cancelTask(self.initDailyGroupEntranceList, self)
end

function Act183MainView:onDestroyView()
	self._simagelevelpic:UnLoadImage()
end

return Act183MainView
