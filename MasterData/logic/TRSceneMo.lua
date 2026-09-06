-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/treasureraider/model/mo/TRSceneMo.lua

module("logic.extensions.treasureraider.model.mo.TRSceneMo", package.seeall)

local TRSceneMo = tableMO()

function TRSceneMo:ctor()
	self.ownerId = nil
	self.buildingMap = {}
	self.ownerBuildingId2FormationMap = {}
	self.ownerPetMoMap = nil
	self.myPlayerMo = nil
	self.opPlayerMo = nil
	self.actionDone = nil
	self._produceStateMap = {}
end

function TRSceneMo:_checkProduce()
	if self.buildingMap then
		local nowMs = ServerTime.nowMs()

		for _, buildingMo in pairs(self.buildingMap) do
			local produce = buildingMo:getProduceCount(nowMs)

			if self._produceStateMap[buildingMo] or produce <= 0 then
				if self._produceStateMap[buildingMo] then
					local bChange = produce <= 0

					if bChange then
						self._produceStateMap[buildingMo] = produce > 0

						GlobalDispatcher:dispatch(GlobalNotify.TreasureRaiderBuildingProduceUpdated, self.ownerId, buildingMo.gridId)
					end
				end
			end
		end
	end
end

function TRSceneMo:updateByServerData(params, userId, isRevenge)
	self.ownerId = userId

	if LoginModel.instance.userId == userId then
		self.myPlayerMo = TreasureRaiderModel.instance.myPlayerMo

		self.myPlayerMo:updateByServerData(params)
		self:setActionDone(params.actionDone)

		self.opPlayerMo = nil
	else
		self.myPlayerMo = TreasureRaiderModel.instance.myPlayerMo:createGhostMo(isRevenge)

		self:setActionDone(true)
		self:setPetView(params.targetPetView)

		self.opPlayerMo = TROpPlayerMo.New()

		self.opPlayerMo:updateByServerData(params)
	end

	self:resetFormationMap(params.formList or {})
	self:updateBuildings(params.buildingGrids)
end

function TRSceneMo:setPetView(petView)
	self.ownerPetMoMap = {}

	for i, petInfo in ipairs(petView) do
		local petMo = BagPetMo.New()

		petMo:initBaseView(petInfo)

		self.ownerPetMoMap[petMo.petId] = petMo
	end
end

function TRSceneMo:isFormationEmpty(buildingId)
	local formation = self:getFormationByBuildingId(buildingId)

	if formation then
		local bEmpty = true

		for i, petId in ipairs(formation.pos) do
			if checknumber(petId) > 0 then
				bEmpty = false

				break
			end
		end

		return bEmpty
	else
		return true
	end
end

function TRSceneMo:getPetFromOwnerPetMoMap(petId)
	if self.ownerPetMoMap then
		return self.ownerPetMoMap[petId]
	end
end

function TRSceneMo:setActionDone(value)
	self.actionDone = value

	GlobalDispatcher:dispatch(GlobalNotify.TreasureRaiderServerActionDone, self.ownerId, self.actionDone)
end

function TRSceneMo:resetFormationMap(formList)
	self.ownerBuildingId2FormationMap = {}

	for _, v in ipairs(formList) do
		self.ownerBuildingId2FormationMap[v.cfgId] = v.form

		self:updateOneFormation(v.cfgId, v.form)
	end
end

function TRSceneMo:getFormationByBuildingId(buildingId)
	return self.ownerBuildingId2FormationMap[buildingId]
end

function TRSceneMo:getFormationLockPetIdMapWithoutBuildingId(buildingId)
	local result = {}

	for i, data in pairs(self.ownerBuildingId2FormationMap) do
		if checknumber(i) ~= checknumber(buildingId) and data and data.pos then
			for j, petId in ipairs(data.pos) do
				if checknumber(petId) > 0 then
					result[petId] = true
				end
			end
		end
	end

	return result
end

function TRSceneMo:updateOneFormation(buildingId, formation)
	self.ownerBuildingId2FormationMap[buildingId] = formation
end

function TRSceneMo:updateByAction(params, actionType)
	self:updateOneBuilding(params.buildingGrid)
	self:setActionDone(params.actionDone)
	self.myPlayerMo:updateBuff(params.extendBuff)

	if actionType == TreasureRaiderConst.ServerAction_Upgrade then
		local gridId = params.buildingGrid.gridId

		GlobalDispatcher:dispatch(GlobalNotify.TreasureRaiderBuildingUpgrade, self.ownerId, gridId)
	end
end

function TRSceneMo:updateOneBuilding(buildingGrid)
	local gridId = buildingGrid.gridId

	if not self.buildingMap[gridId] then
		local buildingMo = TRBuildingMo.New()

		self.buildingMap[gridId]:updateByServerData(buildingGrid)

		self.buildingMap[gridId] = self.buildingMap[gridId]

		GlobalDispatcher:dispatch(GlobalNotify.TreasureRaiderSingleBuildingUpdated, self.ownerId, self.buildingMap[gridId].gridId)
	end
end

function TRSceneMo:updateBuildings(buildings)
	self.buildingMap = {}

	for i, v in ipairs(buildings or {}) do
		local gridId = v.gridId

		if not self.buildingMap[gridId] then
			local buildingMo = TRBuildingMo.New()

			self.buildingMap[gridId]:updateByServerData(v)

			self.buildingMap[gridId] = self.buildingMap[gridId]
		end
	end

	GlobalDispatcher:dispatch(GlobalNotify.TreasureRaiderAllBuildingUpdated, self.ownerId)
end

function TRSceneMo:updateBuildingsByReplace(buildings)
	for _, v in ipairs(buildings or {}) do
		self:updateOneBuilding(v)
	end
end

function TRSceneMo:exchangeBuilding(fromGridId, toGridId)
	local newToMo = self.buildingMap[fromGridId]
	local newFromMo = self.buildingMap[toGridId]

	if newFromMo then
		newFromMo:updateGridIdOnly(fromGridId)

		self.buildingMap[fromGridId] = newFromMo
	else
		self.buildingMap[fromGridId] = nil
	end

	if newToMo then
		newToMo:updateGridIdOnly(toGridId)

		self.buildingMap[toGridId] = newToMo
	else
		self.buildingMap[toGridId] = nil
	end

	GlobalDispatcher:dispatch(GlobalNotify.TreasureRaiderBuildingExchange, fromGridId, toGridId)
	GlobalDispatcher:dispatch(GlobalNotify.TreasureRaiderSingleBuildingUpdated, self.ownerId, toGridId)
	GlobalDispatcher:dispatch(GlobalNotify.TreasureRaiderSingleBuildingUpdated, self.ownerId, fromGridId)
end

function TRSceneMo:resetBuilding(buildingMap)
	self.buildingMap = buildingMap

	for _, mo in pairs(self.buildingMap) do
		mo.__originMo = nil
	end

	GlobalDispatcher:dispatch(GlobalNotify.TreasureRaiderAllBuildingUpdated, self.ownerId)
end

function TRSceneMo:updateMainCampLevel(params)
	if params.level ~= nil then
		for _, buildingMo in pairs(self.buildingMap) do
			if buildingMo.buildingConfig.type == TreasureRaiderConst.BuildingType_MainCamp then
				buildingMo:updateLevel(params.level)
				GlobalDispatcher:dispatch(GlobalNotify.TreasureRaiderSingleBuildingUpdated, self.ownerId, buildingMo.gridId)

				return
			end
		end
	end
end

function TRSceneMo:isNeedShowNearEffect(gridX, gridY)
	if not self.myPlayerMo:isClientServerSameGrid() or self.actionDone or TREditorController.instance:isInState(TREditorController.EMode_EditorMode) then
		return false
	end

	local gridId = TreasureRaiderSceneModel.instance:grid2Id(gridX, gridY)

	if TreasureRaiderSceneModel.instance:isClosestByGridId(gridId, self.myPlayerMo.serverGridId) then
		local buildingMo = self:getBuildingMo(gridId)

		if self:isMyScene() then
			if buildingMo then
				local buildingConfig = TreasureRaiderConfig.instance:getBuildingConfig(buildingMo.buildingId)

				if TreasureRaiderConst.BuildingCanReconstructMap[buildingConfig.type] then
					return true
				end

				if TreasureRaiderSceneModel.instance:isBuildingCanUpgrade(buildingMo) then
					return true
				end
			else
				return true
			end
		elseif buildingMo then
			local buildingConfig = TreasureRaiderConfig.instance:getBuildingConfig(buildingMo.buildingId)

			if TreasureRaiderConst.BuildingCanBeAttackMap[buildingConfig.type] then
				return true
			else
				return false
			end
		else
			return false
		end
	end
end

function TRSceneMo:isMyScene()
	return self.ownerId == LoginModel.instance.userId
end

function TRSceneMo:getBuildingMo(gridId)
	return self.buildingMap[gridId]
end

function TRSceneMo:isHasBuildingMo(gridId)
	return self:getBuildingMo(gridId) ~= nil
end

function TRSceneMo:getBuildingId2MoArrayTempMap()
	local buildingId2ArrayMap = {}
	local buildingType2ArrayMap = {}
	local configInstance = TreasureRaiderConfig.instance

	for _, mo in pairs(self.buildingMap) do
		buildingId2ArrayMap[mo.buildingId] = buildingId2ArrayMap[mo.buildingId] or {}

		table.insert(buildingId2ArrayMap[mo.buildingId], mo)

		local config = configInstance:getBuildingConfig(mo.buildingId)

		buildingType2ArrayMap[config.type] = buildingType2ArrayMap[config.type] or {}

		table.insert(buildingType2ArrayMap[config.type], mo)
	end

	return buildingId2ArrayMap, buildingType2ArrayMap
end

function TRSceneMo:cloneBuildings()
	local buildingMap = {}

	for _, mo in pairs(self.buildingMap) do
		local cloneMo = mo:clone()

		buildingMap[cloneMo.gridId] = cloneMo
	end

	return buildingMap
end

function TRSceneMo:getBuildings()
	return self.buildingMap
end

function TRSceneMo:isCanDoActionIgnoreViewBuilding()
	local result = false

	if not self.actionDone then
		local array = TreasureRaiderSceneModel.instance:getCurGridNeighbourBuildingSlot(self.myPlayerMo.serverGridId)
		local controller = TRPopMenuController.instance

		for _, v in ipairs(array) do
			local opTypes = controller:getOpGroups(nil, nil, nil, nil, v[3])

			table.removebyvalue(opTypes, TRPopMenuController.Op_View)

			if #opTypes > 0 then
				result = true

				break
			end
		end
	end

	return result
end

return TRSceneMo
