-- chunkname: @modules/logic/room/view/topright/RoomViewTopRightBaseItem.lua

module("modules.logic.room.view.topright.RoomViewTopRightBaseItem", package.seeall)

local RoomViewTopRightBaseItem = class("RoomViewTopRightBaseItem", LuaCompBase)

function RoomViewTopRightBaseItem:ctor(param)
	RoomViewTopRightBaseItem.super.ctor(self)

	self._param = param
	self._parent = self._param.parent
	self._index = self._param.index
end

function RoomViewTopRightBaseItem:init(go)
	self._bgType = 2
	self.go = go
	self._resourceItem = self:getUserDataTb_()
	self._resourceItem.go = self.go
	self._resourceItem.canvasGroup = self._resourceItem.go:GetComponent(typeof(UnityEngine.CanvasGroup))

	for i = 1, 2 do
		local bgGO = gohelper.findChild(self._resourceItem.go, "bg" .. i)

		gohelper.setActive(bgGO, i == self._bgType)
	end

	self._resourceItem.txtquantity = gohelper.findChildText(self._resourceItem.go, "txt_quantity")
	self._resourceItem.txtaddNum = gohelper.findChildText(self._resourceItem.go, "txt_quantity/txt_addNum")
	self._resourceItem.btnclick = gohelper.findChildButtonWithAudio(self._resourceItem.go, "btn_click")
	self._resourceItem.goflypos = gohelper.findChild(self._resourceItem.go, "go_flypos")
	self._resourceItem.goeffect = gohelper.findChild(self._resourceItem.go, "go_flypos/#flyvx")

	self._resourceItem.btnclick:AddClickListener(self._onClick, self)
	gohelper.setActive(self._resourceItem.go, true)
	gohelper.setActive(self._resourceItem.goflypos, true)
	gohelper.setActive(self._resourceItem.goeffect, false)
	gohelper.setActive(self._resourceItem.txtaddNum, false)

	self._canvasGroup = self.go:GetComponent(typeof(UnityEngine.CanvasGroup))

	if self._customOnInit then
		self:_customOnInit()
	end

	self:_refreshUI()
end

function RoomViewTopRightBaseItem:_setShow(isShow)
	gohelper.setActive(self.go, isShow)

	self._canvasGroup.alpha = isShow and 1 or 0
	self._canvasGroup.blocksRaycasts = isShow
end

function RoomViewTopRightBaseItem:_customOnInit()
	return
end

function RoomViewTopRightBaseItem:_onClick()
	return
end

function RoomViewTopRightBaseItem:addEventListeners()
	return
end

function RoomViewTopRightBaseItem:removeEventListeners()
	return
end

function RoomViewTopRightBaseItem:_refreshUI()
	return
end

function RoomViewTopRightBaseItem:onDestroy()
	self._resourceItem.btnclick:RemoveClickListener()

	if self._customOnDestory then
		self:_customOnDestory()
	end
end

function RoomViewTopRightBaseItem:_customOnDestory()
	return
end

return RoomViewTopRightBaseItem
