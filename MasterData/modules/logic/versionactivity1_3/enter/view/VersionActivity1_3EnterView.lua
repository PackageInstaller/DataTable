-- chunkname: @modules/logic/versionactivity1_3/enter/view/VersionActivity1_3EnterView.lua

module("modules.logic.versionactivity1_3.enter.view.VersionActivity1_3EnterView", package.seeall)

local VersionActivity1_3EnterView = class("VersionActivity1_3EnterView", VersionActivityEnterBaseView)

function VersionActivity1_3EnterView:onInitView()
	VersionActivity1_3EnterView.super.onInitView(self)

	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._btnstore = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_store")
	self._txtnum = gohelper.findChildText(self.viewGO, "entrance/#btn_store/#txt_num")
	self._gostoretime = gohelper.findChild(self.viewGO, "entrance/#btn_store/timebg")
	self._gostorelock = gohelper.findChild(self.viewGO, "entrance/#btn_store/#go_Lock")
	self._txtstoretime = gohelper.findChildText(self.viewGO, "entrance/#btn_store/timebg/#txt_time")
	self._txtremainday = gohelper.findChildText(self.viewGO, "logo/Time/#txt_remaintime")
	self._txttime = gohelper.findChildText(self.viewGO, "logo/Time/#txt_time")
	self._btnseasonstore = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_seasonstore")
	self._txtseasonstorenum = gohelper.findChildText(self.viewGO, "entrance/#btn_seasonstore/#txt_num")
	self._txtseasonstoretime = gohelper.findChildText(self.viewGO, "entrance/#btn_seasonstore/timebg/#txt_time")
	self._simagefg = gohelper.findChildSingleImage(self.viewGO, "img/#simage_fg")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_3EnterView:addEvents()
	VersionActivity1_3EnterView.super.addEvents(self)
	self._btnstore:AddClickListener(self._btnstoreOnClick, self)
	self._btnseasonstore:AddClickListener(self._btnseasonstoreOnClick, self)
end

function VersionActivity1_3EnterView:removeEvents()
	VersionActivity1_3EnterView.super.removeEvents(self)
	self._btnstore:RemoveClickListener()
	self._btnseasonstore:RemoveClickListener()
end

VersionActivity1_3EnterView.SeasonAnchor = {
	Open = Vector2(-723.9, -228.9),
	NotOpen = Vector2(-660.9, 128.1)
}
VersionActivity1_3EnterView.LeiMiTeBeiAnchor = {
	Normal = {
		Position = Vector2(-651, -133),
		Rotation = Vector3(0, 0, 0)
	},
	Expired = {
		Position = Vector2(-644, 85),
		Rotation = Vector3(0, 0, 31.65)
	}
}
VersionActivity1_3EnterView.LeiMiTeBeiStoreAnchor = {
	Normal = {
		Position = Vector2(-788, -94),
		Rotation = Vector3(0, 0, 0)
	},
	Expired = {
		Position = Vector2(-772, 28),
		Rotation = Vector3(0, 0, 31.65)
	}
}

function VersionActivity1_3EnterView:_btnseasonstoreOnClick()
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

function VersionActivity1_3EnterView:_btnstoreOnClick()
	local status, toastId, toastParam = ActivityHelper.getActivityStatusAndToast(VersionActivity1_3Enum.ActivityId.DungeonStore)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		if toastId then
			GameFacade.showToast(toastId, toastParam)
		end

		AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_closehouse)

		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_sign)
	VersionActivity1_3EnterController.instance:openStoreView()
end

function VersionActivity1_3EnterView:_editableInitView()
	VersionActivity1_3EnterView.super._editableInitView(self)
	self._simagebg:LoadImage(ResUrl.getActivity1_3EnterIcon("v1a3_enterview_fullbg"))
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.refreshLeiMiTeBeiCurrency, self)
	self._simagefg:LoadImage(ResUrl.getActivity1_3EnterIcon("v1a3_enterview_mainfg"))
end

function VersionActivity1_3EnterView:checkActivityCanClickFunc3(activityItem)
	local status = ActivityHelper.getActivityStatus(activityItem.actId)

	if status == ActivityEnum.ActivityStatus.NotOpen then
		local time = TimeUtil.timestampToTable(ActivityModel.instance:getActStartTime(activityItem.actId) / 1000)

		GameFacade.showToast(ToastEnum.SeasonUTTUNotOpen, time.month, time.day)
		AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_closehouse)

		return false
	end

	return self:defaultCheckActivityCanClick(activityItem)
end

function VersionActivity1_3EnterView:onClickActivity4()
	VersionActivity1_3DungeonController.instance:openVersionActivityDungeonMapView()
end

function VersionActivity1_3EnterView:onClickActivity3()
	Activity104Controller.instance:openSeasonMainView()
end

function VersionActivity1_3EnterView:onClickActivity5()
	ArmPuzzlePipeController.instance:openMainView()
end

function VersionActivity1_3EnterView:onClickActivity1()
	JiaLaBoNaController.instance:openMapView()
end

function VersionActivity1_3EnterView:onClickActivity2()
	Activity1_3_119Controller.instance:openView()
end

function VersionActivity1_3EnterView:onClickActivity6()
	Activity1_3ChessController.instance:openMapView()
end

function VersionActivity1_3EnterView:refreshUI()
	VersionActivity1_3EnterView.super.refreshUI(self)

	local storeActivityStatus = ActivityHelper.getActivityStatus(VersionActivity1_3Enum.ActivityId.DungeonStore)

	gohelper.setActive(self._btnstore.gameObject, storeActivityStatus == ActivityEnum.ActivityStatus.Normal)
	self:refreshLeiMiTeBeiCurrency()
	self:refreshRemainTime()
end

function VersionActivity1_3EnterView:refreshSeasonStore()
	local actId = Activity104Model.instance:getCurSeasonId()
	local activityStatus = ActivityHelper.getActivityStatus(actId)

	if activityStatus == ActivityEnum.ActivityStatus.Normal then
		gohelper.setActive(self._btnseasonstore.gameObject, false)

		return
	end

	local storeActId = Activity104Enum.SeasonStore[actId]
	local storeActivityStatus = ActivityHelper.getActivityStatus(storeActId)

	gohelper.setActive(self._btnseasonstore.gameObject, storeActivityStatus == ActivityEnum.ActivityStatus.Normal)

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

function VersionActivity1_3EnterView:refreshLeiMiTeBeiCurrency()
	local currencyMO = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.Planet)

	if currencyMO then
		if not currencyMO.quantity then
			local quantity = 0

			self._txtnum.text = GameUtil.numberDisplay(quantity)
		end
	end
end

function VersionActivity1_3EnterView:refreshRemainTime()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[self.actId]
	local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()
	local day = Mathf.Floor(offsetSecond / TimeUtil.OneDaySecond)
	local hourSecond = offsetSecond % TimeUtil.OneDaySecond
	local hour = Mathf.Floor(hourSecond / TimeUtil.OneHourSecond)

	self._txtremainday.text = string.format(luaLang("remain"), string.format("%s%s%s%s", day, luaLang("time_day"), hour, luaLang("time_hour2")))

	self:_refreshStore()
	self:refreshSeasonStore()
end

function VersionActivity1_3EnterView:refreshEnterViewTime()
	self:refreshRemainTime()
	self:onRefreshActivity4(self:getVersionActivityItem(VersionActivity1_3Enum.ActivityId.Dungeon))
	self:onRefreshActivity3(self:getVersionActivityItem(VersionActivity1_3Enum.ActivityId.Season))
end

function VersionActivity1_3EnterView:onRefreshActivity4(activityItem)
	local normalStatus = ActivityHelper.getActivityStatus(activityItem.actId)
	local isNormalStatus = normalStatus == ActivityEnum.ActivityStatus.Normal
	local gobg1 = gohelper.findChild(activityItem.rootGo, "normal/#go_bg1")

	gohelper.setActive(gobg1, isNormalStatus)

	if isNormalStatus then
		local actInfoMo = ActivityModel.instance:getActivityInfo()[activityItem.actId]
		local txtTime = gohelper.findChildText(activityItem.rootGo, "normal/#go_bg1/#txt_time")

		txtTime.text = string.format(luaLang("versionactivity_remain_day"), actInfoMo and actInfoMo:getRemainTimeStr())
	end
end

function VersionActivity1_3EnterView:_refreshStore()
	local actId = VersionActivity1_3Enum.ActivityId.DungeonStore
	local normalStatus = ActivityHelper.getActivityStatus(actId)
	local isNormalStatus = normalStatus == ActivityEnum.ActivityStatus.Normal
	local actInfoMo = ActivityModel.instance:getActivityInfo()[actId]

	self._txtstoretime.text = actInfoMo and actInfoMo:getRemainTimeStr2ByEndTime(true) or ""

	gohelper.setActive(self._gostoretime, isNormalStatus)

	if not isNormalStatus then
		gohelper.setActive(self._gostorelock, true)
	end
end

function VersionActivity1_3EnterView:onRefreshActivity3(activityItem)
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

			UISpriteSetMgr.instance:setV1a3EnterViewSprite(image, i <= stage and "v1a3_enterview_scorefg" or "v1a3_enterview_scorebg", true)
		end
	end
end

function VersionActivity1_3EnterView:beforePlayActUnlockAnimationActivity2(activityItem)
	gohelper.setActive(activityItem.goTime, true)
	gohelper.setActive(activityItem.goLockContainer, true)

	local txtLockGo = gohelper.findChild(activityItem.goLockContainer, "lock/bg")

	if txtLockGo then
		gohelper.setActive(txtLockGo, false)
	end

	local goSubLock = gohelper.findChild(activityItem.goLockContainer, "lock")

	gohelper.setActive(goSubLock, true)
end

function VersionActivity1_3EnterView:everyMinuteCall()
	VersionActivity1_3EnterView.super.everyMinuteCall(self)
	self:refreshEnterViewTime()
end

function VersionActivity1_3EnterView:playBgm()
	return
end

function VersionActivity1_3EnterView:stopBgm()
	return
end

function VersionActivity1_3EnterView:onDestroyView()
	VersionActivity1_3EnterView.super.onDestroyView(self)
	self._simagebg:UnLoadImage()
	self._simagefg:UnLoadImage()
end

return VersionActivity1_3EnterView
