-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\HeroEquipListChild.lua

local strClassName = "HeroEquipListChild"
local HeroEquipListChild = Class(strClassName, UIControls.Child)

function HeroEquipListChild:ctor()
	self:initUI()
end

function HeroEquipListChild:initUI()
	self.view = UIControls.ScrollViewLoopV(self, "", 0, self._initItem)
	self.cells = {}
	self.panelContentNone = UIControls.Panel(self, "NoContent")
end

function HeroEquipListChild:_initItem(sender, targetCell, newIdx)
	targetCell = targetCell or UIControls.EquipGridLoop(sender, "System/Common/Grid/GridEquipItem", 0, 0, newIdx)

	if not self.data or #self.data == 0 then
		return
	end

	if self.data[newIdx] ~= nil then
		targetCell:setObj(self.data[newIdx])

		targetCell.mEnableTips = false
		targetCell.mEventClick = Slot(self.selectEquip, self)

		targetCell.imgSelect:setVisible(self.selectGid and self.selectGid == self.data[newIdx].gid)
		targetCell.panelAttr:setVisible(true)
	end

	self.cells[newIdx] = targetCell
end

function HeroEquipListChild:selectEquip(sender)
	self.selectGid = sender.object.gid
	self.selectedGrid = sender

	self.mWindow:setSelectItem(sender.object)
	self.view:setTotalCount(#self.data)
end

function HeroEquipListChild:setData(data)
	self.data = data

	self.view:setTotalCount(#self.data)
end

function HeroEquipListChild:updateSort(items)
	self:setData(items)
end

return HeroEquipListChild
