-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/domainadventure/SceneCompMapInfoMgr.lua

module("logicscene.scene.component.domainadventure.SceneCompMapInfoMgr", package.seeall)

local SceneCompMapInfoMgr = class("SceneCompMapInfoMgr", SceneComponentBase)

function SceneCompMapInfoMgr:ctor(scene)
	SceneCompMapInfoMgr.super.ctor(self, scene)

	self._tickingTime = 0
	self._gridStates = {}
	self._disPetInfoDic = {}
	self._gridIdsByType = {}
	self._gridIdsOfBuff = {}
end

function SceneCompMapInfoMgr:onEnterScene(sceneId, bornX, bornZ)
	SceneCompMapInfoMgr.super.onEnterScene(self, sceneId, bornX, bornZ)

	self._activityId = self._scene._activityId
	self._domAdvMo = DomainAdventureController.instance:getDomAdvMo(self._activityId)
	self._tickingTime = 0

	local gridCount = DomAdvPathFindingDataModel.instance:getGridCount()
	local eventType = DomAdvEnum.EventType_Empty
	local gridDic = {}

	for gridId = 0, gridCount do
		self._gridStates[gridId] = DomAdvGridState.New(self._activityId, gridId)
		gridDic[gridId] = true
		eventType = self._gridStates[gridId]:getEventType()
		self._gridIdsByType[eventType] = self._gridIdsByType[eventType] or {}

		table.insert(self._gridIdsByType[eventType], gridId)

		if self._gridStates[gridId]:isBuff() then
			table.insert(self._gridIdsOfBuff, gridId)
		end
	end

	self:updateGridInfoFormModel(gridDic)
end

function SceneCompMapInfoMgr:onExitScene()
	SceneCompMapInfoMgr.super.onExitScene(self)

	self._domAdvMo = nil

	table.clear(self._gridStates)
end

function SceneCompMapInfoMgr:onUpdate()
	local gridIdUpdateDic = self._domAdvMo:getGridIdUpdateDic()

	self:updateGridInfoFormModel(gridIdUpdateDic)
	self:updateDispatchInfoFormModel()
end

function SceneCompMapInfoMgr:updateGridInfoFormModel(gridIdUpdateDic)
	for gridId, _ in pairs(gridIdUpdateDic) do
		self._gridStates[gridId]:onReset()
	end

	local bossGridIds = self:getGridIdsByType(DomAdvEnum.EventType_Boss)

	for _, gridId in ipairs(bossGridIds) do
		local value = self._domAdvMo:isBossUnlock(gridId)

		self._gridStates[gridId]:setBossUnlock(value)
		self._gridStates[gridId]:setAdjacentUnlock(true)
		self._gridStates[gridId]:setAdjacentFire(nil)
		self._gridStates[gridId]:setOccupied(nil)
	end

	for gridId, isUpdate in pairs(gridIdUpdateDic) do
		local gridState = self._gridStates[gridId]
		local isOccupied = self._domAdvMo:isOccupiedInBlock(gridId)

		gridState:setOccupied(isOccupied)

		local adjacentGridIds = DomAdvPathFindingDataModel.instance:getAdjacentGridIds(gridId)

		if isOccupied then
			self._gridStates[gridId]:setAdjacentUnlock(true)

			for _, v in ipairs(adjacentGridIds) do
				self._gridStates[v]:setAdjacentUnlock(true)
			end
		else
			for _, v in ipairs(adjacentGridIds) do
				if self._domAdvMo:isOccupiedInBlock(v) then
					gridState:setAdjacentUnlock(true)
				end
			end
		end

		if isOccupied == true or isOccupied == nil then
			gridState:setAdjacentFire(nil)
		else
			local percentage = self._domAdvMo:getCurPercentageInBlock(gridId)

			if percentage > 0 then
				gridState:setAdjacentFire(true)
			else
				gridState:setAdjacentFire(false)
			end
		end

		if isOccupied then
			local ids = {
				gridId
			}

			while #ids > 0 do
				local childId = table.remove(ids)

				if self._domAdvMo:isOccupiedInBlock(childId) then
					local data = DomainAdventureConfig.instance:getMapData(self._activityId, childId)

					if data and data.relationBlockIds then
						for _, v in ipairs(data.relationBlockIds) do
							self._gridStates[v]:setRelFatherOcc(true)
							table.insert(ids, v)
						end
					end
				end
			end
		end

		if isOccupied then
			local ids = {
				gridId
			}

			while #ids > 0 do
				local childId = table.remove(ids)

				if self._domAdvMo:isOccupiedInBlock(childId) then
					local data = DomainAdventureConfig.instance:getMapData(self._activityId, childId)

					if data and data.occupiedUnlockBlocks then
						for _, v in ipairs(data.occupiedUnlockBlocks) do
							self._gridStates[v]:setSealFatherOcc(true)
							table.insert(ids, v)
						end
					end
				end
			end
		end

		if DomAdvPathFindingDataModel.instance:getRelFatherOccIds(gridId) then
			gridState:setRelFatherOcc(true)

			local ids = {
				gridId
			}

			while #ids > 0 do
				local fId = table.remove(ids)
				local fatherIds = DomAdvPathFindingDataModel.instance:getRelFatherOccIds(fId)

				if fatherIds == nil then
					if fId ~= gridId and not self._domAdvMo:isOccupiedInBlock(fId) then
						gridState:setRelFatherOcc(false)

						break
					end
				else
					table.insertto(ids, fatherIds)
				end
			end
		end

		if DomAdvPathFindingDataModel.instance:getSealFatherOccIds(gridId) then
			gridState:setSealFatherOcc(true)

			local ids = {
				gridId
			}

			while #ids > 0 do
				local fId = table.remove(ids)
				local fatherIds = DomAdvPathFindingDataModel.instance:getSealFatherOccIds(fId)

				if fatherIds == nil then
					if fId ~= gridId and not self._domAdvMo:isOccupiedInBlock(fId) then
						gridState:setSealFatherOcc(false)

						break
					end
				else
					table.insertto(ids, fatherIds)
				end
			end
		end
	end

	self._domAdvMo:clearGridIdUpdateDic()
end

function SceneCompMapInfoMgr:updateDispatchInfoFormModel()
	local nowTime = ServerTime.now() * 1000
	local list = self._domAdvMo:getDispatchPetList()

	self._disPetInfoDic = {}

	for _, v in ipairs(list) do
		if nowTime < checknumber(v.unlockTime) then
			self._disPetInfoDic[v.petId] = v
		end
	end
end

function SceneCompMapInfoMgr:onTicking(deltaTime)
	self._tickingTime = self._tickingTime + deltaTime

	if self._tickingTime >= 1 then
		self._tickingTime = 0

		local isNeedNotifyUpdate = false
		local nowTime = ServerTime.now() * 1000

		for petId, v in pairs(self._disPetInfoDic) do
			if nowTime >= checknumber(v.unlockTime) then
				self._disPetInfoDic[petId] = nil
				isNeedNotifyUpdate = true
			end
		end

		if isNeedNotifyUpdate then
			self._scene:setNeedNotifyMapDataUpdate()
		end
	end
end

function SceneCompMapInfoMgr:getGridState(gridId)
	return self._gridStates[gridId]
end

function SceneCompMapInfoMgr:getDsipatchInfo(petId)
	return self._disPetInfoDic[petId]
end

function SceneCompMapInfoMgr:getAllDsipatchInfo()
	return self._disPetInfoDic
end

function SceneCompMapInfoMgr:getGridIdsByType(eventType)
	return self._gridIdsByType[eventType] or {}
end

function SceneCompMapInfoMgr:getGridIdsInBuff()
	return self._gridIdsOfBuff
end

return SceneCompMapInfoMgr
