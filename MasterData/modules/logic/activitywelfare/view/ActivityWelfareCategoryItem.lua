-- chunkname: @modules/logic/activitywelfare/view/ActivityWelfareCategoryItem.lua

module("modules.logic.activitywelfare.view.ActivityWelfareCategoryItem", package.seeall)

local ActivityWelfareCategoryItem = class("ActivityWelfareCategoryItem", ListScrollCell)

function ActivityWelfareCategoryItem:init(go)
	self.go = go
	self._goselect = gohelper.findChild(go, "beselected")
	self._gounselect = gohelper.findChild(go, "noselected")
	self._txtnamecn = gohelper.findChildText(go, "beselected/activitynamecn")
	self._txtnameen = gohelper.findChildText(go, "beselected/activitynamecn/activitynameen")
	self._txtunselectnamecn = gohelper.findChildText(go, "noselected/noactivitynamecn")
	self._txtunselectnameen = gohelper.findChildText(go, "noselected/noactivitynamecn/noactivitynameen")
	self._goreddot = gohelper.findChild(go, "#go_reddot")
	self._itemClick = gohelper.getClickWithAudio(self.go)
	self._anim = self.go:GetComponent(typeof(UnityEngine.Animator))
	self._openAnimTime = 0.43
	self._gonewwelfare = gohelper.findChild(go, "#go_newwelfare")
	self._goselectwelfare = gohelper.findChild(go, "#go_newwelfare/selecticon")

	self:playEnterAnim()
end

function ActivityWelfareCategoryItem:addEventListeners()
	self.addEventCb(self, ActivityController.instance, ActivityEvent.SwitchWelfareActivity, self.refreshSelect, self)
	self._itemClick:AddClickListener(self._onItemClick, self)
end

function ActivityWelfareCategoryItem:removeEventListeners()
	self._itemClick:RemoveClickListener()
end

function ActivityWelfareCategoryItem:_onItemClick()
	if self._selected then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_Activity_switch)

	if self._mo.id == ActivityEnum.Activity.StoryShow or self._mo.id == ActivityEnum.Activity.ClassShow then
		ActivityBeginnerController.instance:setFirstEnter(self._mo.id)
		self.redDot:refreshDot()
	end

	ActivityModel.instance:setTargetActivityCategoryId(self._mo.id)
	ActivityController.instance:dispatchEvent(ActivityEvent.SwitchWelfareActivity)
end

function ActivityWelfareCategoryItem:onUpdateMO(mo)
	self._mo = mo

	self:_refreshItem()

	if Time.realtimeSinceStartup - ActivityWelfareListModel.instance.openViewTime > self._openAnimTime then
		self._anim:Play(UIAnimationName.Idle, 0, 1)
	end
end

function ActivityWelfareCategoryItem:_refreshItem()
	local dotId

	if self._mo.type == ActivityEnum.ActivityType.Welfare then
		dotId = ActivityConfig.instance:getActivityCenterCo(ActivityEnum.ActivityType.Welfare).reddotid
		self.redDot = (self._mo.id == ActivityEnum.Activity.StoryShow or self._mo.id == ActivityEnum.Activity.ClassShow) and RedDotController.instance:addRedDot(self._goreddot, dotId, self._mo.id, self.checkActivityShowFirstEnter, self) or RedDotController.instance:addRedDot(self._goreddot, dotId, self._mo.id)
	end

	local co = ActivityConfig.instance:getActivityCo(self._mo.id)

	self._txtnamecn.text = co.name
	self._txtnameen.text = co.nameEn
	self._txtunselectnamecn.text = co.name
	self._txtunselectnameen.text = co.nameEn

	self:refreshSelect()
end

function ActivityWelfareCategoryItem:refreshSelect()
	self._selected = self._mo.id == ActivityModel.instance:getTargetActivityCategoryId(ActivityEnum.ActivityType.Welfare)

	local isNewwelfare = false

	gohelper.setActive(self._gonewwelfare, isNewwelfare)
	gohelper.setActive(self._goselectwelfare, isNewwelfare and self._selected)
	gohelper.setActive(self._goselect, not isNewwelfare and self._selected)
	gohelper.setActive(self._gounselect, not isNewwelfare and not self._selected)
end

function ActivityWelfareCategoryItem:checkActivityShowFirstEnter(redDotIcon)
	redDotIcon:defaultRefreshDot()

	if not redDotIcon.show then
		redDotIcon.show = ActivityBeginnerController.instance:checkFirstEnter(self._mo.id)

		redDotIcon:showRedDot(RedDotEnum.Style.Normal)
	end
end

function ActivityWelfareCategoryItem:playEnterAnim()
	local openAnimProgress = Mathf.Clamp01((Time.realtimeSinceStartup - ActivityWelfareListModel.instance.openViewTime) / self._openAnimTime)

	self._anim:Play(UIAnimationName.Open, 0, openAnimProgress)
end

function ActivityWelfareCategoryItem:onDestroy()
	return
end

return ActivityWelfareCategoryItem
