-- chunkname: @modules/logic/versionactivity1_5/enter/view/VersionActivity1_5EnterView.lua

module("modules.logic.versionactivity1_5.enter.view.VersionActivity1_5EnterView", package.seeall)

local VersionActivity1_5EnterView = class("VersionActivity1_5EnterView", VersionActivityEnterBaseViewWithGroup)

function VersionActivity1_5EnterView:onInitView()
	VersionActivity1_5EnterView.super.onInitView(self)

	self._txtremaintime = gohelper.findChildText(self.viewGO, "logo/Time/timebg/#txt_remaintime")
	self._txttime = gohelper.findChildText(self.viewGO, "logo/Time/#txt_time")
	self.txtDungeonStoreNum1 = gohelper.findChildText(self.viewGO, "entrance/#go_group1/activityContainer4/normal/#txt_num")
	self.txtDungeonStoreNum2 = gohelper.findChildText(self.viewGO, "entrance/#go_group2/activityContainer10/normal/#txt_num")
	self.txtDungeonStoreRemainTime1 = gohelper.findChildText(self.viewGO, "entrance/#go_group1/activityContainer4/#go_time/#txt_time")
	self.txtDungeonStoreRemainTime2 = gohelper.findChildText(self.viewGO, "entrance/#go_group2/activityContainer10/#go_time/#txt_time")
	self._btnseasonstore = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#go_group2/#btn_seasonstore")
	self._txtseasonstorenum = gohelper.findChildText(self.viewGO, "entrance/#go_group2/#btn_seasonstore/normal/storeBG/#txt_num")
	self._txtseasonstoretime = gohelper.findChildText(self.viewGO, "entrance/#go_group2/#btn_seasonstore/normal/#go_bg1/#txt_time")
	self._btnachievementpreview = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_achievementpreview")
	self.gobg1 = gohelper.findChild(self.viewGO, "bg1")
	self.gobg2 = gohelper.findChild(self.viewGO, "bg2")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_5EnterView:addEvents()
	VersionActivity1_5EnterView.super.addEvents(self)
	self._btnseasonstore:AddClickListener(self._btnseasonstoreOnClick, self)
	self._btnachievementpreview:AddClickListener(self._btnachievementpreviewOnClick, self)
end

function VersionActivity1_5EnterView:removeEvents()
	VersionActivity1_5EnterView.super.removeEvents(self)
	self._btnseasonstore:RemoveClickListener()
	self._btnachievementpreview:RemoveClickListener()
end

function VersionActivity1_5EnterView:_editableInitView()
	VersionActivity1_5EnterView.super._editableInitView(self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.refreshCurrency, self)
end

function VersionActivity1_5EnterView:_btnseasonstoreOnClick()
	local actId = Activity104Model.instance:getCurSeasonId()
	local storeActId = Activity104Enum.SeasonStore[actId]
	local status, toastId, toastParam = ActivityHelper.getActivityStatusAndToast(storeActId)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		if toastId then
			GameFacade.showToast(toastId, toastParam)
		end

		return
	end

	Activity104Controller.instance:openSeasonStoreView()
end

function VersionActivity1_5EnterView:_btnachievementpreviewOnClick()
	local actCfg = ActivityConfig.instance:getActivityCo(self.actId)

	if actCfg and actCfg.achievementGroup ~= 0 then
		AchievementController.instance:openAchievementGroupPreView(self.actId, actCfg.achievementGroup)
	end
end

function VersionActivity1_5EnterView:refreshSingleBgUI()
	gohelper.setActive(self.gobg1, self.showGroupIndex == 1)
	gohelper.setActive(self.gobg2, self.showGroupIndex == 2)
end

function VersionActivity1_5EnterView:onClickActivity1()
	Activity142Controller.instance:openMapView()
end

function VersionActivity1_5EnterView:onClickActivity2()
	BossRushController.instance:openMainView()
end

function VersionActivity1_5EnterView:onClickActivity3()
	SportsNewsController.instance:openSportsNewsMainView()
end

function VersionActivity1_5EnterView:onClickActivity4()
	VersionActivity1_5DungeonController.instance:openStoreView()
end

function VersionActivity1_5EnterView:onClickActivity5()
	VersionActivity1_5DungeonController.instance:openVersionActivityDungeonMapView()
end

function VersionActivity1_5EnterView:onClickActivity6()
	PeaceUluController.instance:openPeaceUluView()
end

function VersionActivity1_5EnterView:onClickActivity7()
	BossRushController.instance:openMainView()
end

function VersionActivity1_5EnterView:onClickActivity8()
	Activity104Controller.instance:openSeasonMainView()
end

function VersionActivity1_5EnterView:onClickActivity9()
	AiZiLaController.instance:openMapView()
end

function VersionActivity1_5EnterView:onClickActivity10()
	VersionActivity1_5DungeonController.instance:openStoreView()
end

function VersionActivity1_5EnterView:onClickActivity11()
	VersionActivity1_5DungeonController.instance:openVersionActivityDungeonMapView()
end

function VersionActivity1_5EnterView:singleBgUI()
	return
end

function VersionActivity1_5EnterView:refreshUI()
	VersionActivity1_5EnterView.super.refreshUI(self)
	self:refreshEnterViewTime()
	self:updateAchievementBtnVisible()
	self:refreshSeasonStore()
	self:refreshCurrency()
	self:refreshDungeonStoreTime()
end

function VersionActivity1_5EnterView:refreshEnterViewTime()
	self:refreshDurationTime()
	self:refreshRemainTime()
end

function VersionActivity1_5EnterView:refreshCurrency()
	local currencyMO = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.V1a5Dungeon)

	if currencyMO then
		if not currencyMO.quantity then
			local quantity = 0

			self.txtDungeonStoreNum1.text = quantity
			self.txtDungeonStoreNum2.text = quantity
		end
	end
end

function VersionActivity1_5EnterView:refreshDungeonStoreTime()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[VersionActivity1_5Enum.ActivityId.DungeonStore]
	local endTime = actInfoMo:getRealEndTimeStamp()
	local offsetSecond = endTime - ServerTime.now()

	if offsetSecond > TimeUtil.OneDaySecond then
		local day = Mathf.Floor(offsetSecond / TimeUtil.OneDaySecond)
		local timeStr = day .. "d"

		self.txtDungeonStoreRemainTime1.text = timeStr
		self.txtDungeonStoreRemainTime2.text = timeStr

		return
	end

	if offsetSecond > TimeUtil.OneHourSecond then
		local hour = Mathf.Floor(offsetSecond / TimeUtil.OneHourSecond)
		local timeStr = hour .. "h"

		self.txtDungeonStoreRemainTime1.text = timeStr
		self.txtDungeonStoreRemainTime2.text = timeStr

		return
	end

	self.txtDungeonStoreRemainTime1.text = "1h"
	self.txtDungeonStoreRemainTime2.text = "1h"
end

function VersionActivity1_5EnterView:refreshRemainTime()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[self.actId]
	local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()
	local day = Mathf.Floor(offsetSecond / TimeUtil.OneDaySecond)
	local hourSecond = offsetSecond % TimeUtil.OneDaySecond
	local hour = Mathf.Floor(hourSecond / TimeUtil.OneHourSecond)

	self._txtremaintime.text = string.format(luaLang("remain"), string.format("%s%s%s%s", day, luaLang("time_day"), hour, luaLang("time_hour2")))
end

function VersionActivity1_5EnterView:refreshDurationTime()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[self.actId]

	if self._txttime then
		self._txttime.text = actInfoMo:getStartTimeStr() .. " ~ " .. actInfoMo:getEndTimeStr()
	end
end

function VersionActivity1_5EnterView:everyMinuteCall()
	VersionActivity1_5EnterView.super.everyMinuteCall(self)
	self:refreshRemainTime()
	self:refreshDungeonStoreTime()
end

function VersionActivity1_5EnterView:onDestroyView()
	VersionActivity1_5EnterView.super.onDestroyView(self)
end

function VersionActivity1_5EnterView:onRefreshActivity8(activityItem)
	local status = ActivityHelper.getActivityStatus(activityItem.actId)
	local isNormal = status == ActivityEnum.ActivityStatus.Normal
	local goWeek = gohelper.findChild(activityItem.goNormal, "week")
	local goScore = gohelper.findChild(activityItem.goNormal, "score")

	gohelper.setActive(goWeek, isNormal and Activity104Model.instance:isEnterSpecial())
	gohelper.setActive(goScore, isNormal)

	if isNormal and Activity104Model.instance:tryGetActivityInfo(activityItem.actId, self.checkNeedRefreshUI, self) then
		local stage = Activity104Model.instance:getAct104CurStage()
		local stage7 = gohelper.findChildImage(activityItem.rootGo, "normal/score/stage7")

		gohelper.setActive(stage7, stage == 7)

		for i = 1, 7 do
			local image = gohelper.findChildImage(activityItem.rootGo, "normal/score/stage" .. i)

			UISpriteSetMgr.instance:setV1a5EnterViewSprite(image, i <= stage and "v1a5_enterview_scorefg" or "v1a5_enterview_scorebg", true)
		end
	end
end

function VersionActivity1_5EnterView:refreshSeasonStore()
	local actId = Activity104Model.instance:getCurSeasonId()
	local activityStatus = ActivityHelper.getActivityStatus(actId)

	if activityStatus == ActivityEnum.ActivityStatus.Normal then
		gohelper.setActive(self._btnseasonstore, false)

		return
	end

	local storeActId = Activity104Enum.SeasonStore[actId]
	local storeActivityStatus = ActivityHelper.getActivityStatus(storeActId)

	gohelper.setActive(self._btnseasonstore, storeActivityStatus == ActivityEnum.ActivityStatus.Normal)

	if storeActivityStatus ~= ActivityEnum.ActivityStatus.Normal then
		return
	end

	local currencyMO = CurrencyModel.instance:getCurrency(Activity104Enum.StoreUTTU[actId])

	if currencyMO then
		if not currencyMO.quantity then
			local quantity = 0

			self._txtseasonstorenum.text = GameUtil.numberDisplay(quantity)

			local actInfoMo = ActivityModel.instance:getActMO(storeActId)

			self._txtseasonstoretime.text = actInfoMo and actInfoMo:getRemainTimeStr2ByEndTime(true) or ""
		end
	end
end

function VersionActivity1_5EnterView:updateAchievementBtnVisible()
	local actCfg = ActivityConfig.instance:getActivityCo(self.actId)

	gohelper.setActive(self._btnachievementpreview.gameObject, actCfg and actCfg.achievementGroup ~= 0)
end

function VersionActivity1_5EnterView:getLockTextFunc1(activityItem, activityStatus)
	if activityStatus == ActivityEnum.ActivityStatus.NotUnlock then
		return self:getLockTextByOpenCo(activityItem.openId)
	end

	return self:getLockText(activityItem, activityStatus)
end

function VersionActivity1_5EnterView:getLockTextFunc9(activityItem, activityStatus)
	if activityStatus == ActivityEnum.ActivityStatus.NotUnlock then
		return self:getLockTextByOpenCo(activityItem.openId)
	end

	return self:getLockText(activityItem, activityStatus)
end

function VersionActivity1_5EnterView:getLockTextByOpenCo(openId)
	local openCo = lua_open.configDict[openId]
	local episodeCo = DungeonConfig.instance:getEpisodeCO(openCo.episodeId)
	local chapterIndex = DungeonConfig.instance:getChapterCO(episodeCo.chapterId).chapterIndex
	local episodeIndex = episodeCo.id % 100

	return string.format(luaLang("versionactivity1_3_hardlocktip"), string.format("%s-%s", chapterIndex, episodeIndex))
end

function VersionActivity1_5EnterView:onOpenViewFinish(viewName)
	VersionActivity1_5EnterView.super.onOpenViewFinish(self, viewName)

	if viewName == ViewName.VersionActivity1_5DungeonMapView then
		self:closeBgmLeadSinger()
	end
end

function VersionActivity1_5EnterView:onCloseViewFinish(viewName)
	VersionActivity1_5EnterView.super.onCloseViewFinish(self, viewName)

	if ViewHelper.instance:checkViewOnTheTop(self.viewName) then
		self:openBgmLeadSinger()
	end
end

function VersionActivity1_5EnterView:playBgm()
	self.switchGroupId = AudioMgr.instance:getIdFromString("music_vocal_filter")
	self.originalStateId = AudioMgr.instance:getIdFromString("original")
	self.accompanimentStateId = AudioMgr.instance:getIdFromString("accompaniment")

	self:openBgmLeadSinger()
end

function VersionActivity1_5EnterView:openBgmLeadSinger()
	AudioMgr.instance:setSwitch(self.switchGroupId, self.originalStateId)
end

function VersionActivity1_5EnterView:closeBgmLeadSinger()
	AudioMgr.instance:setSwitch(self.switchGroupId, self.accompanimentStateId)
end

return VersionActivity1_5EnterView
