-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/scene/unit/component/room/UnitCompRoomFocusCollider.lua

module("logic.extensions.house.scene.unit.component.room.UnitCompRoomFocusCollider", package.seeall)

local M = class("UnitCompRoomFocusCollider", UnitComponentBase)

function M:ctor(unit)
	M.super.ctor(self, unit)
end

function M:onInit()
	return
end

function M:onLateInit()
	self:_initColliderGO()
end

function M:onReuse()
	return
end

function M:onReset()
	self:_clearColliderGO()
end

function M:onDestroy()
	self:onReset()
end

function M:_initColliderGO()
	self:_setEvents(true)

	local goParent = self._unit:getParentGO()

	self._goColliderForFocusRoom = goutil.findChild(goParent, "collider")

	if self._goColliderForFocusRoom == nil then
		printError("无法找到房间碰撞体 ", goParent.name)
	end
end

function M:_clearColliderGO()
	self:_setEvents(false)

	self._goColliderForFocusRoom = nil
end

function M:_setEvents(isOn)
	if isOn then
		HouseDispatcher:addEventListener(HouseEventType.ON_FOCUS_ROOM_EXIST, self._handleOnFocusRoomExist, self)
		HouseDispatcher:addEventListener(HouseEventType.ON_FOCUS_ROOM_ENTER, self._handleOnFocusRoomEnter, self)
	else
		HouseDispatcher:removeEventListener(HouseEventType.ON_FOCUS_ROOM_EXIST, self._handleOnFocusRoomExist, self)
		HouseDispatcher:removeEventListener(HouseEventType.ON_FOCUS_ROOM_ENTER, self._handleOnFocusRoomEnter, self)
	end
end

function M:_handleOnFocusRoomExist()
	self:_setColliderShow(true)
end

function M:_handleOnFocusRoomEnter(e, roomId)
	if self._unit.model:getRoomId() == roomId then
		self:_setColliderShow(false)
	end
end

function M:_setColliderShow(show)
	if self._goColliderForFocusRoom then
		goutil.setActive(self._goColliderForFocusRoom, show)
	end
end

return M
