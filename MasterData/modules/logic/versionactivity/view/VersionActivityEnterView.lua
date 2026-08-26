-- chunkname: @modules/logic/versionactivity/view/VersionActivityEnterView.lua

module("modules.logic.versionactivity.view.VersionActivityEnterView", package.seeall)

local VersionActivityEnterView = class("VersionActivityEnterView", VersionActivityEnterBaseView)

function VersionActivityEnterView:onInitView()
	VersionActivityEnterView.super.onInitView(self)

	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._btnstore = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_store")
	self._txtnum = gohelper.findChildText(self.viewGO, "entrance/#btn_store/#txt_num")
	self._txtremainday = gohelper.findChildText(self.viewGO, "logo/#txt_remaintime")
	self._txtremaindayprefix = gohelper.findChildText(self.viewGO, "logo/#txt_remaintime_prefix")
	self._txtremaindaysuffix = gohelper.findChildText(self.viewGO, "logo/#txt_remiantime_suffix")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivityEnterView:addEvents()
	VersionActivityEnterView.super.addEvents(self)
	self._btnstore:AddClickListener(self._btnstoreOnClick, self)
end

function VersionActivityEnterView:removeEvents()
	VersionActivityEnterView.super.removeEvents(self)
	self._btnstore:RemoveClickListener()
end

VersionActivityEnterView.SeasonAnchor = {
	Open = Vector2(-723.9, -228.9),
	NotOpen = Vector2(-660.9, 128.1)
}
VersionActivityEnterView.LeiMiTeBeiAnchor = {
	Normal = {
		Position = Vector2(-651, -133),
		Rotation = Vector3(0, 0, 0)
	},
	Expired = {
		Position = Vector2(-644, 85),
		Rotation = Vector3(0, 0, 31.65)
	}
}
VersionActivityEnterView.LeiMiTeBeiStoreAnchor = {
	Normal = {
		Position = Vector2(-788, -94),
		Rotation = Vector3(0, 0, 0)
	},
	Expired = {
		Position = Vector2(-772, 28),
		Rotation = Vector3(0, 0, 31.65)
	}
}

function VersionActivityEnterView:_btnstoreOnClick()
	local status, toastId, paramList = ActivityHelper.getActivityStatusAndToast(VersionActivityEnum.ActivityId.Act107)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		if toastId then
			GameFacade.showToastWithTableParam(toastId, paramList)
		end

		AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_closehouse)

		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_sign)
	VersionActivityController.instance:openLeiMiTeBeiStoreView()
end

function VersionActivityEnterView:_editableInitView()
	VersionActivityEnterView.super._editableInitView(self)
	self._simagebg:LoadImage(ResUrl.getVersionActivityIcon("full/bg"))
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.refreshLeiMiTeBeiCurrency, self)
end

function VersionActivityEnterView:onClickActivity1()
	VersionActivityDungeonController.instance:openVersionActivityDungeonMapView()
end

function VersionActivityEnterView:checkActivityCanClickFunc2(activityItem)
	local status = ActivityHelper.getActivityStatus(activityItem.actId)

	if status == ActivityEnum.ActivityStatus.NotOpen then
		local time = TimeUtil.timestampToTable(ActivityModel.instance:getActStartTime(activityItem.actId) / 1000)

		GameFacade.showToast(ToastEnum.SeasonUTTUNotOpen, time.month, time.day)
		AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_closehouse)

		return false
	end

	return self:defaultCheckActivityCanClick(activityItem)
end

function VersionActivityEnterView:onClickActivity2()
	Activity104Controller.instance:openSeasonMainView()
end

function VersionActivityEnterView:onClickActivity3()
	ViewMgr.instance:openView(ViewName.VersionActivityExchangeView)
end

function VersionActivityEnterView:onClickActivity4()
	Activity109ChessController.instance:openEntry(VersionActivityEnum.ActivityId.Act109)
end

function VersionActivityEnterView:onClickActivity5()
	PushBoxController.instance:enterPushBoxGame()
end

function VersionActivityEnterView:onClickActivity6()
	MeilanniController.instance:openMeilanniMainView({
		checkStory = true
	})
end

function VersionActivityEnterView:refreshUI()
	VersionActivityEnterView.super.refreshUI(self)

	local seasonActId = VersionActivityEnum.ActivityId.Act104
	local seasonActivityItem = self:getVersionActivityItem(seasonActId)
	local leiMiTeBeiItem = self:getVersionActivityItem(VersionActivityEnum.ActivityId.Act113)
	local seasonTr = seasonActivityItem.rootGo.transform
	local leiMiTeBeiTr = leiMiTeBeiItem.rootGo.transform
	local leiMiTeBeiStoreTr = self._btnstore.transform
	local activityStatus = ActivityHelper.getActivityStatus(seasonActId)
	local anchor, rotation

	if activityStatus == ActivityEnum.ActivityStatus.NotOpen then
		anchor = VersionActivityEnterView.SeasonAnchor.NotOpen

		recthelper.setAnchor(seasonTr, VersionActivityEnterView.SeasonAnchor.NotOpen.x, VersionActivityEnterView.SeasonAnchor.NotOpen.y)

		anchor = VersionActivityEnterView.LeiMiTeBeiAnchor.Normal.Position

		recthelper.setAnchor(leiMiTeBeiTr, VersionActivityEnterView.LeiMiTeBeiAnchor.Normal.Position.x, VersionActivityEnterView.LeiMiTeBeiAnchor.Normal.Position.y)

		rotation = VersionActivityEnterView.LeiMiTeBeiAnchor.Normal.Rotation

		transformhelper.setLocalRotation(leiMiTeBeiTr, VersionActivityEnterView.LeiMiTeBeiAnchor.Normal.Rotation.x, VersionActivityEnterView.LeiMiTeBeiAnchor.Normal.Rotation.y, VersionActivityEnterView.LeiMiTeBeiAnchor.Normal.Rotation.z)

		anchor = VersionActivityEnterView.LeiMiTeBeiStoreAnchor.Normal.Position

		recthelper.setAnchor(leiMiTeBeiStoreTr, VersionActivityEnterView.LeiMiTeBeiStoreAnchor.Normal.Position.x, VersionActivityEnterView.LeiMiTeBeiStoreAnchor.Normal.Position.y)

		rotation = VersionActivityEnterView.LeiMiTeBeiStoreAnchor.Normal.Rotation

		transformhelper.setLocalRotation(leiMiTeBeiStoreTr, VersionActivityEnterView.LeiMiTeBeiStoreAnchor.Normal.Rotation.x, VersionActivityEnterView.LeiMiTeBeiStoreAnchor.Normal.Rotation.y, VersionActivityEnterView.LeiMiTeBeiStoreAnchor.Normal.Rotation.z)
	else
		anchor = VersionActivityEnterView.SeasonAnchor.Open

		recthelper.setAnchor(seasonTr, VersionActivityEnterView.SeasonAnchor.Open.x, VersionActivityEnterView.SeasonAnchor.Open.y)

		anchor = VersionActivityEnterView.LeiMiTeBeiAnchor.Expired.Position

		recthelper.setAnchor(leiMiTeBeiTr, VersionActivityEnterView.LeiMiTeBeiAnchor.Expired.Position.x, VersionActivityEnterView.LeiMiTeBeiAnchor.Expired.Position.y)

		rotation = VersionActivityEnterView.LeiMiTeBeiAnchor.Expired.Rotation

		transformhelper.setLocalRotation(leiMiTeBeiTr, VersionActivityEnterView.LeiMiTeBeiAnchor.Expired.Rotation.x, VersionActivityEnterView.LeiMiTeBeiAnchor.Expired.Rotation.y, VersionActivityEnterView.LeiMiTeBeiAnchor.Expired.Rotation.z)
		recthelper.setAnchor(leiMiTeBeiStoreTr, VersionActivityEnterView.LeiMiTeBeiStoreAnchor.Expired.Position.x, VersionActivityEnterView.LeiMiTeBeiStoreAnchor.Expired.Position.y)
		transformhelper.setLocalRotation(leiMiTeBeiStoreTr, VersionActivityEnterView.LeiMiTeBeiStoreAnchor.Expired.Rotation.x, VersionActivityEnterView.LeiMiTeBeiStoreAnchor.Expired.Rotation.y, VersionActivityEnterView.LeiMiTeBeiStoreAnchor.Expired.Rotation.z)
	end

	local storeActivityStatus = ActivityHelper.getActivityStatus(VersionActivityEnum.ActivityId.Act107)

	gohelper.setActive(self._btnstore.gameObject, storeActivityStatus == ActivityEnum.ActivityStatus.Normal)
	self:refreshLeiMiTeBeiCurrency()
	self:refreshRemainTime()
end

function VersionActivityEnterView:refreshLeiMiTeBeiCurrency()
	local currencyId = ReactivityModel.instance:getActivityCurrencyId(self.actId)
	local currencyMO = CurrencyModel.instance:getCurrency(currencyId)

	if currencyMO then
		if not currencyMO.quantity then
			local quantity = 0

			self._txtnum.text = GameUtil.numberDisplay(quantity)
		end
	end
end

function VersionActivityEnterView:refreshRemainTime()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[self.actId]
	local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()
	local day = Mathf.Floor(offsetSecond / TimeUtil.OneDaySecond)
	local hourSecond = offsetSecond % TimeUtil.OneDaySecond
	local hour = Mathf.Floor(hourSecond / TimeUtil.OneHourSecond)

	self._txtremainday.text = string.format(luaLang("remain"), string.format("%s%s%s%s", day, luaLang("time_day"), hour, luaLang("time_hour2")))
end

function VersionActivityEnterView:refreshEnterViewTime()
	self:refreshRemainTime()
	self:onRefreshActivity1(self:getVersionActivityItem(VersionActivityEnum.ActivityId.Act113))
	self:onRefreshActivity2(self:getVersionActivityItem(VersionActivityEnum.ActivityId.Act104))
end

function VersionActivityEnterView:onRefreshActivity1(activityItem)
	local normalStatus = ActivityHelper.getActivityStatus(activityItem.actId)
	local gobg1 = gohelper.findChild(activityItem.rootGo, "normal/#go_bg1")

	gohelper.setActive(gobg1, normalStatus == ActivityEnum.ActivityStatus.Normal)

	if normalStatus == ActivityEnum.ActivityStatus.Normal then
		local actInfoMo = ActivityModel.instance:getActivityInfo()[activityItem.actId]
		local txtTime = gohelper.findChildText(activityItem.rootGo, "normal/#go_bg1/#txt_time")

		txtTime.text = string.format(luaLang("versionactivity_remain_day"), actInfoMo and actInfoMo:getRemainTimeStr())
	end
end

function VersionActivityEnterView:onRefreshActivity2(activityItem)
	local status = ActivityHelper.getActivityStatus(activityItem.actId)
	local isNormal = status == ActivityEnum.ActivityStatus.Normal
	local goNotOpen = gohelper.findChild(activityItem.goLockContainer, "notopen")
	local goLock = gohelper.findChild(activityItem.goLockContainer, "lock")

	gohelper.setActive(goNotOpen, status == ActivityEnum.ActivityStatus.NotOpen)
	gohelper.setActive(goLock, status ~= ActivityEnum.ActivityStatus.NotOpen)
	gohelper.setActive(activityItem.goNormal, status ~= ActivityEnum.ActivityStatus.NotOpen)

	local goWeek = gohelper.findChild(activityItem.goNormal, "week")
	local goScore = gohelper.findChild(activityItem.goNormal, "score")

	gohelper.setActive(goWeek, isNormal and Activity104Model.instance:isEnterSpecial())
	gohelper.setActive(goScore, isNormal)

	if isNormal then
		local stage = Activity104Model.instance:getAct104CurStage()
		local stage7 = gohelper.findChildImage(activityItem.rootGo, "normal/score/stage7")

		gohelper.setActive(stage7, stage == 7)

		for i = 1, 7 do
			local image = gohelper.findChildImage(activityItem.rootGo, "normal/score/stage" .. i)

			UISpriteSetMgr.instance:setVersionActivitySprite(image, i <= stage and "eye" or "slot", true)
		end
	end
end

function VersionActivityEnterView:beforePlayActUnlockAnimationActivity2(activityItem)
	gohelper.setActive(activityItem.goTime, true)
	gohelper.setActive(activityItem.goLockContainer, true)

	local txtLockGo = gohelper.findChild(activityItem.goLockContainer, "lock/bg")

	if txtLockGo then
		gohelper.setActive(txtLockGo, false)
	end

	local goSubLock = gohelper.findChild(activityItem.goLockContainer, "lock")

	gohelper.setActive(goSubLock, true)
end

function VersionActivityEnterView:everyMinuteCall()
	VersionActivityEnterView.super.everyMinuteCall(self)
	self:refreshEnterViewTime()
end

function VersionActivityEnterView:playBgm()
	return
end

function VersionActivityEnterView:stopBgm()
	return
end

function VersionActivityEnterView:onDestroyView()
	VersionActivityEnterView.super.onDestroyView(self)
	self._simagebg:UnLoadImage()
end

return VersionActivityEnterView
