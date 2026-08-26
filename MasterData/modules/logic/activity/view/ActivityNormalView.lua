-- chunkname: @modules/logic/activity/view/ActivityNormalView.lua

module("modules.logic.activity.view.ActivityNormalView", package.seeall)

local ActivityNormalView = class("ActivityNormalView", BaseView)

function ActivityNormalView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._gosubview = gohelper.findChild(self.viewGO, "#go_subview")
	self._scrollactivitylist = gohelper.findChildScrollRect(self.viewGO, "#scroll_activitylist")
	self._gorule = gohelper.findChild(self.viewGO, "#go_rule")
	self._scrollruledesc = gohelper.findChildScrollRect(self.viewGO, "#go_rule/#scroll_ruledesc")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ActivityNormalView:addEvents()
	return
end

function ActivityNormalView:removeEvents()
	return
end

function ActivityNormalView:_editableInitView()
	self._viewName = nil
end

local activitySubViewDict = {}

function ActivityNormalView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Activity_open)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self._refreshView, self)
	self:_refreshView()
	NavigateMgr.instance:addEscape(ViewName.ActivityNormalView, self._btncloseOnClick, self)
end

function ActivityNormalView:_refreshView()
	local actCo = ActivityModel.instance:getCenterActivities(ActivityEnum.ActivityType.Normal)

	if not actCo or not next(actCo) then
		self:closeThis()
	end

	local data = {}

	for _, v in pairs(actCo) do
		local o = {}

		o.id = v
		o.co = ActivityConfig.instance:getActivityCo(v)
		o.type = ActivityEnum.ActivityType.Normal

		table.insert(data, o)
	end

	ActivityNormalCategoryListModel.instance:setCategoryList(data)
	self:_openSubView()
end

function ActivityNormalView:_openSubView()
	if ViewMgr.instance:isOpen(ViewName.ActivityTipView) then
		ViewMgr.instance:closeView(ViewName.ActivityTipView, true)
	end

	if self._viewName then
		ViewMgr.instance:closeView(self._viewName, true)
	end

	local actId = ActivityModel.instance:getTargetActivityCategoryId(ActivityEnum.ActivityType.Normal)

	self._viewName = activitySubViewDict[actId]

	if not self._viewName then
		return
	end

	local bg = ActivityConfig.instance:getActivityCo(actId).banner

	if not bg or bg == "" then
		gohelper.setActive(self._simagebg.gameObject, false)
	else
		gohelper.setActive(self._simagebg.gameObject, true)
		self._simagebg:LoadImage(ResUrl.getActivityBg(bg))
	end

	ViewMgr.instance:openView(self._viewName, self._gosubview, true)
end

function ActivityNormalView:closeSubView()
	if self._viewName then
		ViewMgr.instance:closeView(self._viewName, true)

		self._viewName = nil
	end
end

function ActivityNormalView:onClose()
	ActivityModel.instance:setTargetActivityCategoryId(0)
	self:closeSubView()
	self.removeEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self._refreshView, self)
end

function ActivityNormalView:onDestroyView()
	return
end

return ActivityNormalView
