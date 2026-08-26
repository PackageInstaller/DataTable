-- chunkname: @modules/logic/sp01/library/AssassinLibraryToastView.lua

module("modules.logic.sp01.library.AssassinLibraryToastView", package.seeall)

local AssassinLibraryToastView = class("AssassinLibraryToastView", BaseView)
local OutSidePos = 10000

function AssassinLibraryToastView:onInitView()
	self._gotemplate = gohelper.findChild(self.viewGO, "#go_template")
	self._gopoint = gohelper.findChild(self.viewGO, "#go_point")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AssassinLibraryToastView:addEvents()
	return
end

function AssassinLibraryToastView:removeEvents()
	return
end

function AssassinLibraryToastView:_editableInitView()
	self._usingList = {}
	self._freeList = {}
	self._cacheMsgList = {}
	self._maxCount = 3
	self._showNextToastInterval = 0.1
	self.hadTask = false

	local templateTransform = self._gotemplate.transform

	self._itemHeight = recthelper.getHeight(templateTransform)
	self._itemWidth = recthelper.getWidth(templateTransform)

	recthelper.setAnchor(self._gotemplate.transform, OutSidePos, OutSidePos)
end

function AssassinLibraryToastView:onDestroyView()
	return
end

function AssassinLibraryToastView:onOpen()
	self.addEventCb(self, AssassinController.instance, AssassinEvent.RecycleToast, self._doRecycleAnimation, self)
	self:addToastMsgList(self.viewParam)
end

function AssassinLibraryToastView:onUpdateParam()
	self:addToastMsgList(self.viewParam)
end

function AssassinLibraryToastView:onClose()
	TaskDispatcher.cancelTask(self._showToast, self)

	self.hadTask = false
	self.close = true
end

function AssassinLibraryToastView:addToastMsgList(msgList)
	if not msgList or self.close then
		return
	end

	for _, msg in ipairs(msgList) do
		self:addToastMsg(msg)
	end
end

function AssassinLibraryToastView:addToastMsg(msg)
	table.insert(self._cacheMsgList, msg)

	if not self.hadTask then
		self:_showToast()
		TaskDispatcher.runRepeat(self._showToast, self, self._showNextToastInterval)

		self.hadTask = true
	end
end

function AssassinLibraryToastView:_showToast()
	local msg = table.remove(self._cacheMsgList, 1)

	if not msg then
		TaskDispatcher.cancelTask(self._showToast, self)

		self.hadTask = false

		return
	end

	local newItem = table.remove(self._freeList, 1)

	if not newItem then
		local go = gohelper.clone(self._gotemplate, self._gopoint)

		newItem = MonoHelper.addNoUpdateLuaComOnceToGo(go, AssassinLibraryToastItem)
	end

	local item

	if #self._usingList >= self._maxCount then
		self:_doRecycleAnimation(self._usingList[1], true)
	end

	table.insert(self._usingList, newItem)
	newItem:setMsg(msg)
	newItem:appearAnimation(msg)
	self:_refreshAllItemsAnimation()
end

function AssassinLibraryToastView:_doRecycleAnimation(item, isManualRecycle)
	local index = tabletool.indexOf(self._usingList, item)

	if index then
		table.remove(self._usingList, index)
	end

	item:clearAllTask()
	item:quitAnimation(self._recycleToast, self)
end

function AssassinLibraryToastView:_recycleToast(item)
	item:reset()
	table.insert(self._freeList, item)

	if #self._usingList <= 0 then
		self:closeThis()
	end
end

function AssassinLibraryToastView:_refreshAllItemsAnimation()
	for i, item in ipairs(self._usingList) do
		if i == #self._usingList then
			recthelper.setAnchorY(item.tr, (1 - i) * self._itemHeight)
		else
			item:upAnimation((1 - i) * self._itemHeight)
		end
	end
end

return AssassinLibraryToastView
