-- chunkname: @modules/logic/room/entity/comp/RoomVehicleFollowPathData.lua

module("modules.logic.room.entity.comp.RoomVehicleFollowPathData", package.seeall)

local RoomVehicleFollowPathData = class("RoomVehicleFollowPathData")

function RoomVehicleFollowPathData:ctor(maxDistance)
	self._pathPosList = {}
	self._pathDisList = {}
	self._pathPosDistance = 0
	self._maxDistance = 5
end

function RoomVehicleFollowPathData:setMaxDistance(maxDistance)
	self._maxDistance = maxDistance or 3
end

function RoomVehicleFollowPathData:getMaxDistance()
	return self._maxDistance
end

function RoomVehicleFollowPathData:clear()
	if #self._pathPosList > 0 then
		self._pathPosList = {}
		self._pathDisList = {}
		self._pathPosDistance = 0
	end
end

function RoomVehicleFollowPathData:addPathPos(pos)
	if #self._pathPosList > 0 then
		local dis = Vector3.Distance(self._pathPosList[1], pos)

		table.insert(self._pathDisList, 1, dis)

		self._pathPosDistance = self._pathPosDistance + dis
	end

	table.insert(self._pathPosList, 1, pos)
	self:_checkPath()
end

function RoomVehicleFollowPathData:getPosByDistance(distance)
	if distance >= self._pathPosDistance then
		return self:getLastPos()
	elseif distance <= 0 then
		return self:getFirstPos()
	end

	local moveDis = 0 + distance

	for i, dis in ipairs(self._pathDisList) do
		if dis == moveDis then
			return self._pathPosList[i + 1]
		elseif moveDis < dis then
			return Vector3.Lerp(self._pathPosList[i], self._pathPosList[i + 1], moveDis / dis)
		end

		moveDis = moveDis - dis
	end

	return self:getLastPos()
end

function RoomVehicleFollowPathData:_checkPath()
	if self._pathPosDistance < self._maxDistance or #self._pathDisList < 2 then
		return
	end

	for i = #self._pathDisList, 2, -1 do
		local lastDis = self._pathDisList[#self._pathDisList]

		if self._pathPosDistance - lastDis > self._maxDistance then
			self._pathPosDistance = self._pathPosDistance - lastDis

			table.remove(self._pathDisList, #self._pathDisList)
			table.remove(self._pathPosList, #self._pathPosList)
		else
			break
		end
	end
end

function RoomVehicleFollowPathData:getPathDistance()
	return self._pathPosDistance
end

function RoomVehicleFollowPathData:getPosCount()
	return #self._pathPosList
end

function RoomVehicleFollowPathData:getFirstPos()
	return self._pathPosList[1]
end

function RoomVehicleFollowPathData:getLastPos()
	return self._pathPosList[#self._pathPosList]
end

return RoomVehicleFollowPathData
