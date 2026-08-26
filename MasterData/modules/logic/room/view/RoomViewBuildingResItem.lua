-- chunkname: @modules/logic/room/view/RoomViewBuildingResItem.lua

module("modules.logic.room.view.RoomViewBuildingResItem", package.seeall)

local RoomViewBuildingResItem = class("RoomViewBuildingResItem", LuaCompBase)

function RoomViewBuildingResItem:init(go)
	self._go = go
	self._goselect = gohelper.findChild(self._go, "go_select")
	self._gounselect = gohelper.findChild(self._go, "go_unselect")
	self._goline = gohelper.findChild(self._go, "go_line")
	self._txt1 = gohelper.findChildText(self._go, "go_select/txt")
	self._txt2 = gohelper.findChildText(self._go, "go_unselect/txt")
	self._btnItem = SLFramework.UGUI.ButtonWrap.Get(self._go)

	self._btnItem:AddClickListener(self._btnitemOnClick, self)
end

function RoomViewBuildingResItem:removeEventListeners()
	self._btnItem:RemoveClickListener()

	self._callback = nil
	self._callbackObj = nil
end

function RoomViewBuildingResItem:_btnitemOnClick()
	if self._callback then
		if self._callbackObj ~= nil then
			self._callback(self._callbackObj, self._data)
		else
			self._callback(self._data)
		end
	end
end

function RoomViewBuildingResItem:getGO()
	return self._go
end

function RoomViewBuildingResItem:setCallback(callback, callbackObj)
	self._callback = callback
	self._callbackObj = callbackObj
end

function RoomViewBuildingResItem:setSelect(isSelect)
	if self._isSelect == isSelect then
		return
	end

	self._isSelect = not not isSelect

	gohelper.setActive(self._goselect, isSelect)
	gohelper.setActive(self._gounselect, not isSelect)
end

function RoomViewBuildingResItem:getData()
	return self._data
end

function RoomViewBuildingResItem:setData(data)
	if self._data ~= data then
		self._data = data

		self:_refreshUI()
	end
end

function RoomViewBuildingResItem:setLineActive(state)
	if state ~= null then
		gohelper.setActive(self._goline, state)
	end
end

function RoomViewBuildingResItem:_refreshUI()
	if self._data and self._txt1 then
		local nameStr = luaLang(self._data.nameLanguage)

		self._txt1.text = nameStr
		self._txt2.text = nameStr
	end
end

return RoomViewBuildingResItem
