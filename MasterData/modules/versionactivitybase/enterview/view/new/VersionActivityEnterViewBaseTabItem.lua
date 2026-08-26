-- chunkname: @modules/versionactivitybase/enterview/view/new/VersionActivityEnterViewBaseTabItem.lua

module("modules.versionactivitybase.enterview.view.new.VersionActivityEnterViewBaseTabItem", package.seeall)

local VersionActivityEnterViewBaseTabItem = class("VersionActivityEnterViewBaseTabItem", LuaCompBase)

function VersionActivityEnterViewBaseTabItem:init(go)
	if gohelper.isNil(go) then
		return
	end

	self.go = go
	self.rectTr = self.go:GetComponent(gohelper.Type_RectTransform)
	self.click = gohelper.getClickWithDefaultAudio(self.go)

	self:_editableInitView()
	gohelper.setActive(self.go, true)
end

function VersionActivityEnterViewBaseTabItem:setData(index, actSetting)
	self.index = index
	self.actSetting = actSetting
	self.redDotUid = actSetting.redDotUid or 0
	self.storeId = actSetting.storeId

	self:updateActId()
	self:afterSetData()
	TaskDispatcher.runRepeat(self.refreshTag, self, TimeUtil.OneMinuteSecond)
end

function VersionActivityEnterViewBaseTabItem:updateActId()
	local actId = VersionActivityEnterHelper.getActId(self.actSetting)

	if actId == self.actId then
		return false
	end

	self.actId = actId
	self.activityCo = ActivityConfig.instance:getActivityCo(self.actId)

	return true
end

function VersionActivityEnterViewBaseTabItem:setClickFunc(customClick, clickFuncObj)
	self.customClick = customClick
	self.customClickObj = clickFuncObj
end

function VersionActivityEnterViewBaseTabItem:addEventListeners()
	self.addEventCb(self, RedDotController.instance, RedDotEvent.UpdateActTag, self.refreshTag, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self.onRefreshActivity, self)
	self.addEventCb(self, VersionActivityBaseController.instance, VersionActivityEnterViewEvent.SelectActId, self.refreshSelect, self)
	self.click:AddClickListener(self.onClick, self)
end

function VersionActivityEnterViewBaseTabItem:removeEventListeners()
	self.removeEventCb(self, RedDotController.instance, RedDotEvent.UpdateActTag, self.refreshTag, self)
	self.removeEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self.onRefreshActivity, self)
	self.removeEventCb(self, VersionActivityBaseController.instance, VersionActivityEnterViewEvent.SelectActId, self.refreshSelect, self)
	self.click:RemoveClickListener()
end

function VersionActivityEnterViewBaseTabItem:onRefreshActivity(actId)
	if self.actId ~= actId then
		return
	end

	self:refreshTag()
end

function VersionActivityEnterViewBaseTabItem:refreshSelect(actId)
	self.isSelect = actId == self.actId

	self:childRefreshSelect()
end

function VersionActivityEnterViewBaseTabItem:onClick()
	if self.isSelect then
		return
	end

	if self.customClick then
		self.customClick(self.customClickObj, self)

		return
	end

	if not self.storeId then
		local checkActId = self.actId
		local status, toastId, paramList = ActivityHelper.getActivityStatusAndToast(checkActId)

		if status == ActivityEnum.ActivityStatus.Normal or status == ActivityEnum.ActivityStatus.NotUnlock then
			self.animator:Play("click", 0, 0)
			VersionActivityBaseController.instance:dispatchEvent(VersionActivityEnterViewEvent.SelectActId, self.actId, self)

			return
		end

		if toastId then
			GameFacade.showToastWithTableParam(toastId, paramList)
		end

		AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_closehouse)
	end
end

function VersionActivityEnterViewBaseTabItem:_editableInitView()
	logError("override VersionActivityEnterViewBaseTabItem:_editableInitView")
end

function VersionActivityEnterViewBaseTabItem:afterSetData()
	return
end

function VersionActivityEnterViewBaseTabItem:childRefreshSelect()
	logError("override VersionActivityEnterViewBaseTabItem:childRefreshSelect")
end

function VersionActivityEnterViewBaseTabItem:childRefreshUI()
	return
end

function VersionActivityEnterViewBaseTabItem:refreshTag()
	return
end

function VersionActivityEnterViewBaseTabItem:refreshUI()
	self:childRefreshUI()
	self:refreshTag()
end

function VersionActivityEnterViewBaseTabItem:getAnchorY()
	return recthelper.getAnchorY(self.rectTr)
end

function VersionActivityEnterViewBaseTabItem:getAnchorX()
	return recthelper.getAnchorX(self.rectTr)
end

function VersionActivityEnterViewBaseTabItem:getWidth()
	return recthelper.getWidth(self.rectTr)
end

function VersionActivityEnterViewBaseTabItem:dispose()
	TaskDispatcher.cancelTask(self.refreshTag, self)
end

return VersionActivityEnterViewBaseTabItem
