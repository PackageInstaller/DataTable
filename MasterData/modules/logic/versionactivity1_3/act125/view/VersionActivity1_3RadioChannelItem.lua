-- chunkname: @modules/logic/versionactivity1_3/act125/view/VersionActivity1_3RadioChannelItem.lua

module("modules.logic.versionactivity1_3.act125.view.VersionActivity1_3RadioChannelItem", package.seeall)

local VersionActivity1_3RadioChannelItem = class("VersionActivity1_3RadioChannelItem", ListScrollCell)

function VersionActivity1_3RadioChannelItem:init(go)
	self.go = go
	self._txtFMChannelNumSelected = gohelper.findChildText(go, "txt_FMChannelNumSelected")
	self._txtFMChannelNumUnSelected = gohelper.findChildText(go, "txt_FMChannelNumUnSelected")
	self._click = gohelper.getClick(go)
end

function VersionActivity1_3RadioChannelItem:addEventListeners()
	Activity125Controller.instance:registerCallback(Activity125Event.OnFMScrollValueChange, self._refreshFMSliderItem, self)
	self._click:AddClickListener(self._onClick, self)
end

function VersionActivity1_3RadioChannelItem:removeEventListeners()
	Activity125Controller.instance:unregisterCallback(Activity125Event.OnFMScrollValueChange, self._refreshFMSliderItem, self)
	self._click:RemoveClickListener()
end

function VersionActivity1_3RadioChannelItem:onUpdateMO(mo)
	self._mo = mo

	gohelper.setActive(self._txtFMChannelNumSelected.gameObject, not mo.isEmpty)
	gohelper.setActive(self._txtFMChannelNumUnSelected.gameObject, not mo.isEmpty)

	self._id = mo.id

	if mo.isEmpty then
		return
	end

	self._txtFMChannelNumSelected.text = mo.value
	self._txtFMChannelNumUnSelected.text = mo.value
end

local channelOffset = 0.05

function VersionActivity1_3RadioChannelItem:_refreshFMSliderItem(fmsliderPingPosX)
	local channelItemPosX = transformhelper.getPos(self.go.transform)
	local distance = Mathf.Abs(channelItemPosX - fmsliderPingPosX)
	local isSelected = distance <= channelOffset

	self:onSelect(false)

	if isSelected then
		self._view:selectCell(self._index, true)
	end
end

function VersionActivity1_3RadioChannelItem:_onClick()
	if self._index and not self._mo.isEmpty then
		self._view:selectCell(self._index, true)
		Activity125Controller.instance:dispatchEvent(Activity125Event.OnChannelItemClick, self._id)
	end
end

function VersionActivity1_3RadioChannelItem:onSelect(isSelect)
	gohelper.setActive(self._txtFMChannelNumSelected.gameObject, isSelect and not self._mo.isEmpty)
	gohelper.setActive(self._txtFMChannelNumUnSelected.gameObject, not isSelect and not self._mo.isEmpty)

	if isSelect then
		Activity125Controller.instance:dispatchEvent(Activity125Event.OnChannelSelected, self._id)
	end
end

function VersionActivity1_3RadioChannelItem:onDestroy()
	return
end

return VersionActivity1_3RadioChannelItem
