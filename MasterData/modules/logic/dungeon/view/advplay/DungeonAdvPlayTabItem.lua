-- chunkname: @modules/logic/dungeon/view/advplay/DungeonAdvPlayTabItem.lua

module("modules.logic.dungeon.view.advplay.DungeonAdvPlayTabItem", package.seeall)

local DungeonAdvPlayTabItem = class("DungeonAdvPlayTabItem", SimpleListItem)

function DungeonAdvPlayTabItem:onInit()
	self.beselected = gohelper.findChild(self.viewGO, "beselected")
	self.unselected = gohelper.findChild(self.viewGO, "unselected")
	self.go_red = gohelper.findChild(self.beselected, "#go_red")
	self.go_red2 = gohelper.findChild(self.unselected, "#go_red")
end

function DungeonAdvPlayTabItem:onAddListeners()
	return
end

function DungeonAdvPlayTabItem:onItemShow(data)
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

function DungeonAdvPlayTabItem:onSelectChange(isSelect)
	gohelper.setActive(self.beselected, isSelect)
	gohelper.setActive(self.unselected, not isSelect)
end

return DungeonAdvPlayTabItem
