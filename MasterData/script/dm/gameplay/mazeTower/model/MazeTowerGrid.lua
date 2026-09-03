-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/mazeTower/model/MazeTowerGrid.lua

MazeTowerGrid = class("MazeTowerGrid", objectlua.Object, _M)

MazeTowerGrid:has("_status", {
	is = "rw"
})
MazeTowerGrid:has("_x", {
	is = "rw"
})
MazeTowerGrid:has("_y", {
	is = "rw"
})
MazeTowerGrid:has("_eventId", {
	is = "rw"
})
MazeTowerGrid:has("_isBlock", {
	is = "rw"
})
MazeTowerGrid:has("_type", {
	is = "rw"
})

function MazeTowerGrid:initialize()
	super.initialize(self)

	self._status = 0
	self._x = 0
	self._y = 0
	self._eventId = ""
	self._isBlock = false
	self._type = 1
end

function MazeTowerGrid:synchronize(data)
	dump(data, "data-___MazeTowerGrid")

	if not data then
		return
	end

	if data.status then
		self._status = data.status
	end

	if data.x then
		self._x = data.x
	end

	if data.y then
		self._y = data.y
	end

	if data.eventId then
		self._eventId = data.eventId
	end

	if data.isBlock ~= nil then
		self._isBlock = data.isBlock
	end

	if data.type then
		self._type = data.type
	end
end

function MazeTowerGrid:isHasUnFinishEvent()
	if self._eventId ~= "" and self._status == 0 then
		return true
	end

	return false
end

function MazeTowerGrid:getElementConfig()
	local elementConfig = ConfigReader:getRecordById("MazeElement", self._eventId)

	return elementConfig or {}
end
