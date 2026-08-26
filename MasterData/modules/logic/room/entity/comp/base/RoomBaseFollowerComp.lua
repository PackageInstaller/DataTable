-- chunkname: @modules/logic/room/entity/comp/base/RoomBaseFollowerComp.lua

module("modules.logic.room.entity.comp.base.RoomBaseFollowerComp", package.seeall)

local RoomBaseFollowerComp = class("RoomBaseFollowerComp", LuaCompBase)

function RoomBaseFollowerComp:ctor(entity)
	self.entity = entity
	self._isMoveing = false
end

function RoomBaseFollowerComp:init(go)
	return
end

function RoomBaseFollowerComp:getFollowPathData()
	self._followPathData = self._followPathData or RoomVehicleFollowPathData.New()

	return self._followPathData
end

function RoomBaseFollowerComp:setFollowPath(followPathComp)
	if self._followPathComp == followPathComp then
		return
	end

	if self._followPathComp then
		self._followPathComp:removeFollower(self)

		self._followPathComp = nil
	end

	if followPathComp then
		followPathComp:addFollower(self)

		self._followPathComp = followPathComp
	end

	self:stopMove()
end

function RoomBaseFollowerComp:clearFollowPath()
	self:setFollowPath(nil)
end

function RoomBaseFollowerComp:stopMove()
	if self._isMoveing then
		self._isMoveing = false

		self:onStopMove()
	end
end

function RoomBaseFollowerComp:moveByPathData()
	if self.__willDestroy or not self._followPathComp or self._followPathComp:isWillDestory() then
		return
	end

	if not self._isMoveing then
		self._isMoveing = true

		self:onStartMove()
	end

	self:onMoveByPathData(self:getFollowPathData())
end

function RoomBaseFollowerComp:addPathPos(pos)
	if not self.__willDestroy then
		local pathData = self:getFollowPathData()

		pathData:addPathPos(pos)
	end
end

function RoomBaseFollowerComp:onMoveByPathData(pathData)
	return
end

function RoomBaseFollowerComp:onStopMove()
	return
end

function RoomBaseFollowerComp:onStartMove()
	return
end

function RoomBaseFollowerComp:isWillDestory()
	return self.__willDestroy
end

function RoomBaseFollowerComp:beforeDestroy()
	self.__willDestroy = true

	self:clearFollowPath()
end

return RoomBaseFollowerComp
