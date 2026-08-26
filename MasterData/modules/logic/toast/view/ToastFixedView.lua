-- chunkname: @modules/logic/toast/view/ToastFixedView.lua

module("modules.logic.toast.view.ToastFixedView", package.seeall)

local ToastFixedView = class("ToastFixedView", BaseView)

function ToastFixedView:onInitView()
	self._gotemplate = gohelper.findChild(self.viewGO, "#go_template")
	self._gopoint = gohelper.findChild(self.viewGO, "#go_point")
	self._gopoint2 = gohelper.findChild(self.viewGO, "#go_point2")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ToastFixedView:addEvents()
	return
end

function ToastFixedView:removeEvents()
	return
end

function ToastFixedView:_editableInitView()
	self._usingMsgList = {}
	self._usingList = {}
	self._freeList = {}
	self._cacheMsgList = {}
	self._maxCount = 3

	local templateTransform = self._gotemplate.transform

	self._itemHeight = recthelper.getHeight(templateTransform)
	self._itemWidth = recthelper.getWidth(templateTransform)
	self._offsetX = -578
end

function ToastFixedView:onUpdateParam()
	return
end

function ToastFixedView:onDestroyView()
	return
end

function ToastFixedView:onOpen()
	self.addEventCb(self, ToastController.instance, ToastEvent.ReceiveToast, self._onReceiveToast, self)
	self.addEventCb(self, ToastController.instance, ToastEvent.RecycleFixedToast, self._doRecycleAnimation, self)
	self.addEventCb(self, ToastController.instance, ToastEvent.ClearToast, self._doClearToast, self)
end

function ToastFixedView:_doClearToast(id)
	local handler = ToastParamEnum.ClearToastHandler[id]

	if not handler then
		return
	end

	if #self._cacheMsgList > 0 then
		for i, v in ipairs(self._cacheMsgList) do
			callWithCatch(handler, v)
			ToastController.instance:dispatchEvent(ToastEvent.ClearCacheToastInfo, v)
		end

		tabletool.clear(self._cacheMsgList)
	end

	if #self._usingList > 0 then
		for i = #self._usingList, 1, -1 do
			local item = self._usingList[i]

			self:_doRecycleAnimation(item)
		end
	end
end

function ToastFixedView:onClose()
	TaskDispatcher.cancelTask(self._showToast, self)
end

function ToastFixedView:_onReceiveToast(msg)
	if not msg.co or not ToastParamEnum.FixedToast[msg.co.id] then
		return
	end

	if #self._usingList >= self._maxCount then
		table.insert(self._cacheMsgList, msg)

		return
	end

	self:_showToast(msg)
end

function ToastFixedView:_showToast(msg)
	local newItem = table.remove(self._freeList, 1)

	if not newItem then
		local go = gohelper.clone(self._gotemplate, self._gopoint2)

		newItem = MonoHelper.addNoUpdateLuaComOnceToGo(go, ToastFixedItem)
	end

	table.insert(self._usingList, newItem)
	newItem:setMsg(msg)
	newItem:appearAnimation(msg)
	self:_refreshAllItemsAnimation()
	self:_updateNormalToastOffset()
end

function ToastFixedView:_doRecycleAnimation(item, isManualRecycle)
	local index = tabletool.indexOf(self._usingList, item)

	if index then
		table.remove(self._usingList, index)
	end

	local msgIndex = tabletool.indexOf(self._usingMsgList, item.msg)

	if msgIndex then
		table.remove(self._usingMsgList, msgIndex)
	end

	item:clearAllTask()
	item:quitAnimation(self._recycleToast, self)
	self:_updateNormalToastOffset()
end

function ToastFixedView:_updateNormalToastOffset()
	recthelper.setAnchorX(self._gopoint.transform, (#self._usingList > 0 or nil) and (self._offsetX or 0))
end

function ToastFixedView:_recycleToast(item)
	ToastController.instance:dispatchEvent(ToastEvent.ClearCacheToastInfo, item.msg)
	item:reset()
	table.insert(self._freeList, item)
	self:_refreshAllItemsAnimation()

	if #self._usingList < self._maxCount and #self._cacheMsgList > 0 then
		self:_showToast(table.remove(self._cacheMsgList, 1))
	end
end

function ToastFixedView:_refreshAllItemsAnimation()
	local anchorY = 0

	for i, item in ipairs(self._usingList) do
		if i == #self._usingList then
			recthelper.setAnchorY(item.tr, anchorY)
		else
			item:upAnimation(anchorY)
		end

		anchorY = anchorY - (ToastParamEnum.ToastHeight[item.msg.co.id] or self._itemHeight)
	end
end

return ToastFixedView
