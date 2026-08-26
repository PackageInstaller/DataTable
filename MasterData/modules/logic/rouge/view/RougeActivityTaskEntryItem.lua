-- chunkname: @modules/logic/rouge/view/RougeActivityTaskEntryItem.lua

module("modules.logic.rouge.view.RougeActivityTaskEntryItem", package.seeall)

local RougeActivityTaskEntryItem = class("RougeActivityTaskEntryItem", LuaCompBase)

function RougeActivityTaskEntryItem:init(go)
	self.go = go
	self._txtName = gohelper.findChildText(self.go, "#txt_name")
	self._txtTime = gohelper.findChildText(self.go, "#txt_time")
	self._goReddot = gohelper.findChild(self.go, "#go_reddot")
	self._btnClick = gohelper.getClickWithDefaultAudio(self.go)
end

function RougeActivityTaskEntryItem:addEventListeners()
	self._btnClick:AddClickListener(self._btnClickOnClick, self)
end

function RougeActivityTaskEntryItem:removeEventListeners()
	self._btnClick:RemoveClickListener()
end

function RougeActivityTaskEntryItem:_btnClickOnClick()
	local status, toastId, toastParam = ActivityHelper.getActivityStatusAndToast(self._actId)

	if status == ActivityEnum.ActivityStatus.Normal then
		RougeController.instance:openActivityTaskView(self._actId)
	elseif toastId and toastId ~= 0 then
		GameFacade.showToast(toastId, toastParam)
	end
end

function RougeActivityTaskEntryItem:onActivityOnline(actId)
	self._actId = actId
	self._actCo = ActivityConfig.instance:getActivityCo(self._actId)
	self._actMo = ActivityModel.instance:getActMO(self._actId)

	self:setVisible(true)
	self:refreshUI()
end

function RougeActivityTaskEntryItem:onActivityOffline()
	self:setVisible(false)
	self:cancelTickRefreshTime()
end

function RougeActivityTaskEntryItem:setVisible(visible)
	if self._isVisible == visible then
		return
	end

	self._isVisible = visible

	gohelper.setActive(self.go, visible)
end

function RougeActivityTaskEntryItem:refreshUI()
	self._txtName.text = self._actCo and self._actCo.name
	self._reddotId = self._actCo and self._actCo.redDotId

	RedDotController.instance:addRedDot(self._goReddot, self._reddotId, self._actId)
	self:refreshRemainTime()
	self:tickRefreshRemainTime()
end

function RougeActivityTaskEntryItem:tickRefreshRemainTime()
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
	TaskDispatcher.runRepeat(self.refreshRemainTime, self, 10)
end

function RougeActivityTaskEntryItem:cancelTickRefreshTime()
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
end

function RougeActivityTaskEntryItem:refreshRemainTime()
	self._txtTime.text = ActivityHelper.getActivityRemainTimeStr(self._actId)
end

function RougeActivityTaskEntryItem:onDestroy()
	self:cancelTickRefreshTime()
end

return RougeActivityTaskEntryItem
