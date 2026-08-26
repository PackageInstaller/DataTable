-- chunkname: @modules/logic/survival/view/map/SurvivalMapSelectDayItem.lua

module("modules.logic.survival.view.map.SurvivalMapSelectDayItem", package.seeall)

local SurvivalMapSelectDayItem = class("SurvivalMapSelectDayItem", SimpleListItem)

function SurvivalMapSelectDayItem:onInit()
	self.go_select = gohelper.findChild(self.viewGO, "#go_select")
end

function SurvivalMapSelectDayItem:onAddListeners()
	return
end

function SurvivalMapSelectDayItem:onItemShow(data)
	return
end

function SurvivalMapSelectDayItem:onSelectChange(isSelect)
	gohelper.setActive(self.go_select, isSelect)
end

return SurvivalMapSelectDayItem
