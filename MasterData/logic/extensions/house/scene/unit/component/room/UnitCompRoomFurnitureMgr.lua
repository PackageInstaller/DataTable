-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/scene/unit/component/room/UnitCompRoomFurnitureMgr.lua

module("logic.extensions.house.scene.unit.component.room.UnitCompRoomFurnitureMgr", package.seeall)

local M = class("UnitCompRoomFurnitureMgr", UnitComponentBase)
local FurnitureOperaType = HouseEnum.FurnitureOperaType
local WallType = HouseEnum.WallType
local ContainerRootParentName = "FurnitureRoot"
local ContainerRootName = "room_%s"

function M:ctor(unit)
	M.super.ctor(self, unit)

	self._unitId = 0
	self._dictFurniture = {}
	self._totalLoadCount = false
	self._hasLoadedCount = false
end

function M:onInit()
	return
end

function M:onReuse()
	return
end

function M:onReset()
	self:_setEditEvent(false)
	self:removeAllFurniture(false, true)

	self._unitId = 0
	self._totalLoadCount = false
	self._hasLoadedCount = false
end

function M:onRoomResLoaded()
	self._unit:addInnerEventListener(UnitActionType.RoomFurnitureResLoaded, self._onFurnitureResLoaded, self)
	self:createAllFurnitureByServer()
	self:_rebuildNavMesh()
	HouseDispatcher:addEventListener(HouseEventType.HOUSE_FURNITURES_UPDATE, self._onFurnituresUpdate, self)
	HouseDispatcher:addEventListener(HouseEventType.FURNITURE_EDIT_START, self._onFurnitureEditStart, self)
	HouseDispatcher:addEventListener(HouseEventType.FURNITURE_EDIT_END, self._onFurnitureEditEnd, self)
	self._unit.furniturePerform:startPerformTriggerTimer()
end

function M:onRoomResUnload()
	self._unit:removeInnerEventListener(UnitActionType.RoomFurnitureResLoaded, self._onFurnitureResLoaded, self)
	HouseDispatcher:removeEventListener(HouseEventType.HOUSE_FURNITURES_UPDATE, self._onFurnituresUpdate, self)
	HouseDispatcher:removeEventListener(HouseEventType.FURNITURE_EDIT_START, self._onFurnitureEditStart, self)
	HouseDispatcher:removeEventListener(HouseEventType.FURNITURE_EDIT_END, self._onFurnitureEditEnd, self)
	self._unit.furniturePerform:endPerformTriggerTimer()
	self._unit.furniturePerform:interruptAllCtrl()
	self:removeAllFurniture(false, true)

	self._totalLoadCount = false
	self._hasLoadedCount = false
end

function M:onDestroy()
	self:onReset()
end

function M:_isEdit()
	return HouseFacade.instance:isEditingFurniture() and self._unit.model:getRoomId() == HouseFurnitureModel.instance:getEditRoomId()
end

function M:_setEditEvent(add)
	if add then
		HouseDispatcher:addEventListener(HouseEventType.FURNITURE_EDIT_NEW_BY_ID, self._onCreateFurnitureById, self)
		HouseDispatcher:addEventListener(HouseEventType.FURNITURE_EDIT_REVOKE_ALL, self._onRevokeAllFurniture, self)
		HouseDispatcher:addEventListener(HouseEventType.FURNITURE_EDIT_REPLACE_ALL_BY_DATA, self._onReplaceAllFurnitureByData, self)
		HouseDispatcher:addEventListener(HouseEventType.FURNITURE_EDIT_REMOVE_ALL, self._onRemoveAllFurniture, self)
	else
		HouseDispatcher:removeEventListener(HouseEventType.FURNITURE_EDIT_NEW_BY_ID, self._onCreateFurnitureById, self)
		HouseDispatcher:removeEventListener(HouseEventType.FURNITURE_EDIT_REVOKE_ALL, self._onRevokeAllFurniture, self)
		HouseDispatcher:removeEventListener(HouseEventType.FURNITURE_EDIT_REPLACE_ALL_BY_DATA, self._onReplaceAllFurnitureByData, self)
		HouseDispatcher:removeEventListener(HouseEventType.FURNITURE_EDIT_REMOVE_ALL, self._onRemoveAllFurniture, self)
	end
end

function M:createAllFurnitureByServer()
	local roomId = self._unit.model:getRoomId()
	local moList = HouseFurnitureModel.instance:getRoomFurnitures(roomId)

	self:clearAllAndCreateFurnitures(moList, true)
end

function M:clearAllAndCreateFurnitures(moList, clearPaper)
	local totalLoadCount = 0
	local floorPaperId, wallPaperId = false, false
	local floorPaperUUId, wallPaperUUId = false, false
	local dictMO = {}
	local dictReuse = {}

	for _, mo in ipairs(moList) do
		local furnitureCO = BackpackConfig.instance:getItemInfoByItemId(mo:getId())

		if furnitureCO.operaType == FurnitureOperaType.FloorPaper then
			floorPaperId = mo:getId()
			floorPaperUUId = mo:getUUId()
		elseif furnitureCO.operaType == FurnitureOperaType.WallPaper then
			wallPaperId = mo:getId()
			wallPaperUUId = mo:getUUId()
		end

		local reuse = false

		for unitId, unit in pairs(self._dictFurniture) do
			if not dictReuse[unitId] and unit.model:getFurnitureId() == mo:getId() then
				reuse = true
				dictReuse[unitId] = true

				unit.model:setCoordX(mo:getCoordX())
				unit.model:setCoordY(mo:getCoordY())
				unit.model:setAngle(mo:getAngle())
				unit.model:setUUId(mo:getUUId())
				self._unit.furnitureHandler:refreshFurniturePos(unit)
				unit.resLoader:refreshByAngle()

				break
			end
		end

		dictMO[mo] = reuse

		if not reuse and furnitureCO.operaType ~= FurnitureOperaType.FloorPaper and furnitureCO.operaType ~= FurnitureOperaType.WallPaper then
			totalLoadCount = totalLoadCount + 1
		end
	end

	if floorPaperId then
		if self._unit.furniturePaper:needLoadNewFloorRes(floorPaperId) then
			totalLoadCount = totalLoadCount + 1
		end
	elseif clearPaper and self._unit.furniturePaper:needLoadNewFloorRes(nil) then
		totalLoadCount = totalLoadCount + 1
	end

	if wallPaperId then
		if self._unit.furniturePaper:needLoadNewWallRes(wallPaperId) then
			totalLoadCount = totalLoadCount + 1
		end
	elseif clearPaper and self._unit.furniturePaper:needLoadNewWallRes(nil) then
		totalLoadCount = totalLoadCount + 1
	end

	self._totalLoadCount = totalLoadCount
	self._hasLoadedCount = 0

	if totalLoadCount == 0 then
		self._totalLoadCount = false
		self._hasLoadedCount = false
	end

	if floorPaperId then
		self._unit.furniturePaper:setFloorPaper(floorPaperId, floorPaperUUId)
	elseif clearPaper then
		self._unit.furniturePaper:setFloorPaper(nil)
	end

	if wallPaperId then
		self._unit.furniturePaper:setWallPaper(wallPaperId, wallPaperUUId)
	elseif clearPaper then
		self._unit.furniturePaper:setWallPaper(nil)
	end

	for unitId, unit in pairs(self._dictFurniture) do
		if not dictReuse[unitId] then
			self:removeFurnitureUnit(unit)
		end
	end

	for mo, reuse in pairs(dictMO) do
		local furnitureCO = BackpackConfig.instance:getItemInfoByItemId(mo:getId())

		if not reuse and furnitureCO.operaType ~= FurnitureOperaType.FloorPaper and furnitureCO.operaType ~= FurnitureOperaType.WallPaper then
			self:createFurnitureUnit(mo:getId(), mo:getCoordX(), mo:getCoordY(), mo:getAngle(), mo:getUUId())
		end
	end

	dictMO = nil
	dictReuse = nil

	self._unit.furnitureHandler:dispatchConflict()
	HouseDispatcher:dispatchEvent(HouseEventType.ON_FURNITURE_CREATE_ALL, self._unit.model:getRoomId())

	if totalLoadCount == 0 then
		self:_finishLoadedAllFurniture()
	end
end

function M:createFurnitureUnit(furnitureId, coordX, coordY, angle, uuid, recycleSamePaper)
	local furnitureCO = BackpackConfig.instance:getItemInfoByItemId(furnitureId)

	if furnitureCO and not string.nilorempty(furnitureCO.resPath) then
		local operaType = furnitureCO.operaType

		if operaType == FurnitureOperaType.FloorPaper then
			self._unit.furniturePaper:setFloorPaper(furnitureId, uuid, recycleSamePaper)
		elseif operaType == FurnitureOperaType.WallPaper then
			self._unit.furniturePaper:setWallPaper(furnitureId, uuid, recycleSamePaper)
		else
			self._unitId = self._unitId + 1

			local unitName = string.format("Furniture_%s", self._unitId)
			local unit = HouseFurnitureUnit:createInstance(unitName)

			unit.id = self._unitId

			goutil.addChildToParent(unit.go, self:_getContainerRoot())
			Astral.TransformUtil.SetLocalRotation(unit.go.transform, 0, 0, self._unit:getParentRotaZ())
			unit.model:setFurnitureId(furnitureId)
			unit.model:setCoordX(coordX)
			unit.model:setCoordY(coordY)
			unit.model:setAngle(angle)
			unit.model:setUUId(uuid)
			unit.model:setBelongRoom(self._unit)
			self._unit.furnitureHandler:refreshFurniturePos(unit)
			unit.resLoader:loadRes()

			self._dictFurniture[unit.id] = unit

			return unit
		end
	end
end

function M:getDictFurnitureUnit()
	return self._dictFurniture
end

function M:getFurnitureUnit(id)
	return self._dictFurniture[id]
end

function M:getFurnitureByUUId(uuid)
	for _, unit in pairs(self._dictFurniture) do
		if unit.model:getUUId() == uuid then
			return unit
		end
	end
end

function M:getFurnituresById(furnId)
	local units = {}

	for _, unit in pairs(self._dictFurniture) do
		if unit.model:getFurnitureId() == furnId then
			table.insert(units, unit)
		end
	end

	return units
end

function M:handleFurnituresWhenEdit()
	for _, unit in pairs(self._dictFurniture) do
		unit.perform:setPathTriggerDirty()
	end
end

function M:removeFurnitureUnit(unit)
	self._unit.furnitureMap:removeAllMapDataByUnit(unit)

	local id = unit.id

	unit:returnSelf()

	self._dictFurniture[id] = nil
end

function M:removeAllFurniture(removePaper, unDispatch)
	local hasFurniture = false

	for id, furniture in pairs(self._dictFurniture) do
		self:removeFurnitureUnit(furniture)

		hasFurniture = true
	end

	if removePaper then
		self._unit.furniturePaper:setFloorPaper(nil)
		self._unit.furniturePaper:setWallPaper(nil)
	end

	if unDispatch == nil or unDispatch == false then
		self._unit.furnitureHandler:dispatchConflict()
	end
end

function M:clearSelectedFurniture()
	self._unit.furnitureHandler:clearSelectedFurniture()
	HouseFurnitureOpView.instance:hide()
end

function M:getBedConflict()
	local singleBedNum, doubleBedNum = 0, 0

	for _, unit in pairs(self._dictFurniture) do
		if unit.model:getSubType() == 101 then
			if unit.model:getBunkType() == 1 then
				singleBedNum = singleBedNum + 1
			elseif unit.model:getBunkType() == 2 then
				doubleBedNum = doubleBedNum + 1
			end
		end
	end

	local livingType = 0
	local zoneMo = LivingFacilitiesZoneModel.instance:getZoneById(self._unit.model:getRoomId())

	if zoneMo then
		livingType = zoneMo:getType()
	end

	local forbidSingleBed = singleBedNum > 0 and not HouseSceneUtil.isSingleDormitoryRoom(livingType)
	local forbidDoubleBed = doubleBedNum > 0 and not HouseSceneUtil.isMultiDormitoryRoom(livingType)
	local overSingleBed = singleBedNum > 1
	local overDoubleBed = doubleBedNum > 2

	return forbidSingleBed, forbidDoubleBed, overSingleBed, overDoubleBed
end

function M:_getContainerRoot()
	local sceneContainer = SceneMgr.instance:getCurScene():getContainer()
	local goContainerParent = goutil.findChild(sceneContainer, ContainerRootParentName)

	if not goContainerParent then
		goContainerParent = goutil.create(ContainerRootParentName, false)

		goutil.addChildToParent(goContainerParent, sceneContainer)
	end

	local rootName = string.format(ContainerRootName, self._unit.model:getRoomId())
	local goContainer = goutil.findChild(goContainerParent, rootName)

	if not goContainer then
		goContainer = goutil.create(rootName, false)

		goutil.addChildToParent(goContainer, goContainerParent)
	end

	return goContainer
end

function M:_onFurnitureEditStart()
	if self:_isEdit() then
		self:handleFurnituresWhenEdit()
		self:_setEditEvent(true)
		self._unit.model:setLinkEnabled(false)
	end
end

function M:_onFurnitureEditEnd()
	if self._unit.model:getRoomId() == HouseFurnitureModel.instance:getEditRoomId() then
		self:clearSelectedFurniture()
		self:_setEditEvent(false)
		self:_rebuildNavMesh()
		self._unit.model:setLinkEnabled(true)
	end
end

function M:_rebuildNavMesh()
	local datas = {}
	local go = self._unit.furnitureMap:getFurnitureRootGO()

	self._unit.roomNavMesh:setModifierVolumePos(Astral.TransformUtil.GetPos(go.transform, 0, 0, 0))

	for _, unit in pairs(self._dictFurniture) do
		local operaType = unit.model:getOperaType()

		if operaType == FurnitureOperaType.Floor then
			local coordX = unit.model:getCoordX()
			local coordY = unit.model:getCoordY()
			local coordXLen = unit.model:getCoordXLen()
			local coordYLen = unit.model:getCoordYLen()
			local posX, posY, posZ = self._unit.furnitureMap:getLocalPosByCoord(operaType, coordX, coordY, coordXLen, coordYLen)
			local data = {}
			local gridSize = HouseEnum.FURNITURE_COORD_SIZE
			local radius = CommEnum.NavMeshRadius.Common

			data.size = Vector3.New(gridSize * coordXLen - radius, 2, gridSize * coordYLen - radius)
			data.center = Vector3.New(posX, 0, posZ)

			table.insert(datas, data)
		end
	end

	self._unit.roomNavMesh:setModifierVolumeDatas(datas)
end

function M:_onFurnitureResLoaded(eventId, actionType, operaType, furnitureId, uuid)
	if self._hasLoadedCount then
		self._hasLoadedCount = self._hasLoadedCount + 1

		if self._totalLoadCount and self._hasLoadedCount >= self._totalLoadCount then
			self:_finishLoadedAllFurniture()
		end
	end
end

function M:_finishLoadedAllFurniture()
	self._totalLoadCount = false
	self._hasLoadedCount = false

	HouseDispatcher:dispatchEvent(HouseEventType.ROOM_FURNITURES_RES_LOADED, self._unit.model:getRoomId())
end

function M:_onCreateFurnitureById(e, furnitureId, uuid)
	if self:_isEdit() and furnitureId then
		local furnitureCO = BackpackConfig.instance:getItemInfoByItemId(furnitureId)

		if furnitureCO and not string.nilorempty(furnitureCO.resPath) then
			local operaType = furnitureCO.operaType

			if operaType == FurnitureOperaType.FloorPaper then
				self:createFurnitureUnit(furnitureId, 0, 0, 0, uuid, true)
				self._unit.furnitureHandler:changeCameraByType(0)
			elseif operaType == FurnitureOperaType.WallPaper then
				self:createFurnitureUnit(furnitureId, 0, 0, 0, uuid, true)
				self._unit.furnitureHandler:changeCameraByType(0)
			elseif not self._unit.furnitureHandler:getSelectedFurniture() then
				local coordLenList = string.split(furnitureCO.coordSize, "#")
				local coordXLen = tonumber(coordLenList[1])
				local coordYLen = tonumber(coordLenList[2])
				local operaType = furnitureCO.operaType
				local minX, maxX, minY, maxY = self._unit.furnitureMap:getCoordBorderByType(operaType, WallType.Middle)
				local coordX = math.floor((maxX - minX - coordXLen) / 2) + minX
				local coordY = math.floor((maxY - minY - coordYLen) / 2) + minY

				coordX, coordY = HouseSceneUtil.adjustCoordWithFix(furnitureId, coordX, coordY)
				coordX = math.min(maxX, math.max(minX, coordX))
				coordY = math.min(maxY, math.max(minY, coordY))

				local unit = self:createFurnitureUnit(furnitureId, coordX, coordY, 0, uuid)

				self._unit.furnitureHandler:setSelectedFurniture(unit, true)
			end

			self._unit.furnitureHandler:dispatchConflict()
		end
	end
end

function M:_onRevokeAllFurniture()
	if self:_isEdit() then
		LivingFacilitiesZoneController.instance:InitCache()
		self:clearSelectedFurniture()
		self:createAllFurnitureByServer()
	end
end

function M:_onReplaceAllFurnitureByData(e, moList)
	if self:_isEdit() then
		self:clearSelectedFurniture()
		self:clearAllAndCreateFurnitures(moList, true)
	end
end

function M:_onRemoveAllFurniture()
	if self:_isEdit() then
		self:clearSelectedFurniture()
		self:removeAllFurniture(true)
	end
end

function M:_onFurnituresUpdate()
	if not self:_isEdit() then
		self:createAllFurnitureByServer()
	end
end

return M
