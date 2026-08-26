-- chunkname: @modules/versionactivitybase/enterview/view/VersionActivityEnterViewTabItem.lua

module("modules.versionactivitybase.enterview.view.VersionActivityEnterViewTabItem", package.seeall)

local VersionActivityEnterViewTabItem = class("VersionActivityEnterViewTabItem", UserDataDispose)
local ShowActTagEnum = VersionActivityEnterViewTabEnum.ActTabFlag

VersionActivityEnterViewTabItem.activityRemainTimeColor = "#9DD589"

function VersionActivityEnterViewTabItem:init(index, actId, go)
	self.index = index
	self.actId = actId
	self.rootGo = go
	self.go_selected = gohelper.findChild(self.rootGo, "#go_select")
	self.go_unselected = gohelper.findChild(self.rootGo, "#go_normal")
	self.activityNameTexts = self:getUserDataTb_()
	self.activityNameTexts.select = gohelper.findChildText(self.go_selected, "#txt_name")
	self.activityNameTexts.normal = gohelper.findChildText(self.go_unselected, "#txt_name")
	self.txtLockGo = gohelper.findChild(go, "lockContainer/lock")
	self.txtLock = gohelper.findChildText(go, "lockContainer/lock/txt_lock")
	self.redPoints = self:getUserDataTb_()
	self.redPoints.select = gohelper.findChild(self.go_selected, "#image_reddot")
	self.redPoints.normal = gohelper.findChild(self.go_unselected, "#image_reddot")
	self.newActivityFlags = self:getUserDataTb_()
	self.newActivityFlags.select = gohelper.findChild(self.go_selected, "#go_newact")
	self.newActivityFlags.normal = gohelper.findChild(self.go_unselected, "#go_newact")
	self.newEpisodeFlags = self:getUserDataTb_()
	self.newEpisodeFlags.select = gohelper.findChild(self.go_selected, "#go_newlevel")
	self.newEpisodeFlags.normal = gohelper.findChild(self.go_unselected, "#go_newlevel")
	self.rewardunlock = self:getUserDataTb_()
	self.rewardunlock.select = gohelper.findChild(self.go_selected, "#go_rewardunlock")
	self.rewardunlock.normal = gohelper.findChild(self.go_unselected, "#go_rewardunlock")
	self.timeObjs = self:getUserDataTb_()
	self.timeObjs.goTime = self:getUserDataTb_()
	self.timeObjs.goTime.select = gohelper.findChild(self.go_selected, "#go_time")
	self.timeObjs.goTime.normal = gohelper.findChild(self.go_unselected, "#go_time")
	self.timeObjs.txtTime = self:getUserDataTb_()
	self.timeObjs.txtTime.select = gohelper.findChildText(self.go_selected, "#go_time/bg/#txt_timelimit")
	self.timeObjs.txtTime.normal = gohelper.findChildText(self.go_unselected, "#go_time/bg/#txt_timelimit")
	self.timeObjs.timeIcon = self:getUserDataTb_()
	self.timeObjs.timeIcon.select = gohelper.findChildImage(self.go_selected, "#go_time/bg/#txt_timelimit/#image_timeicon")
	self.timeObjs.timeIcon.normal = gohelper.findChildImage(self.go_unselected, "#go_time/bg/#txt_timelimit/#image_timeicon")
	self.imageIcons = self:getUserDataTb_()
	self.imageIcons.select = gohelper.findChildImage(self.go_selected, "#simage_icon_select")
	self.imageIcons.normal = gohelper.findChildImage(self.go_unselected, "#simage_icon_normal")

	local btnGO = gohelper.findChild(self.rootGo, "#btn_self")

	self.click = SLFramework.UGUI.ButtonWrap.Get(btnGO)
	self.redPointTagAnimator = self.goRedPointTag and self.goRedPointTag:GetComponent(typeof(UnityEngine.Animator))

	local activityCo = ActivityConfig.instance:getActivityCo(actId)

	self.openId = activityCo and activityCo.openId
	self.redDotId = activityCo and activityCo.redDotId
	self.redDotUid = 0
	self._redDotIconSelect = nil
	self._redDotIconNormal = nil
end

function VersionActivityEnterViewTabItem:setClickFunc(clickFunc, callObj)
	self.click:AddClickListener(clickFunc, callObj, self)
end

function VersionActivityEnterViewTabItem:setShowRemainDayToggle(show, showDay)
	self._showOpenRemainDayThreshold = showDay
	self._showOpenRemainDay = show
end

function VersionActivityEnterViewTabItem:onClick()
	return
end

function VersionActivityEnterViewTabItem:refreshSelectState(select)
	gohelper.setActive(self.go_selected, select)
	gohelper.setActive(self.go_unselected, not select)
end

function VersionActivityEnterViewTabItem:refreshNameText()
	if self.activityNameTexts then
		local actInfoMo = ActivityModel.instance:getActMO(self.actId)
		local str = actInfoMo.config.tabName

		self.activityNameTexts.select.text = str
		self.activityNameTexts.normal.text = str
	end
end

function VersionActivityEnterViewTabItem:addRedDot()
	if self._redDotIconNormal ~= nil then
		return
	end

	local activityStatus = ActivityHelper.getActivityStatus(self.actId)
	local isNormalStatus = activityStatus == ActivityEnum.ActivityStatus.Normal

	if isNormalStatus and self.redDotId and self.redDotId ~= 0 then
		self._redDotIconSelect = RedDotController.instance:addRedDot(self.redPoints.select, self.redDotId, self.redDotUid)
		self._redDotIconNormal = RedDotController.instance:addRedDot(self.redPoints.normal, self.redDotId, self.redDotUid)
	end
end

function VersionActivityEnterViewTabItem:refreshActivityItemTag()
	local activityStatus = ActivityHelper.getActivityStatus(self.actId)
	local isOpenStatus = activityStatus == ActivityEnum.ActivityStatus.Normal or activityStatus == ActivityEnum.ActivityStatus.NotUnlock

	gohelper.setActive(self.newActivityFlags.select, false)
	gohelper.setActive(self.newActivityFlags.normal, false)
	gohelper.setActive(self.newEpisodeFlags.select, false)
	gohelper.setActive(self.newEpisodeFlags.normal, false)

	self.showTag = nil

	if isOpenStatus then
		local actInfoMo = ActivityModel.instance:getActMO(self.actId)
		local isShowNewAct = not ActivityEnterMgr.instance:isEnteredActivity(self.actId)

		if isShowNewAct then
			self.showTag = ShowActTagEnum.ShowNewAct
		elseif actInfoMo:isNewStageOpen() then
			self.showTag = ShowActTagEnum.ShowNewStage
		end

		if self.actId == VersionActivity1_6Enum.ActivityId.Cachot then
			local rewardstageunlock = V1a6_CachotProgressListModel.instance:checkRewardStageChange()

			gohelper.setActive(self.rewardunlock.select, rewardstageunlock and not isShowNewAct)
			gohelper.setActive(self.rewardunlock.normal, rewardstageunlock and not isShowNewAct)
		end
	end
end

function VersionActivityEnterViewTabItem:refreshTimeInfo()
	if self.showTag == ShowActTagEnum.ShowNewAct or self.showTag == ShowActTagEnum.ShowNewStage then
		self:_setItemObjActive(self.timeObjs.goTime, false)

		return
	end

	local activityStatus = ActivityHelper.getActivityStatus(self.actId)
	local iconColor = "#FFFFFF"
	local txtStr = ""
	local actInfoMo = ActivityModel.instance:getActMO(self.actId)

	if (activityStatus == ActivityEnum.ActivityStatus.Normal or activityStatus == ActivityEnum.ActivityStatus.NotUnlock) and self._showOpenRemainDay then
		local remainDayNum = actInfoMo:getRemainDay()

		if remainDayNum < self._showOpenRemainDayThreshold then
			self:_setItemObjActive(self.timeObjs.goTime, true)

			iconColor = VersionActivityEnterViewTabItem.activityRemainTimeColor
			txtStr = actInfoMo:getRemainTimeStr2ByEndTime()
			self.timeObjs.txtTime.select.text = txtStr
			self.timeObjs.txtTime.normal.text = txtStr

			SLFramework.UGUI.GuiHelper.SetColor(self.timeObjs.timeIcon.select, iconColor)
			SLFramework.UGUI.GuiHelper.SetColor(self.timeObjs.timeIcon.normal, iconColor)
		else
			self:_setItemObjActive(self.timeObjs.goTime, false)
		end
	elseif activityStatus == ActivityEnum.ActivityStatus.NotOpen then
		local openDayNum = actInfoMo:getRemainOpeningDay()

		self:_setItemObjActive(self.timeObjs.goTime, true)

		txtStr = actInfoMo:getRemainTimeStr2ByOpenTime()
		self.timeObjs.txtTime.select.text = txtStr
		self.timeObjs.txtTime.normal.text = txtStr

		SLFramework.UGUI.GuiHelper.SetColor(self.timeObjs.timeIcon.select, iconColor)
		SLFramework.UGUI.GuiHelper.SetColor(self.timeObjs.timeIcon.normal, iconColor)
	else
		self:_setItemObjActive(self.timeObjs.goTime, false)
	end
end

function VersionActivityEnterViewTabItem:_setItemObjActive(objList, active)
	for _, obj in pairs(objList) do
		gohelper.setActive(obj.gameObject, active)
	end
end

return VersionActivityEnterViewTabItem
