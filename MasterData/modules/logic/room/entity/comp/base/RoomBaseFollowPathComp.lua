-- chunkname: @modules/logic/room/entity/comp/base/RoomBaseFollowPathComp.lua

module("modules.logic.room.entity.comp.base.RoomBaseFollowPathComp", package.seeall)

local RoomBaseFollowPathComp = class("RoomBaseFollowPathComp", LuaCompBase)

function RoomBaseFollowPathComp:ctor(entity)
	self.entity = entity
	self._tbFollowerList = {}
	self._tbPools = {}
	self._isMoveing = false
end

function RoomBaseFollowPathComp:addPathPos(pos)
	local count = #self._tbFollowerList

	for i = count, 1, -1 do
		local tb = self._tbFollowerList[i]

		if tb.follower then
			tb.follower:addPathPos(pos)
		else
			self:_push(tb)
			table.remove(self._tbFollowerList, i)
		end
	end
end

function RoomBaseFollowPathComp:addFollower(followerComp)
	if self.__willDestroy or not followerComp or followerComp:isWillDestory() then
		return
	end

	if not self:_findIndexOf(followerComp) then
		local tb = self:_pop(followerComp)

		table.insert(self._tbFollowerList, tb)
		followerComp:setFollowPath(self)
	end
end

function RoomBaseFollowPathComp:removeFollower(followerComp)
	if followerComp and #self._tbFollowerList > 0 then
		local index = tabletool.indexOf(self._tbFollowerList, followerComp)

		if index then
			self._tbFollowerList[index].follower = nil

			followerComp:clearFollowPath()
		end
	end
end

function RoomBaseFollowPathComp:_pop(followerComp)
	local tb

	if #self._tbPools > 0 then
		tb = self._tbPools[#self._tbPools]

		table.remove(self._tbPools, #self._tbPools)
	else
		tb = {}
	end

	tb.follower = followerComp

	return tb
end

function RoomBaseFollowPathComp:_push(tb)
	if tb then
		tb.follower = nil

		table.insert(self._tbPools, tb)
	end
end

function RoomBaseFollowPathComp:_findIndexOf(followerComp)
	local count = #self._tbFollowerList

	for i = 1, count do
		if self._tbFollowerList[i].follower == followerComp then
			return i
		end
	end
end

function RoomBaseFollowPathComp:stopMove()
	local count = #self._tbFollowerList

	for i = count, 1, -1 do
		local tb = self._tbFollowerList[i]

		if tb.follower then
			tb.follower:stopMove()
		else
			self:_push(tb)
			table.remove(self._tbFollowerList, i)
		end
	end

	self._isMoveing = false

	self:onStopMove()
end

function RoomBaseFollowPathComp:moveByPathData()
	if not self._isMoveing then
		self._isMoveing = true

		self:onStartMove()
	end

	local count = #self._tbFollowerList

	for i = count, 1, -1 do
		local tb = self._tbFollowerList[i]

		if tb.follower then
			tb.follower:moveByPathData()
		else
			self:_push(tb)
			table.remove(self._tbFollowerList, i)
		end
	end
end

function RoomBaseFollowPathComp:getCount()
	return #self._tbFollowerList
end

function RoomBaseFollowPathComp:onStopMove()
	return
end

function RoomBaseFollowPathComp:onStartMove()
	return
end

function RoomBaseFollowPathComp:isWillDestory()
	return self.__willDestroy
end

function RoomBaseFollowPathComp:beforeDestroy()
	self.__willDestroy = true

	if self._tbFollowerList and #self._tbFollowerList > 0 then
		local tbList = self._tbFollowerList

		self._tbFollowerList = {}

		for i, tb in ipairs(tbList) do
			if tb.follower then
				tb.follower:clearFollowPath()
			end
		end
	end
end

return RoomBaseFollowPathComp
