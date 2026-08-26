-- chunkname: @modules/logic/activitywelfare/view/ActivityWelfareView.lua

module("modules.logic.activitywelfare.view.ActivityWelfareView", package.seeall)

local ActivityWelfareView = class("ActivityWelfareView", BaseView)

function ActivityWelfareView:onInitView()
	self._gocategory = gohelper.findChild(self.viewGO, "#go_category")
	self._scrollitem = gohelper.findChildScrollRect(self.viewGO, "#go_category/#scroll_categoryitem")
	self._gosubview = gohelper.findChild(self.viewGO, "#go_subview")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ActivityWelfareView:addEvents()
	return
end

function ActivityWelfareView:removeEvents()
	return
end

function ActivityWelfareView:_editableInitView()
	return
end

local activitySubViewDict = {
	[ActivityEnum.Activity.StoryShow] = ViewName.ActivityStoryShowView,
	[ActivityEnum.Activity.ClassShow] = ViewName.ActivityClassShowView
}

function ActivityWelfareView:onUpdateParam()
	return
end

function ActivityWelfareView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Activity_open)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self._refreshView, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.SetBannerViewCategoryListInteract, self.setCategoryListInteractable, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.SwitchWelfareActivity, self._openSubView, self)
	self:_initActivityNoviceSign()
	self:_initActivityNewWelfare()
	self:_initActivitySelfSelectSix()
	self:_initActivityNewInsight()
	self:_refreshView()
end

function ActivityWelfareView:_initActivityNoviceSign()
	local actId = ActivityEnum.Activity.NoviceSign
	local is3_8NewRegister = ActivityWelfareModel.instance:is3_8NewRegisterPlayer()

	activitySubViewDict[actId] = is3_8NewRegister and ViewName.VersionActivity3_8NoviceSignView or ViewName.ActivityNoviceSignView
end

function ActivityWelfareView:_initActivityNewWelfare()
	local actId = ActivityEnum.Activity.NewWelfare

	activitySubViewDict[actId] = ViewName.VersionActivity3_8NewWelfareView
end

function ActivityWelfareView:_initActivitySelfSelectSix()
	activitySubViewDict[ActivityEnum.Activity.V2a7_SelfSelectSix2] = ViewName.V2a7_SelfSelectSix_FullView

	local is3_8NewRegister = ActivityWelfareModel.instance:is3_8NewRegisterPlayer()

	if is3_8NewRegister then
		activitySubViewDict[ActivityEnum.Activity.V3a8_SelfSelectSix] = ViewName.VersionActivity3_8SelfSelectSixView
	end
end

function ActivityWelfareView:_initActivityNewInsight()
	activitySubViewDict[ActivityEnum.Activity.V2a7_NewInsight] = ViewName.ActivityInsightShowView_2_7
	activitySubViewDict[ActivityEnum.Activity.V3a9_NewInsight] = ViewName.VersionActivity3_9InsightShowView
end

function ActivityWelfareView:_refreshView()
	local actCo = ActivityModel.instance:getCenterActivities(ActivityEnum.ActivityType.Welfare)

	if not actCo or not next(actCo) then
		self:closeThis()
	end

	ActivityModel.instance:removeFinishedWelfare(actCo)

	local lastdata = self.data and tabletool.copy(self.data) or nil
	local id2data = {}

	self.data = {}

	for _, v in pairs(actCo) do
		local o = {}

		o.id = v
		o.co = ActivityConfig.instance:getActivityCo(v)
		o.type = ActivityEnum.ActivityType.Welfare

		table.insert(self.data, o)

		id2data[v] = o
	end

	ActivityWelfareListModel.instance:setOpenViewTime()

	local isNeedCallOpenSubView = lastdata == nil

	if lastdata ~= nil then
		if #lastdata ~= #self.data then
			isNeedCallOpenSubView = true
		else
			for _, v in ipairs(lastdata) do
				local id = v.id

				if not id2data[id] then
					isNeedCallOpenSubView = true

					break
				end
			end
		end
	end

	if not isNeedCallOpenSubView and self._viewName then
		local c = ViewMgr.instance:getContainer(self._viewName)

		if c then
			ViewMgr.instance:openView(self._viewName, c.viewParam, true)
			self:_statSubViewEnter(self._viewName)

			return
		end
	end

	ActivityWelfareListModel.instance:setCategoryList(self.data)
	self:_openSubView()
end

function ActivityWelfareView:_openSubView()
	if self._viewName then
		ViewMgr.instance:closeView(self._viewName, true)
	end

	local actId = ActivityModel.instance:getTargetActivityCategoryId(ActivityEnum.ActivityType.Welfare)

	self._viewName = activitySubViewDict[actId]

	if not self._viewName then
		return
	end

	if actId == ActivityEnum.Activity.StoryShow or actId == ActivityEnum.Activity.ClassShow then
		self:setCategoryRedDotData(actId)
	end

	self.viewContainer:hideHelp()

	local viewParam = {
		parent = self._gosubview,
		actId = actId,
		root = self.viewGO
	}

	ViewMgr.instance:openView(self._viewName, viewParam, true)
	self:_statSubViewEnter(self._viewName)
end

function ActivityWelfareView:_statSubViewEnter(viewSubName)
	local isNotSame = self._lastStatName ~= viewSubName

	self._lastStatName = viewSubName

	if isNotSame and viewSubName and StatViewNameEnum.ChineseViewName[viewSubName] then
		StatViewController.instance:trackViewName(StatViewNameEnum.ChineseViewName[viewSubName])
	end
end

function ActivityWelfareView:setCategoryRedDotData(actId)
	local key = PlayerPrefsKey.FirstEnterActivityShow .. "#" .. tostring(actId) .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId)

	PlayerPrefsHelper.setString(key, "hasEnter")

	return key
end

function ActivityWelfareView:closeSubView()
	if self._viewName then
		ViewMgr.instance:closeView(self._viewName, true)

		self._viewName = nil
	end
end

function ActivityWelfareView:onClose()
	ActivityModel.instance:setTargetActivityCategoryId(0)
	self.removeEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self._refreshView, self)
	self.removeEventCb(self, ActivityController.instance, ActivityEvent.SetBannerViewCategoryListInteract, self.setCategoryListInteractable, self)
	self:closeSubView()
	ActivityModel.instance:setTargetActivityCategoryId(0)
	ActivityWelfareListModel.instance:clear()
end

function ActivityWelfareView:setCategoryListInteractable(isInteractable)
	self._categoryListCanvasGroup = self._categoryListCanvasGroup or gohelper.onceAddComponent(self._gocategory, typeof(UnityEngine.CanvasGroup))
	self._categoryListCanvasGroup.interactable = isInteractable
	self._categoryListCanvasGroup.blocksRaycasts = isInteractable
	self._categoryListCanvasGroup.blocksRaycasts = isInteractable
end

function ActivityWelfareView:onDestroyView()
	return
end

return ActivityWelfareView
