-- chunkname: @modules/logic/room/entity/RoomBuildingOccupyEntity.lua

module("modules.logic.room.entity.RoomBuildingOccupyEntity", package.seeall)

local RoomBuildingOccupyEntity = class("RoomBuildingOccupyEntity", RoomBaseEntity)

function RoomBuildingOccupyEntity:ctor(entityId)
	RoomBuildingOccupyEntity.super.ctor(self)

	self.id = entityId
	self.entityId = self.id
end

function RoomBuildingOccupyEntity:getTag()
	return SceneTag.Untagged
end

function RoomBuildingOccupyEntity:init(go)
	self.goTrs = go.transform
	self.containerGO = gohelper.create3d(go, RoomEnum.EntityChildKey.ContainerGOKey)
	self.staticContainerGO = gohelper.create3d(go, RoomEnum.EntityChildKey.StaticContainerGOKey)

	RoomBuildingOccupyEntity.super.init(self, go)

	self._scene = GameSceneMgr.instance:getCurScene()
end

function RoomBuildingOccupyEntity:initComponents()
	self:addComp("effect", RoomEffectComp)
end

function RoomBuildingOccupyEntity:onStart()
	RoomBuildingOccupyEntity.super.onStart(self)
end

function RoomBuildingOccupyEntity:onEffectRebuild()
	return
end

function RoomBuildingOccupyEntity:_isShowNeighbor(x, y)
	local param = RoomMapBuildingModel.instance:getTempBuildingParam(x, y)

	if param then
		return false
	end

	return true
end

function RoomBuildingOccupyEntity:_getContainerGO(isJudge)
	if isJudge then
		return self.containerGO
	end

	return self.staticContainerGO
end

function RoomBuildingOccupyEntity:_refreshNeighbor(isJudge, blockRotate, hexPoint)
	if isJudge then
		if not RoomEnum.EffectKey.BuildingOccupyCanSideKeys then
			local tempKeys = RoomEnum.EffectKey.BuildingOccupyNotSideKeys

			for i = 1, 6 do
				local neighbor = HexPoint.directions[i]
				local isActive = self:_isShowNeighbor(neighbor.x + hexPoint.x, neighbor.y + hexPoint.y)
				local dkey = tempKeys[i]

				if isActive and not self.effect:isHasEffectGOByKey(dkey) then
					local var_9_1 = {}
					local var_9_2 = {}

					if isJudge then
						var_9_2.res = RoomScenePreloader.ResEffectF or RoomScenePreloader.ResEffectE
					end

					var_9_2.containerGO = self:_getContainerGO(isJudge)
					var_9_2.localRotation = Vector3(0, (i - 1 + 3) * 60, 0)
					var_9_1[dkey] = var_9_2

					self.effect:addParams(var_9_1)
				end

				self.effect:setActiveByKey(dkey, isActive)
			end
		end
	end
end

function RoomBuildingOccupyEntity:_refreshOccupy(isJudge)
	if isJudge then
		if not RoomEnum.EffectKey.BuildingOccupyCanJudgeKey then
			local judgKey = RoomEnum.EffectKey.BuildingOccupyNotJudgeKey

			if not self.effect:isHasKey(judgKey) then
				local var_10_1 = {}
				local var_10_2 = {}

				if isJudge then
					var_10_2.res = RoomScenePreloader.ResEffectD01 or RoomScenePreloader.ResEffectD02
				end

				var_10_2.containerGO = self:_getContainerGO(isJudge)
				var_10_1[judgKey] = var_10_2

				self.effect:addParams(var_10_1)
			end
		end
	end
end

function RoomBuildingOccupyEntity:_isJudge(x, y, buildingAreaSuccess)
	if buildingAreaSuccess == false then
		return false
	end

	local blockMO = RoomMapBlockModel.instance:getBlockMO(x, y)

	if blockMO then
		return RoomBuildingHelper.isJudge(blockMO.hexPoint, blockMO.id)
	end

	return false
end

function RoomBuildingOccupyEntity:refreshTempOccupy()
	local buildingParam = self:getBuildingParam()

	if (buildingParam or nil) and RoomMapBuildingModel.instance:isTempOccupy(buildingParam.hexPoint) then
		local isJudge = self:_isJudge(buildingParam.hexPoint.x, buildingParam.hexPoint.y, buildingParam.checkBuildingAreaSuccess)

		if self._lastIsJudge ~= isJudge then
			self._lastIsJudge = isJudge

			gohelper.setActive(self.containerGO, isJudge)
			gohelper.setActive(self.staticContainerGO, not isJudge)
		end

		self:_refreshNeighbor(isJudge, buildingParam.blockRotate, buildingParam.hexPoint)
		self:_refreshOccupy(isJudge)

		local position = HexMath.hexToPosition(buildingParam.hexPoint, RoomBlockEnum.BlockSize)

		transformhelper.setLocalPos(self.goTrs, position.x, 0, position.y)
	elseif self._lastIsJudge ~= nil then
		self._lastIsJudge = nil

		gohelper.setActive(self.containerGO, false)
		gohelper.setActive(self.staticContainerGO, false)
	end

	self.effect:refreshEffect()
end

function RoomBuildingOccupyEntity:getBuildingParam()
	return RoomMapBuildingModel.instance:getTempBuildingParamByPointIndex(self.id)
end

function RoomBuildingOccupyEntity:getMO()
	return RoomMapBuildingModel.instance:getTempBuildingMO()
end

return RoomBuildingOccupyEntity
