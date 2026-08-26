-- chunkname: @modules/logic/versionactivity2_4/pinball/view/PinballTalentTabItem.lua

module("modules.logic.versionactivity2_4.pinball.view.PinballTalentTabItem", package.seeall)

local PinballTalentTabItem = class("PinballTalentTabItem", LuaCompBase)

function PinballTalentTabItem:init(go)
	self.go = go
	self._goselect = gohelper.findChild(go, "selectbg")
	self._gounselect = gohelper.findChild(go, "unselectbg")
	self._txtname = gohelper.findChildTextMesh(go, "#txt_name")
	self._click = gohelper.getClick(go)
	self._red = gohelper.findChild(go, "go_reddot")
end

function PinballTalentTabItem:addEventListeners()
	self._click:AddClickListener(self._onClick, self)
	PinballController.instance:registerCallback(PinballEvent.TalentRedChange, self._onTalentRedChange, self)
end

function PinballTalentTabItem:removeEventListeners()
	self._click:RemoveClickListener()
	PinballController.instance:unregisterCallback(PinballEvent.TalentRedChange, self._onTalentRedChange, self)
end

function PinballTalentTabItem:setData(data)
	self._txtname.text = data.co.name
	self._data = data

	self:_onTalentRedChange()
end

function PinballTalentTabItem:_onTalentRedChange()
	gohelper.setActive(self._red, PinballModel.instance:getTalentRed(self._data.co.id))
end

function PinballTalentTabItem:setSelectData(data)
	gohelper.setActive(self._goselect, data == self._data)
	gohelper.setActive(self._gounselect, data ~= self._data)
end

function PinballTalentTabItem:setClickCall(callback, callobj)
	self.callback = callback
	self.callobj = callobj
end

function PinballTalentTabItem:_onClick()
	if self.callback then
		self.callback(self.callobj, self._data)
	end
end

return PinballTalentTabItem
