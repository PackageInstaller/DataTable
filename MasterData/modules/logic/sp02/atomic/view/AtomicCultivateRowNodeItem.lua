-- chunkname: @modules/logic/sp02/atomic/view/AtomicCultivateRowNodeItem.lua

module("modules.logic.sp02.atomic.view.AtomicCultivateRowNodeItem", package.seeall)

local AtomicCultivateRowNodeItem = class("AtomicCultivateRowNodeItem", ListScrollCellExtend)

function AtomicCultivateRowNodeItem:onInitView()
	return
end

function AtomicCultivateRowNodeItem:addEvents()
	return
end

function AtomicCultivateRowNodeItem:removeEvents()
	return
end

function AtomicCultivateRowNodeItem:onUpdateMO(mo)
	self._mo = mo

	self:refreshNodeList()
end

function AtomicCultivateRowNodeItem:refreshNodeList()
	local dataList = self._mo.nodeList

	for i = 1, 5 do
		local item = self:getNodeItem(i)

		item:updateData(dataList[i])
	end
end

function AtomicCultivateRowNodeItem:getNodeItem(index)
	self.itemList = self.itemList or {}

	local item = self.itemList[index]

	if not item then
		local go = gohelper.findChild(self.viewGO, string.format("#go_skillpos%s", index))

		item = MonoHelper.addNoUpdateLuaComOnceToGo(go, AtomicCultivateNodeItem)
		self.itemList[index] = item
	end

	return item
end

function AtomicCultivateRowNodeItem:onDestroyView()
	return
end

return AtomicCultivateRowNodeItem
