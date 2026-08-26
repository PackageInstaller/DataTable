-- chunkname: @modules/logic/seasonver/act123/view2_1/component/Season123_2_1MarketShowLevelItem.lua

module("modules.logic.seasonver.act123.view2_1.component.Season123_2_1MarketShowLevelItem", package.seeall)

local Season123_2_1MarketShowLevelItem = class("Season123_2_1MarketShowLevelItem", UserDataDispose)

function Season123_2_1MarketShowLevelItem:init(go, index, targetIndex, maxIndex)
	self:__onInit()

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

function Season123_2_1MarketShowLevelItem:show()
	gohelper.setActive(self._goselected, self.targetIndex == self.index)
	gohelper.setActive(self._gounselect, self.targetIndex ~= self.index)

	self._txtselectindex.text = string.format("%02d", self.index)
	self._txtunselectindex.text = string.format("%02d", self.index)
end

function Season123_2_1MarketShowLevelItem:destroy()
	self:__onDispose()
end

return Season123_2_1MarketShowLevelItem
