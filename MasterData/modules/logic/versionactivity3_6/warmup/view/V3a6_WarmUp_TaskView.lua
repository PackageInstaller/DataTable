-- chunkname: @modules/logic/versionactivity3_6/warmup/view/V3a6_WarmUp_TaskView.lua

module("modules.logic.versionactivity3_6.warmup.view.V3a6_WarmUp_TaskView", package.seeall)

local V3a6_WarmUp_TaskView = class("V3a6_WarmUp_TaskView", BaseView)

function V3a6_WarmUp_TaskView:onInitView()
	self._btncloseEmpty = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_closeEmpty")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._scrollreward = gohelper.findChildScrollRect(self.viewGO, "right/#scroll_reward")
	self._gorewardcontent = gohelper.findChild(self.viewGO, "right/#scroll_reward/viewport/#go_rewardcontent")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a6_WarmUp_TaskView:addEvents()
	self._btncloseEmpty:AddClickListener(self._btncloseEmptyOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function V3a6_WarmUp_TaskView:removeEvents()
	self._btncloseEmpty:RemoveClickListener()
	self._btnclose:RemoveClickListener()
end

function V3a6_WarmUp_TaskView:_btncloseEmptyOnClick()
	self:closeThis()
end

function V3a6_WarmUp_TaskView:_btncloseOnClick()
	self:closeThis()
end

function V3a6_WarmUp_TaskView:_editableInitView()
	return
end

function V3a6_WarmUp_TaskView:onUpdateParam()
	V3a6_WarmUp_TaskListModel.instance:refreshList()
end

function V3a6_WarmUp_TaskView:onOpen()
	self:onUpdateParam()
	Activity125Controller.instance:registerCallback(Activity125Event.DataUpdate, self._onDataUpdate, self)
end

function V3a6_WarmUp_TaskView:onClose()
	Activity125Controller.instance:unregisterCallback(Activity125Event.DataUpdate, self._onDataUpdate, self)
end

function V3a6_WarmUp_TaskView:onDestroyView()
	return
end

function V3a6_WarmUp_TaskView:_onDataUpdate()
	self:onUpdateParam()
end

return V3a6_WarmUp_TaskView
