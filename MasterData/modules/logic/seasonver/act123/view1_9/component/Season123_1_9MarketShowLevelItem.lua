-- chunkname: @modules/logic/seasonver/act123/view1_9/component/Season123_1_9MarketShowLevelItem.lua

module("modules.logic.seasonver.act123.view1_9.component.Season123_1_9MarketShowLevelItem", package.seeall)

local Season123_1_9MarketShowLevelItem = class("Season123_1_9MarketShowLevelItem", UserDataDispose)

function Season123_1_9MarketShowLevelItem:init(go, index, targetIndex, maxIndex)
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

function Season123_1_9MarketShowLevelItem:show()
	gohelper.setActive(self._goselected, self.targetIndex == self.index)
	gohelper.setActive(self._gounselect, self.targetIndex ~= self.index)

	self._txtselectindex.text = string.format("%02d", self.index)
	self._txtunselectindex.text = string.format("%02d", self.index)
end

function Season123_1_9MarketShowLevelItem:destroy()
	self:__onDispose()
end

return Season123_1_9MarketShowLevelItem
