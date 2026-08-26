-- chunkname: @modules/logic/dungeon/view/rouge/DungeonRougeTabItem.lua

module("modules.logic.dungeon.view.rouge.DungeonRougeTabItem", package.seeall)

local DungeonRougeTabItem = class("DungeonRougeTabItem", SimpleListItem)

function DungeonRougeTabItem:onInit()
	self.beselected = gohelper.findChild(self.viewGO, "beselected")
	self.unselected = gohelper.findChild(self.viewGO, "unselected")
	self.go_red = gohelper.findChild(self.beselected, "#go_red")
	self.go_red2 = gohelper.findChild(self.unselected, "#go_red")
end

function DungeonRougeTabItem:onAddListeners()
	return
end

function DungeonRougeTabItem:onItemShow(data)
	self.data = data
	self.tabRedDot = data.tabRedDot
	self.isOpen = data.isOpen

	gohelper.setActive(self.viewGO, self.isOpen)

	if not self.isOpen then
		return
	end

	if self.tabRedDot then
		RedDotController.instance:addRedDot(self.go_red, self.tabRedDot)
		RedDotController.instance:addRedDot(self.go_red2, self.tabRedDot)
	end
end

function DungeonRougeTabItem:onSelectChange(isSelect)
	gohelper.setActive(self.beselected, isSelect)
	gohelper.setActive(self.unselected, not isSelect)
end

return DungeonRougeTabItem
