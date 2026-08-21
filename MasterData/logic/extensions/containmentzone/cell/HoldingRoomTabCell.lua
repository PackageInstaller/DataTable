-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/containmentzone/cell/HoldingRoomTabCell.lua

module("logic.extensions.containmentzone.cell.HoldingRoomTabCell", package.seeall)

local M = class("HoldingRoomTabCell", UIReusableLuaBehavior)

function M:buildUI()
	self._txtRoomName = goutil.findChildTextComponent(self.mainGO, "normal/Text")
	self._txtRoomName2 = goutil.findChildTextComponent(self.mainGO, "select/Text")
	self._goLockMark = goutil.findChild(self.mainGO, "normal/lockDi").gameObject
	self._goLockMark2 = goutil.findChild(self.mainGO, "normal/lock").gameObject
	self._goRedPoint = goutil.findChild(self.mainGO, "red_point").gameObject
end

function M:destroyUI()
	self._txtRoomName = nil
	self._txtRoomName2 = nil
	self._goLockMark = nil
	self._goLockMark2 = nil
	self._goRedPoint = nil
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:onEnter()
	return
end

function M:onExit()
	return
end

function M:setRoomId(roomId)
	self._roomId = roomId
end

function M:getRoomId()
	return self._roomId
end

function M:setName(content)
	self._txtRoomName.text = content
	self._txtRoomName2.text = content
end

function M:setLockMarkShow(show)
	goutil.setActive(self._goLockMark, show)
	goutil.setActive(self._goLockMark2, show)
end

function M:setRedPoint(num)
	if num <= 0 then
		goutil.setActive(self._goRedPoint, false)

		return
	end

	goutil.setActive(self._goRedPoint, true)
end

return M
