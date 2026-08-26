-- chunkname: @modules/logic/versionactivity3_7/anniversary3/view/Anniversary3SignView.lua

module("modules.logic.versionactivity3_7.anniversary3.view.Anniversary3SignView", package.seeall)

local Anniversary3SignView = class("Anniversary3SignView", BaseView)

function Anniversary3SignView:onInitView()
	self._txttime = gohelper.findChildText(self.viewGO, "Root/image_LimitTimeBG/#txt_time")
	self._gosignitem = gohelper.findChild(self.viewGO, "Root/content/#go_signitem")
	self._goitemcontent = gohelper.findChild(self.viewGO, "Root/content")
	self._golefttop = gohelper.findChild(self.viewGO, "Root/#go_lefttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Anniversary3SignView:addEvents()
	return
end

function Anniversary3SignView:removeEvents()
	return
end

function Anniversary3SignView:_editableInitView()
	self:_addSelfEvents()
end

function Anniversary3SignView:_addSelfEvents()
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshNorSignActivity, self._onRefreshNorSignActivity, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self._onCheckActState, self)
end

function Anniversary3SignView:_removeSelfEvents()
	self.removeEventCb(self, ActivityController.instance, ActivityEvent.RefreshNorSignActivity, self._onRefreshNorSignActivity, self)
	self.removeEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self._onCheckActState, self)
end

function Anniversary3SignView:_onRefreshNorSignActivity()
	self:_refresh()
end

function Anniversary3SignView:_onCheckActState()
	local status = ActivityHelper.getActivityStatus(self._actId)

	if status == ActivityEnum.ActivityStatus.Expired then
		MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.EndActivity, MsgBoxEnum.BoxType.Yes, ActivityLiveMgr.yesCallback)

		return
	end

	self:_refresh()
end

function Anniversary3SignView:onOpen()
	self._actId = VersionActivity3_7Enum.ActivityId.Anniversary3Sign
	self._txttime.text = ""
	self._itemList = self:getUserDataTb_()

	TaskDispatcher.runRepeat(self._refreshTimeTick, self, 1)
	self:_refresh()
end

function Anniversary3SignView:_refresh()
	self:_refreshList()
	self:_refreshTimeTick()
end

function Anniversary3SignView:_refreshTimeTick()
	self._txttime.text = ActivityModel.getRemainTimeStr(self._actId)
end

function Anniversary3SignView:_refreshList()
	local infos = ActivityType101Model.instance:getType101Info(self._actId)

	for index, info in ipairs(infos) do
		if not self._itemList[index] then
			self._itemList[index] = Anniversary3SignItem.New()

			local rootGo = gohelper.findChild(self._goitemcontent, "pos" .. tostring(index))
			local go = gohelper.findChild(rootGo, "#go_item")

			go = go or gohelper.clone(self._gosignitem, rootGo)

			self._itemList[index]:init(go)
		end

		self._itemList[index]:refresh(index, info)
	end
end

function Anniversary3SignView:onClose()
	if self._itemList then
		for _, v in pairs(self._itemList) do
			v:destroy()
		end

		self._itemList = nil
	end
end

function Anniversary3SignView:onDestroyView()
	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
	self:_removeSelfEvents()
end

return Anniversary3SignView
