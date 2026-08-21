-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/component/AirWorkShopHighlandChecker.lua

module("logic.extensions.airworkshop.flow.defflow.component.AirWorkShopHighlandChecker", package.seeall)

local M = class("AirWorkShopHighlandChecker", IBattleFlowComp)

local function sort_on_size(coA, coB)
	return coA.shape[1] < coB.shape[1] and coA.shape[2] < coB.shape[2]
end

function M:onInit()
	return
end

function M:onStart()
	self._resMgr = self.flow.resMgr or false
	self._boardModel = self.flow.boardModel or false
	self._unitMgr = self.flow.unitMgr or false
	self._model = self.flow.model or false
	self._groupList = {}
	self._unionIndex2Nodes = {}
end

function M:onClear()
	self._resMgr = false
	self._boardModel = false
	self._unitMgr = false
	self._nodeArray = false

	table.clear(self._groupList)
end

function M:onEnterDone()
	self:_initHighlandGroup()
end

function M:_initHighlandGroup()
	local buildCOList = AirWorkShopConfig.instance:getAllBuildingCO()

	for i, v in ipairs(buildCOList) do
		if v.group ~= 0 then
			if not self._groupList[v.group] then
				self._groupList[v.group] = {}
			end

			table.insert(self._groupList[v.group], v)
		end
	end

	for k, group in pairs(self._groupList) do
		table.sort(group, sort_on_size)
	end
end

function M:tryCombineGroup(unit)
	local highlandCode = unit.property:getEntityCode()
	local highlandCO = AirWorkShopConfig.instance:getBuildingCO(highlandCode)

	if highlandCO.group == 0 then
		AirWorkShopDefSceneUtil.playPlaceEffect(unit)

		return
	end

	self:_clearCombineData()

	local group = self._groupList[highlandCO.group]
	local idx = self:_getIndexInGroup(group, highlandCO)

	if idx < #group then
		local x, z = unit.transform:getCoordinates()

		self:_tryCombine2Target(highlandCode, x, z, group[idx + 1])
	end

	if #self._needAddEntityCodes > 0 then
		for i, entityId in ipairs(self._needRemoveEntityIds) do
			local unit = self._unitMgr:getUnit(entityId)

			AirWorkShopDefSceneUtil.requestRemoveEntity(unit)
		end

		local addUnit = AirWorkShopDefSceneUtil.createHighland(self._needAddEntityCodes[1])

		AirWorkShopDefSceneUtil.setDragUnitToUnionIndex(addUnit, self._needAddEntityUnionIndexs[1])
		CriwareAudioFacade.instance:playSEById(CriwareAudioEnum.ui_battle_renwuputdown)
		AirWorkShopDefSceneUtil.requestPlaceBuilding(self._needAddEntityCodes[1], self._needAddEntityUnionIndexs[1], addUnit)
		AirWorkShopDefSceneUtil.playPlaceEffect(addUnit)
	end
end

function M:_getIndexInGroup(group, highlandCO)
	for i, v in ipairs(group) do
		if v.id == highlandCO.id then
			return i
		end
	end
end

function M:_tryCombine2Target(highlandCode, x, z, targetCO)
	local length = targetCO.shape[1] / 2
	local hasCombine = false

	for i = -1, 1, 2 do
		for j = -1, 1, 2 do
			if not hasCombine and self:_tryCombine2TargetInDirection(highlandCode, x, z, i, j, length, targetCO) then
				hasCombine = true
			end
		end
	end

	if hasCombine then
		local group = self._groupList[targetCO.group]
		local idx = self:_getIndexInGroup(group, targetCO)

		if idx < #group then
			local nextX, nextZ = BoardIndexConverter.unionIndexToCoordinates(self._needAddEntityUnionIndexs[1])

			self:_tryCombine2Target(targetCO.id, nextX, nextZ, group[idx + 1])
		end
	end
end

function M:_tryCombine2TargetInDirection(highlandCode, x, z, vx, vz, length, targetCO)
	local unionIndex = BoardIndexConverter.coordinatesToUnionIndex(x + vx * length, z)
	local minIndx = unionIndex
	local entityId = self._boardModel:getEntityOnBoard(unionIndex, AirWorkShopEnum.TabEnum.Highland)
	local unit1 = self._unitMgr:getUnit(entityId)

	if not unit1 or unit1.property:getEntityCode() ~= highlandCode then
		return false
	end

	unionIndex = BoardIndexConverter.coordinatesToUnionIndex(x, z + vz * length)
	minIndx = math.min(minIndx, unionIndex)
	entityId = self._boardModel:getEntityOnBoard(unionIndex, AirWorkShopEnum.TabEnum.Highland)

	local unit2 = self._unitMgr:getUnit(entityId)

	if not unit2 or unit2.property:getEntityCode() ~= highlandCode then
		return false
	end

	unionIndex = BoardIndexConverter.coordinatesToUnionIndex(x + vx * length, z + vz * length)
	minIndx = math.min(minIndx, unionIndex)
	entityId = self._boardModel:getEntityOnBoard(unionIndex, AirWorkShopEnum.TabEnum.Highland)

	local unit3 = self._unitMgr:getUnit(entityId)

	if not unit3 or unit3.property:getEntityCode() ~= highlandCode then
		return false
	end

	unionIndex = BoardIndexConverter.coordinatesToUnionIndex(x, z)
	minIndx = math.min(minIndx, unionIndex)
	entityId = self._boardModel:getEntityOnBoard(unionIndex, AirWorkShopEnum.TabEnum.Highland)

	local unitSelf = self._unitMgr:getUnit(entityId)

	table.insert(self._needRemoveEntityIds, unit1.property:getEntityId())
	table.insert(self._needRemoveEntityIds, unit2.property:getEntityId())
	table.insert(self._needRemoveEntityIds, unit3.property:getEntityId())
	table.insert(self._needRemoveEntityIds, unitSelf.property:getEntityId())

	self._needAddEntityCodes[1] = targetCO.id
	self._needAddEntityUnionIndexs[1] = minIndx

	return true
end

function M:_clearCombineData()
	self._needAddEntityUnionIndexs = {}
	self._needAddEntityCodes = {}
	self._needRemoveEntityIds = {}
end

return M
