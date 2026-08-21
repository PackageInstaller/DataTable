-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/model/navigation/HouseNavigationMO.lua

module("logic.extensions.house.model.navigation.HouseNavigationMO", package.seeall)

local M = class("HouseNavigationMO")

function M:ctor(CO)
	self._zoneCO = CO
	self._patrolPoints = {}
	self._dictPointUser = {}
	self._emptyPointIndexs = {}
	self._leftBorderPos = nil
	self._rightBorderPos = nil
	self._leftSuitPos = nil
	self._rightSuitPos = nil
	self._leftLink = nil
	self._rightLink = nil
	self._goodsCreatePos = nil
	self._goodsReturnPos = nil
	self._workPoints = {}
	self._usableWorkPointIndexs = {}
	self._workPointWeights = nil
	self._pointDefaultWeight = nil
	self._pointDecreaseWeight = nil
end

function M:setPatrolPoints(points)
	self._patrolPoints = points
	self._dictPointUser = {}
	self._emptyPointIndexs = {}

	for idx, point in ipairs(self._patrolPoints) do
		table.insert(self._emptyPointIndexs, idx)
	end
end

function M:getPatrolPoints()
	return self._patrolPoints
end

function M:getRandomPoint()
	if #self._emptyPointIndexs > 0 then
		local idx = math.random(1, #self._emptyPointIndexs)
		local pointIdx = self._emptyPointIndexs[idx]

		return self._patrolPoints[pointIdx], pointIdx
	end

	printWarn("区域内所有的巡逻点都被占用，id：", self:getZoneId())
end

function M:usePoint(idx, heroId)
	self._dictPointUser[idx] = heroId

	self:_removeEmptyPoint(idx)
end

function M:releasePoint(idx, heroId)
	if self._dictPointUser[idx] == heroId then
		self._dictPointUser[idx] = nil

		self:_addEmptyPoint(idx)
	end
end

function M:_removeEmptyPoint(idx)
	table.removebyvalue(self._emptyPointIndexs, idx)
end

function M:_addEmptyPoint(idx)
	if not table.indexof(self._emptyPointIndexs, idx) then
		table.insert(self._emptyPointIndexs, idx)
	end
end

function M:getPatrolpointKey()
	return self._zoneCO.navPatrolpointKey
end

function M:getSurfaceGoName()
	return self._zoneCO.navGoName
end

function M:getZoneId()
	return self._zoneCO.id
end

function M:setNavGoAngle(angle)
	self._navGoAngle = angle
end

function M:getAngle()
	return self._zoneCO.angle
end

function M:setLeftBorderPos(pos)
	self._leftBorderPos = pos
end

function M:getLeftBorderPos()
	return self._leftBorderPos
end

function M:setRightBorderPos(pos)
	self._rightBorderPos = pos
end

function M:getRightBorderPos()
	return self._rightBorderPos
end

function M:setLeftSuitPos(pos)
	self._leftSuitPos = pos
end

function M:getLeftSuitPos()
	return self._leftSuitPos
end

function M:setRightSuitPos(pos)
	self._rightSuitPos = pos
end

function M:getRightSuitPos()
	return self._rightSuitPos
end

function M:setCreateGoodsPos(pos)
	self._goodsCreatePos = pos
end

function M:getCreateGoodsPos()
	return self._goodsCreatePos
end

function M:setReturnGoodsPos(pos)
	self._goodsReturnPos = pos
end

function M:getReturnGoodsPos()
	return self._goodsReturnPos
end

function M:setLeftLink(link)
	self._leftLink = link
end

function M:getLeftLink()
	return self._leftLink
end

function M:setRightLink(link)
	self._rightLink = link
end

function M:getRightLink()
	return self._rightLink
end

function M:setWorkPoints(points)
	self._workPoints = points

	for idx, _ in pairs(points) do
		table.insert(self._usableWorkPointIndexs, idx)
	end

	self:_initWorkPointWeight(self._workPoints)
end

function M:_initWorkPointWeight(workPoints)
	self._pointDefaultWeight = HouseConfig.instance:getHouseConst("WorkPointWeight").numValue
	self._pointDecreaseWeight = HouseConfig.instance:getHouseConst("WorkPointDecreaseWeight").numValue
	self._workPointWeights = {}

	for _ = 1, #workPoints do
		table.insert(self._workPointWeights, self._pointDefaultWeight)
	end
end

function M:_useWorkPoint(idx)
	self:_removeUsableWorkPoint(idx)

	local weight = self._workPointWeights[idx] - self._pointDecreaseWeight

	self._workPointWeights[idx] = weight <= 0 and self._pointDefaultWeight or weight
end

function M:_removeUsableWorkPoint(idx)
	table.removebyvalue(self._usableWorkPointIndexs, idx)
end

function M:releaseWorkPoint(idx)
	if idx and not table.indexof(self._usableWorkPointIndexs, idx) then
		table.insert(self._usableWorkPointIndexs, idx)
	end
end

function M:rollUsableWorkPoint()
	local point, pointIdx
	local totalWeight = 0

	for _, idx in pairs(self._usableWorkPointIndexs) do
		totalWeight = totalWeight + self._workPointWeights[idx]
	end

	local randomNum = math.random(1, totalWeight)
	local calculWeight = 0

	for _, idx in pairs(self._usableWorkPointIndexs) do
		calculWeight = calculWeight + self._workPointWeights[idx]

		if randomNum <= calculWeight then
			pointIdx = idx
			point = self._workPoints[idx]

			self:_useWorkPoint(idx)

			break
		end
	end

	if point == nil then
		printError("none of work point is available")
	end

	return point, pointIdx
end

return M
