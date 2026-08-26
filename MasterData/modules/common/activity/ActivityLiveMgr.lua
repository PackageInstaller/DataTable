-- chunkname: @modules/common/activity/ActivityLiveMgr.lua

module("modules.common.activity.ActivityLiveMgr", package.seeall)

local ActivityLiveMgr = class("ActivityLiveMgr")

function ActivityLiveMgr:init()
	self:initActivityMgrList()
	self:addConstEvents()
end

function ActivityLiveMgr:getLiveMgrVersion()
	for _, mgrInstance in ipairs(self.actMgrInstanceList) do
		local name = mgrInstance.__cname

		return string.gsub(name, "ActivityLiveMgr", "")
	end
end

function ActivityLiveMgr:initActivityMgrList()
	self.actMgrInstanceList = {
		ActivityLiveMgr3_9.instance
	}
	self.actId2ViewList = {}
	self.actIdCloseCheckList = {}

	for _, mgrInstance in ipairs(self.actMgrInstanceList) do
		mgrInstance:init()

		for actId, viewList in pairs(mgrInstance:getActId2ViewList()) do
			if self.actId2ViewList[actId] then
				logWarn(string.format("act : %s config multiple, please check!"))
			end

			self.actId2ViewList[actId] = viewList
		end

		if mgrInstance.getActIdCheckCloseList then
			local closeCheckList = mgrInstance:getActIdCheckCloseList()

			if mgrInstance.getActIdCheckCloseList then
				for actId, checkFunc in pairs(mgrInstance.getActIdCheckCloseList) do
					self.actIdCloseCheckList[actId] = checkFunc
				end
			end
		end
	end
end

function ActivityLiveMgr:addConstEvents()
	ActivityController.instance:registerCallback(ActivityEvent.RefreshActivityState, self.checkActivity, self)
end

function ActivityLiveMgr:checkActivity(actId)
	if string.nilorempty(actId) or actId == 0 then
		for _actId, _ in pairs(self.actId2ViewList) do
			if self:checkOneActivityIsEnd(_actId) then
				return
			end
		end
	end

	self:checkOneActivityIsEnd(actId)
end

function ActivityLiveMgr:checkOneActivityIsEnd(actId)
	if string.nilorempty(actId) or actId == 0 then
		return false
	end

	local status = ActivityHelper.getActivityStatus(actId)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		local checkFunc = self.actIdCloseCheckList[actId]
		local checkViewList = self.actId2ViewList[actId]

		if checkViewList then
			for _, viewName in ipairs(checkViewList) do
				if ViewMgr.instance:isOpen(viewName) and (not checkFunc or checkFunc(actId, viewName)) then
					MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.EndActivity, MsgBoxEnum.BoxType.Yes, ActivityLiveMgr.yesCallback)

					return true
				end
			end
		end

		ActivityController.instance:dispatchEvent(ActivityEvent.CheckGuideOnEndActivity)
	end

	return false
end

function ActivityLiveMgr.yesCallback()
	ActivityController.instance:dispatchEvent(ActivityEvent.CheckGuideOnEndActivity)
	NavigateButtonsView.homeClick()
end

ActivityLiveMgr.instance = ActivityLiveMgr.New()

return ActivityLiveMgr
