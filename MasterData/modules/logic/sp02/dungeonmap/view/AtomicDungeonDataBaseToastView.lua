-- chunkname: @modules/logic/sp02/dungeonmap/view/AtomicDungeonDataBaseToastView.lua

module("modules.logic.sp02.dungeonmap.view.AtomicDungeonDataBaseToastView", package.seeall)

local AtomicDungeonDataBaseToastView = class("AtomicDungeonDataBaseToastView", AtomicDungeonToastBaseView)

function AtomicDungeonDataBaseToastView:onInitView()
	self._godataBaseToastContent = gohelper.findChild(self.viewGO, "root/#go_dataBaseToastContent")
	self._godataBaseToastItem = gohelper.findChild(self.viewGO, "root/#go_dataBaseToastContent/#go_dataBaseToastItem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

local OutSidePos = -10000

function AtomicDungeonDataBaseToastView:_editableInitView()
	AtomicDungeonDataBaseToastView.super._editableInitView(self)
	gohelper.setActive(self._godataBaseToastItem, false)
	recthelper.setAnchor(self._godataBaseToastItem.transform, OutSidePos, 0)
end

function AtomicDungeonDataBaseToastView:onOpen()
	self.addEventCb(self, AtomicDungeonController.instance, AtomicDungeonEvent.RecycleDataBaseToast, self._doRecycleAnimation, self)
	self.addEventCb(self, AtomicDungeonController.instance, AtomicDungeonEvent.OnCloseDataBaseToast, self.onCloseDataBaseToast, self)
end

function AtomicDungeonDataBaseToastView:createToastItem()
	local go = gohelper.clone(self._godataBaseToastItem, self._godataBaseToastContent, "dataBaseToastItem")

	return (MonoHelper.addNoUpdateLuaComOnceToGo(go, AtomicDungeonDataBaseToastItem, {
		toastView = self
	}))
end

function AtomicDungeonDataBaseToastView:_showToast()
	local msg = table.remove(self._cacheMsgList, 1)

	if not msg then
		TaskDispatcher.cancelTask(self._showToast, self)

		self.hadTask = false

		return
	end

	local newItem = table.remove(self._freeList, 1)

	newItem = newItem or self:createToastItem()

	local item

	if self._usingList[1] then
		self:_doRecycleAnimation(self._usingList[1])
	end

	table.insert(self._usingList, newItem)
	newItem:setMsg(msg)
	newItem:appearAnimation(msg)
	self:_refreshAllItemsAnimation()
end

function AtomicDungeonDataBaseToastView:onCloseDataBaseToast(databaseId)
	local dataBaseCo = AtomicConfig.instance:getLibraryConfig(databaseId)

	self:addToastMsg(dataBaseCo)
end

function AtomicDungeonDataBaseToastView:onClose()
	self.removeEventCb(self, AtomicDungeonController.instance, AtomicDungeonEvent.OnCloseDataBaseToast, self.onCloseDataBaseToast, self)
	self.removeEventCb(self, AtomicDungeonController.instance, AtomicDungeonEvent.RecycleDataBaseToast, self._doRecycleAnimation, self)
	TaskDispatcher.cancelTask(self._showToast, self)

	self.hadTask = false
end

return AtomicDungeonDataBaseToastView
