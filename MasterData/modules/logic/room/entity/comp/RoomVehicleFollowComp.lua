-- chunkname: @modules/logic/room/entity/comp/RoomVehicleFollowComp.lua

module("modules.logic.room.entity.comp.RoomVehicleFollowComp", package.seeall)

local RoomVehicleFollowComp = class("RoomVehicleFollowComp", LuaCompBase)

function RoomVehicleFollowComp:ctor(entity)
	self.entity = entity
	self._followerList = {}
	self._forwardList = {}
	self._backwardList = {}
	self._initPosList = {}
	self._isForward = true
	self._pathData = RoomVehicleFollowPathData.New()
	self._isNight = RoomWeatherModel.instance:getIsNight()
end

function RoomVehicleFollowComp:init(go)
	self.go = go
	self.targetTrs = self.go.transform

	self:_initPathList()
end

function RoomVehicleFollowComp:_initPathList()
	self._initPosList = {}
	self._lookAtPos = nil

	local mo = self.entity:getVehicleMO()

	if not mo then
		return
	end

	local areaNodes = {}

	tabletool.addValues(areaNodes, mo:getInitAreaNode())

	if #areaNodes < 2 then
		return
	end

	table.insert(self._initPosList, self:_getPostionByNode(areaNodes[1], 0))

	for i = 2, #areaNodes do
		local curNode = areaNodes[i - 1]
		local nextNode = areaNodes[i]
		local curExitDire, nextEnterDire = self:_findConnectDirection(curNode, nextNode)

		if curNode then
			if i == 2 and nextEnterDire then
				self._lookAtPos = self:_getPostionByNode(curNode, nextEnterDire)
			end

			table.insert(self._initPosList, self:_getPostionByNode(curNode, curExitDire or 0))
		end

		if nextNode then
			table.insert(self._initPosList, self:_getPostionByNode(nextNode, nextEnterDire or 0))

			if i == #areaNodes and curExitDire then
				table.insert(self._initPosList, self:_getPostionByNode(nextNode, curExitDire or 0))
			end
		end
	end
end

function RoomVehicleFollowComp:_findConnectDirection(curNode, nextNode)
	local px = nextNode.hexPoint.x - curNode.hexPoint.x
	local py = nextNode.hexPoint.y - curNode.hexPoint.y

	for curExitDire = 1, 6 do
		local hexPoint = HexPoint.directions[curExitDire]

		if hexPoint.x == px and hexPoint.y == py then
			local nextEnterDire = curNode:getConnectDirection(curExitDire)

			return curExitDire, nextEnterDire
		end
	end
end

function RoomVehicleFollowComp:_getPostionByNode(curNode, direction, offset)
	local position = (not direction or direction == 0) and HexMath.hexToPosition(curNode.hexPoint, RoomBlockEnum.BlockSize) or HexMath.resourcePointToPosition(ResourcePoint.New(curNode.hexPoint, direction), RoomBlockEnum.BlockSize, offset or 0.4)

	return Vector3(position.x, RoomBuildingEnum.VehicleInitOffestY, position.y)
end

function RoomVehicleFollowComp:addEventListeners()
	RoomMapController.instance:registerCallback(RoomEvent.MapEntityNightLight, self._onNightLight, self)
end

function RoomVehicleFollowComp:removeEventListeners()
	RoomMapController.instance:unregisterCallback(RoomEvent.MapEntityNightLight, self._onNightLight, self)
end

function RoomVehicleFollowComp:stop()
	return
end

function RoomVehicleFollowComp:_onNightLight(isNight)
	if isNight ~= nil and self._isNight ~= isNight then
		self._isNight = isNight

		self:updateNight(isNight)
	end
end

function RoomVehicleFollowComp:updateNight(isNight)
	for i = 1, #self._followerList do
		self._followerList[i]:nightLight(isNight)
	end
end

function RoomVehicleFollowComp:restart()
	if #self._followerList < 2 then
		return
	end

	self._pathData:clear()

	if self._lookAtPos then
		self.targetTrs:LookAt(self._lookAtPos)
	end

	for i = #self._initPosList, 1, -1 do
		self._pathData:addPathPos(self._initPosList[i])
	end

	for i = 1, #self._followerList do
		self._followerList[i]:moveByPathData()
	end
end

function RoomVehicleFollowComp:getVehicleMO()
	return self.entity:getVehicleMO()
end

function RoomVehicleFollowComp:getSeeker()
	return self._seeker
end

function RoomVehicleFollowComp:beforeDestroy()
	TaskDispatcher.cancelTask(self._followerRebuild, self)

	if #self._followerList > 0 then
		for i = 1, #self._followerList do
			gohelper.destroy(self._followerList[i].go)
			self._followerList[i]:dispose()
		end

		self._followerList = {}
	end
end

function RoomVehicleFollowComp:_initFollower(cfg, vehicleGO)
	if not cfg or string.nilorempty(cfg.followNodePathStr) or gohelper.isNil(vehicleGO) then
		return
	end

	local names = string.split(cfg.followNodePathStr, "#")
	local radius = string.splitToNumber(cfg.followRadiusStr, "#")
	local rotates = string.splitToNumber(cfg.followRotateStr, "#")

	if not names or #names < 2 then
		return
	end

	local followDistance = 0

	for i, name in ipairs(names) do
		local tempGO = gohelper.findChild(vehicleGO, name)

		if not gohelper.isNil(tempGO) then
			local follower = RoomVehicleFollower.New(self)
			local go = gohelper.create3d(self.go, name)

			follower:init(go, radius[i], followDistance, name, rotates[i])
			table.insert(self._followerList, follower)
		end
	end

	self:_refreshFollowDistance()
	tabletool.addValues(self._forwardList, self._followerList)

	for i, follower in ipairs(self._followerList) do
		table.insert(self._backwardList, 1, follower)
	end

	self:restart()
end

function RoomVehicleFollowComp:addFollerPathPos(x, y, z)
	if #self._followerList > 0 then
		local toPos = Vector3(x, y, z)

		self._pathData:addPathPos(toPos)
	end
end

function RoomVehicleFollowComp:_addFollerPathPos(x, y, z)
	if #self._followerList > 0 then
		local toPos = Vector3(x, y, z)

		for i = 2, #self._followerList do
			self._followerList[i]:addPathPos(toPos)
		end
	end
end

function RoomVehicleFollowComp:updateFollower()
	if #self._followerList > 0 then
		for i = 2, #self._followerList do
			self._followerList[i]:moveByPathData()
		end

		if self._isNeedUpdateForward then
			self._isNeedUpdateForward = false

			for i = 1, #self._followerList do
				self._followerList[i]:setVehiceForward(self._isForward)
			end
		end
	end
end

function RoomVehicleFollowComp:getPathData()
	return self._pathData
end

function RoomVehicleFollowComp:_followerRebuild()
	if not self._initCloneFollowerFinish and self.entity.effect:isHasEffectGOByKey(RoomEnum.EffectKey.VehicleGOKey) then
		self._initCloneFollowerFinish = true

		local mo = self:getVehicleMO()
		local vehicleCfg = mo and mo:getReplaceDefideCfg()
		local vehicleGO = self.entity.effect:getEffectGO(RoomEnum.EffectKey.VehicleGOKey)

		self:_initFollower(vehicleCfg, vehicleGO)

		for i, follower in ipairs(self._followerList) do
			follower:onEffectRebuild()
		end

		self.entity.effect:setActiveByKey(RoomEnum.EffectKey.VehicleGOKey, #self._followerList < 1)
		self:updateNight(self._isNight)
	end
end

function RoomVehicleFollowComp:setShow(isShow)
	if #self._followerList > 0 then
		for i = 1, #self._followerList do
			gohelper.setActive(self._followerList[i].go, isShow)
		end
	end
end

function RoomVehicleFollowComp:turnAround()
	if #self._followerList < 2 then
		return
	end

	self._isForward = self._isForward ~= true
	self._isNeedUpdateForward = true

	local mo = self.entity:getVehicleMO()

	if mo then
		local areaNodes = {}

		tabletool.addValues(areaNodes, mo:getAreaNode())

		local px, py, pz = transformhelper.getPos(self._followerList[#self._followerList].goTrs)
		local hexPoint, direction = HexMath.positionToRoundHex(Vector2(px, pz), RoomBlockEnum.BlockSize)
		local node = mo.pathPlanMO:getNode(hexPoint)

		if node and not tabletool.indexOf(areaNodes, node) then
			table.insert(areaNodes, node)
		end

		if #areaNodes > 1 then
			for i = 2, #areaNodes do
				local curNode = areaNodes[i - 1]
				local nextNode = areaNodes[i]

				for enterDire = 1, 6 do
					if nextNode:getConnctNode(enterDire) == curNode then
						mo:moveToNode(nextNode, enterDire)

						break
					end
				end
			end
		end
	end

	self._pathData:clear()

	local followerCount = #self._followerList
	local parentTrs = self.targetTrs.parent

	for i = 1, followerCount do
		local follower = self._followerList[i]
		local px, py, pz = transformhelper.getPos(follower.goTrs)

		self._pathData:addPathPos(Vector3(px, py, pz))
		follower.goTrs:SetParent(parentTrs)

		if i == followerCount then
			transformhelper.setPos(self.targetTrs, px, py, pz)

			self.targetTrs.rotation = follower.goTrs.rotation

			follower.goTrs:SetParent(self.targetTrs)
		end
	end

	if self._isForward then
		self._followerList = self._forwardList or self._backwardList
	end

	self:_refreshFollowDistance()

	return true
end

function RoomVehicleFollowComp:_refreshFollowDistance()
	local distance = 0

	for i = 1, #self._followerList do
		local follower = self._followerList[i]

		if i > 1 then
			local parentwer = self._followerList[i - 1]

			distance = distance + parentwer.radius + follower.radius
		end

		follower.followDistance = distance
	end
end

function RoomVehicleFollowComp:onEffectRebuild()
	if not self._initCloneFollowerFinish then
		TaskDispatcher.cancelTask(self._followerRebuild, self)
		TaskDispatcher.runDelay(self._followerRebuild, self, 0.1)
	end
end

return RoomVehicleFollowComp
