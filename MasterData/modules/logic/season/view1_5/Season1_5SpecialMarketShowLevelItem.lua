-- chunkname: @modules/logic/season/view1_5/Season1_5SpecialMarketShowLevelItem.lua

module("modules.logic.season.view1_5.Season1_5SpecialMarketShowLevelItem", package.seeall)

local Season1_5SpecialMarketShowLevelItem = class("Season1_5SpecialMarketShowLevelItem", LuaCompBase)

function Season1_5SpecialMarketShowLevelItem:init(go)
	self.go = go
	self._goline = gohelper.findChild(go, "#go_line")
	self._goselectedpass = gohelper.findChild(go, "#go_selectedpass")
	self._txtselectpassindex = gohelper.findChildText(go, "#go_selectedpass/#txt_selectpassindex")
	self._goselectedunpass = gohelper.findChild(go, "#go_selectedunpass")
	self._txtselectunpassindex = gohelper.findChildText(go, "#go_selectedunpass/#txt_selectunpassindex")
	self._gopass = gohelper.findChild(go, "#go_pass")
	self._txtpassindex = gohelper.findChildText(go, "#go_pass/#txt_passindex")
	self._gounpass = gohelper.findChild(go, "#go_unpass")
	self._txtunpassindex = gohelper.findChildText(go, "#go_unpass/#txt_unpassindex")
	self._btnClick = gohelper.findChildButtonWithAudio(go, "#btn_click")

	self._btnClick:AddClickListener(self._btnOnClick, self)
end

function Season1_5SpecialMarketShowLevelItem:_btnOnClick()
	Activity104Controller.instance:dispatchEvent(Activity104Event.SwitchSpecialEpisode, self.index)
end

function Season1_5SpecialMarketShowLevelItem:reset(index, targetIndex, maxSpecialLayer)
	self.index = index
	self.targetIndex = targetIndex
	self.maxSpecialLayer = maxSpecialLayer

	self:_refreshItem()
end

function Season1_5SpecialMarketShowLevelItem:_refreshItem()
	gohelper.setActive(self.go, true)

	local pass = Activity104Model.instance:isSpecialLayerPassed(self.index)

	gohelper.setActive(self._gopass, pass and self.targetIndex ~= self.index)
	gohelper.setActive(self._gounpass, not pass and self.targetIndex ~= self.index)
	gohelper.setActive(self._goselectedpass, pass and self.targetIndex == self.index)
	gohelper.setActive(self._goselectedunpass, not pass and self.targetIndex == self.index)
	gohelper.setActive(self._goline, self.index < self.maxSpecialLayer)

	self._txtselectpassindex.text = string.format("%02d", self.index)
	self._txtselectunpassindex.text = string.format("%02d", self.index)
	self._txtpassindex.text = string.format("%02d", self.index)
	self._txtunpassindex.text = string.format("%02d", self.index)
end

function Season1_5SpecialMarketShowLevelItem:destroy()
	self._btnClick:RemoveClickListener()
end

return Season1_5SpecialMarketShowLevelItem
