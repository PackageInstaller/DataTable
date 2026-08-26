-- chunkname: @modules/logic/sp02/dungeonmap/view/AtomicDungeonToastBaseView.lua

module("modules.logic.sp02.dungeonmap.view.AtomicDungeonToastBaseView", package.seeall)

local AtomicDungeonToastBaseView = class("AtomicDungeonToastBaseView", BaseView)

function AtomicDungeonToastBaseView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function AtomicDungeonToastBaseView:_editableInitView()
	self._usingList = {}
	self._freeList = {}
	self._cacheMsgList = {}
	self._maxCount = 3
	self._showNextToastInterval = 0.1
	self.hadTask = false
end

function AtomicDungeonToastBaseView:onOpen()
	return
end

function AtomicDungeonToastBaseView:addToastMsg(msg)
	if msg and not tabletool.indexOf(self._cacheMsgList, msg) then
		table.insert(self._cacheMsgList, msg)
	end

	if not self.hadTask and self._cacheMsgList[1] then
		self:_showToast()
		TaskDispatcher.runRepeat(self._showToast, self, self._showNextToastInterval)

		self.hadTask = true
	end
end

function AtomicDungeonToastBaseView:_showToast()
	local msg = table.remove(self._cacheMsgList, 1)

	if not msg then
		TaskDispatcher.cancelTask(self._showToast, self)

		self.hadTask = false

		return
	end

	local newItem = table.remove(self._freeList, 1)

	newItem = newItem or self:createToastItem()

	local item

	if #self._usingList >= self._maxCount then
		self:_doRecycleAnimation(self._usingList[1])
	end

	table.insert(self._usingList, newItem)
	newItem:setMsg(msg)
	newItem:appearAnimation(msg)
	self:_refreshAllItemsAnimation()
end

function AtomicDungeonToastBaseView:createToastItem()
	return
end

function AtomicDungeonToastBaseView:_doRecycleAnimation(item)
	local index = tabletool.indexOf(self._usingList, item)

	if index then
		table.remove(self._usingList, index)
	end

	item:clearAllTask()
	item:quitAnimation(self._recycleToast, self)
end

function AtomicDungeonToastBaseView:_recycleToast(item)
	item:reset()
	table.insert(self._freeList, item)
end

function AtomicDungeonToastBaseView:_refreshAllItemsAnimation()
	local anchorY = 0

	for i, item in ipairs(self._usingList) do
		local itemHeight = item:getHeight()

		if i == 1 then
			anchorY = anchorY - itemHeight / 2
		end

		if i == #self._usingList then
			recthelper.setAnchorY(item.trans, anchorY + itemHeight / 2)
		else
			item:upAnimation(anchorY + itemHeight / 2)
		end

		anchorY = anchorY + itemHeight + 10
	end
end

function AtomicDungeonToastBaseView:onClose()
	return
end

function AtomicDungeonToastBaseView:onDestroyView()
	return
end

return AtomicDungeonToastBaseView
