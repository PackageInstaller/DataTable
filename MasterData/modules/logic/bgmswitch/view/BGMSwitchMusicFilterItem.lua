-- chunkname: @modules/logic/bgmswitch/view/BGMSwitchMusicFilterItem.lua

module("modules.logic.bgmswitch.view.BGMSwitchMusicFilterItem", package.seeall)

local BGMSwitchMusicFilterItem = class("BGMSwitchMusicFilterItem")

function BGMSwitchMusicFilterItem:init(go)
	self.go = go

	gohelper.setActive(self.go, true)

	self._gounselected = gohelper.findChild(go, "unselected")
	self._txtunselected = gohelper.findChildText(go, "unselected/info")
	self._goselected = gohelper.findChild(go, "selected")
	self._txtselected = gohelper.findChildText(go, "selected/info")
	self._btnclick = gohelper.findChildButtonWithAudio(go, "click")

	self:addEvents()
end

function BGMSwitchMusicFilterItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function BGMSwitchMusicFilterItem:removeEvents()
	self._btnclick:RemoveClickListener()
end

function BGMSwitchMusicFilterItem:_btnclickOnClick()
	local isSelected = BGMSwitchModel.instance:getFilterTypeSelectState(self._typeCo.id)

	BGMSwitchModel.instance:setFilterType(self._typeCo.id, not isSelected)
	BGMSwitchController.instance:dispatchEvent(BGMSwitchEvent.FilterClassSelect)
	self:_refreshItem()
end

function BGMSwitchMusicFilterItem:setItem(typeCo)
	self._typeCo = typeCo

	self:_refreshItem()
end

function BGMSwitchMusicFilterItem:_refreshItem()
	local isSelected = BGMSwitchModel.instance:getFilterTypeSelectState(self._typeCo.id)

	gohelper.setActive(self._goselected, isSelected)
	gohelper.setActive(self._gounselected, not isSelected)

	self._txtselected.text = self._typeCo.typename
	self._txtunselected.text = self._typeCo.typename
end

function BGMSwitchMusicFilterItem:destroy()
	self:removeEvents()
end

return BGMSwitchMusicFilterItem
