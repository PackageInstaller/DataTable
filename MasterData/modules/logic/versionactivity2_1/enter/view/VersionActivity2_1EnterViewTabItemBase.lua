-- chunkname: @modules/logic/versionactivity2_1/enter/view/VersionActivity2_1EnterViewTabItemBase.lua

module("modules.logic.versionactivity2_1.enter.view.VersionActivity2_1EnterViewTabItemBase", package.seeall)

local VersionActivity2_1EnterViewTabItemBase = class("VersionActivity2_1EnterViewTabItemBase", VersionActivityEnterViewBaseTabItem)

function VersionActivity2_1EnterViewTabItemBase:_editableInitView()
	self.goSelected = gohelper.findChild(self.go, "#go_select")
	self.imageSelectTabIcon = gohelper.findChildImage(self.go, "#go_select/#image_tabicon")
	self.goUnselected = gohelper.findChild(self.go, "#go_unselect")
	self.imageUnSelectTabIcon = gohelper.findChildImage(self.go, "#go_unselect/#image_tabicon")
	self.goTag = gohelper.findChild(self.go, "#go_tag")
	self.goTagNewAct = gohelper.findChild(self.go, "#go_tag/#go_newact")
	self.goTagNewLevel = gohelper.findChild(self.go, "#go_tag/#go_newlevel")
	self.goTagTime = gohelper.findChild(self.go, "#go_tag/#go_time")
	self.goTagLock = gohelper.findChild(self.go, "#go_tag/#go_lock")
	self.txtTime = gohelper.findChildText(self.goTagTime, "bg/#txt_time")
	self.txtLock = gohelper.findChildText(self.goTagLock, "bg/#txt_lock")
	self.goRedDot = gohelper.findChild(self.go, "#go_reddot")
	self.animator = self.go:GetComponent(gohelper.Type_Animator)
end

function VersionActivity2_1EnterViewTabItemBase:afterSetData()
	if self.actId then
		self.activityCo = ActivityConfig.instance:getActivityCo(self.actId)
	end

	if not self.activityCo then
		gohelper.setActive(self.go, false)
		logError("VersionActivity2_1EnterViewTabItemBase.afterSetData error, no act config, actId:%s", self.actId)

		return
	end

	local iconCoArr = string.split(self.activityCo.tabBgPath, "#")
	local selectBg = iconCoArr[1]

	if not string.nilorempty(selectBg) then
		UISpriteSetMgr.instance:setV2a1MainActivitySprite(self.imageSelectTabIcon, selectBg)
	end

	local unselectBg = iconCoArr[2]

	if not string.nilorempty(unselectBg) then
		UISpriteSetMgr.instance:setV2a1MainActivitySprite(self.imageUnSelectTabIcon, unselectBg)
	end

	self.redDotIcon = RedDotController.instance:addRedDot(self.goRedDot, self.activityCo.redDotId, self.redDotUid)
end

function VersionActivity2_1EnterViewTabItemBase:childRefreshSelect()
	gohelper.setActive(self.goSelected, self.isSelect)
	gohelper.setActive(self.goUnselected, not self.isSelect)
end

function VersionActivity2_1EnterViewTabItemBase:childRefreshUI()
	local status = ActivityHelper.getActivityStatus(self.actId)

	gohelper.setActive(self.goRedDot, status == ActivityEnum.ActivityStatus.Normal)
end

function VersionActivity2_1EnterViewTabItemBase:refreshTag()
	self:clearTag()

	if not self.actId then
		return
	end

	local status = ActivityHelper.getActivityStatus(self.actId)

	if status == ActivityEnum.ActivityStatus.Normal then
		self:refreshNormalTag()
	elseif status == ActivityEnum.ActivityStatus.NotUnlock then
		self:refreshNotUnlockTag()
	else
		self:refreshLockTag()
	end
end

function VersionActivity2_1EnterViewTabItemBase:clearTag()
	gohelper.setActive(self.goTagNewAct, false)
	gohelper.setActive(self.goTagNewLevel, false)
	gohelper.setActive(self.goTagTime, false)
	gohelper.setActive(self.goTagLock, false)
end

function VersionActivity2_1EnterViewTabItemBase:refreshNormalTag()
	if not ActivityEnterMgr.instance:isEnteredActivity(self.actId) then
		gohelper.setActive(self.goTagNewAct, true)

		return
	end

	local actInfoMo = ActivityModel.instance:getActivityInfo()[self.actId]

	if actInfoMo and actInfoMo:isNewStageOpen() then
		gohelper.setActive(self.goTagNewLevel, true)

		return
	end

	local isShowRemainTime = VersionActivity2_1EnterHelper.GetIsShowTabRemainTime(self.actId)

	if isShowRemainTime and actInfoMo then
		local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

		if offsetSecond > VersionActivity2_1Enum.MaxShowTimeOffset then
			return
		end

		gohelper.setActive(self.goTagTime, true)

		self.txtTime.text = actInfoMo:getRemainTimeStr2ByEndTime()
	end
end

function VersionActivity2_1EnterViewTabItemBase:refreshNotUnlockTag()
	gohelper.setActive(self.goTagLock, false)

	if not ActivityEnterMgr.instance:isEnteredActivity(self.actId) then
		gohelper.setActive(self.goTagNewAct, true)
	end
end

function VersionActivity2_1EnterViewTabItemBase:refreshLockTag()
	gohelper.setActive(self.goTagLock, true)

	local status = ActivityHelper.getActivityStatus(self.actId)

	if status == ActivityEnum.ActivityStatus.NotOpen then
		local actInfoMo = ActivityModel.instance:getActivityInfo()[self.actId]

		self.txtLock.text = actInfoMo:getRemainTimeStr2ByOpenTime()
	else
		gohelper.setActive(self.goTagLock, false)
	end
end

function VersionActivity2_1EnterViewTabItemBase:isShowRedDot()
	return self.redDotIcon and self.redDotIcon.show
end

return VersionActivity2_1EnterViewTabItemBase
