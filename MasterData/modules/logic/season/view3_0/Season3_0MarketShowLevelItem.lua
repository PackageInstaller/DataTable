-- chunkname: @modules/logic/season/view3_0/Season3_0MarketShowLevelItem.lua

module("modules.logic.season.view3_0.Season3_0MarketShowLevelItem", package.seeall)

local Season3_0MarketShowLevelItem = class("Season3_0MarketShowLevelItem", LuaCompBase)

function Season3_0MarketShowLevelItem:init(go, index, targetIndex, maxIndex)
	self.go = go
	self.index = index
	self.targetIndex = targetIndex
	self.maxIndex = maxIndex
	self._goselected = gohelper.findChild(go, "#go_selected")
	self._txtselectindex = gohelper.findChildText(go, "#go_selected/#txt_selectindex")
	self._gounselect = gohelper.findChild(go, "#go_unselected")
	self._txtunselectindex = gohelper.findChildText(go, "#go_unselected/#txt_selectindex")

	gohelper.setActive(self.go, true)
	gohelper.setActive(self._goselected, false)
	gohelper.setActive(self._gounselect, false)
end

function Season3_0MarketShowLevelItem:show()
	gohelper.setActive(self._goselected, self.targetIndex == self.index)
	gohelper.setActive(self._gounselect, self.targetIndex ~= self.index)

	self._txtselectindex.text = string.format("%02d", self.index)
	self._txtunselectindex.text = string.format("%02d", self.index)
end

function Season3_0MarketShowLevelItem:destroy()
	return
end

return Season3_0MarketShowLevelItem
