-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/model/furniture/RoomFurnitureEditModel.lua

module("logic.extensions.house.model.furniture.RoomFurnitureEditModel", package.seeall)

local M = class("RoomFurnitureEditModel", BaseModel)
local FurnitureOperaType = HouseEnum.FurnitureOperaType

function M:ctor()
	self._roomId = nil
	self._dictBagFurnitures = nil
	self._arrayBagFurnitures = nil
	self._dictRoomFurnitures = nil
	self._arrayRoomFurnitures = nil
	self._dictAllEditFurnitures = nil
	self._arrayAllEditFurnitures = nil
end

function M:onInit()
	self._dictBagFurnitures = {}
	self._arrayBagFurnitures = {}
	self._dictRoomFurnitures = {}
	self._arrayRoomFurnitures = {}
	self._dictAllEditFurnitures = {}
	self._arrayAllEditFurnitures = {}

	self:_resetData()
	HouseDispatcher:addEventListener(HouseEventType.ON_FURNITURE_PRODUCT_FINISH, self._onFurnitureProduct, self)
end

function M:onReset()
	self:_resetData()
end

function M:_resetData()
	self._roomId = false

	table.clear(self._dictBagFurnitures)
	table.clear(self._arrayBagFurnitures)
	table.clear(self._dictRoomFurnitures)
	table.clear(self._arrayRoomFurnitures)
	table.clear(self._dictAllEditFurnitures)
	table.clear(self._arrayAllEditFurnitures)
end

function M:clearDatas()
	self:_resetData()
end

function M:initDatas(roomId)
	self:clearDatas()

	self._roomId = roomId

	local zoneMo = LivingFacilitiesZoneModel.instance:getZoneById(roomId)
	local furnList = LivingFacilitiesFurnitureController.instance:getBagFurnitureByRoomType(zoneMo:getType())

	for _, furnMO in ipairs(furnList) do
		local id = furnMO:getItemId()
		local uuid = tonumber(furnMO:getUuid())
		local bagData = self:getOrCreateBagData(id)
		local editData = self:getOrCreateAllEditData(id)
		local isUsing, belongId = furnMO:isUsing()

		if not isUsing then
			bagData:addFurniture(uuid)
			editData:addFurniture(uuid)
		elseif belongId == roomId then
			local roomData = self:getOrCreateRoomData(id)

			roomData:addFurniture(uuid)
			editData:addFurniture(uuid)
		end
	end
end

function M:recycleAllRoomFurniture()
	local tempDataList = {}

	for _, roomData in ipairs(self._arrayRoomFurnitures) do
		local id = roomData:getItemId()
		local uuidList = roomData:getAllFurniture()

		for _, uuid in ipairs(uuidList) do
			local tempData = {
				id = id,
				uuid = uuid
			}

			table.insert(tempDataList, tempData)
		end
	end

	for _, data in ipairs(tempDataList) do
		self:recycleFromRoom(data.id, data.uuid)
	end
end

function M:decorateToRoom(furnitureId, uuid)
	if checknumber(uuid) > 0 then
		local bagData = self:getBagData(furnitureId)

		if bagData then
			bagData:removeFurniture(uuid)
		end

		local roomData = self:getOrCreateRoomData(furnitureId)

		roomData:addFurniture(uuid)
	end
end

function M:recycleFromRoom(furnitureId, uuid)
	if checknumber(uuid) > 0 then
		local bagData = self:getOrCreateBagData(furnitureId)

		bagData:addFurniture(uuid)

		local roomData = self:getRoomData(furnitureId)

		if roomData then
			roomData:removeFurniture(uuid)
		end
	end
end

function M:getOrCreateBagData(furnitureId)
	local data = self._dictBagFurnitures[furnitureId]

	if not data then
		data = FurnitureStackData.New({
			count = 1,
			itemId = furnitureId
		})
		self._dictBagFurnitures[furnitureId] = data

		table.insert(self._arrayBagFurnitures, data)
	end

	return data
end

function M:getOrCreateRoomData(furnitureId)
	local data = self._dictRoomFurnitures[furnitureId]

	if not data then
		data = FurnitureStackData.New({
			count = 1,
			itemId = furnitureId
		})
		self._dictRoomFurnitures[furnitureId] = data

		table.insert(self._arrayRoomFurnitures, data)
	end

	return data
end

function M:getOrCreateAllEditData(furnitureId)
	local data = self._dictAllEditFurnitures[furnitureId]

	if not data then
		data = FurnitureStackData.New({
			count = 1,
			itemId = furnitureId
		})
		self._dictAllEditFurnitures[furnitureId] = data

		table.insert(self._arrayAllEditFurnitures, data)
	end

	return data
end

function M:getBagData(furnitureId)
	return self._dictBagFurnitures[furnitureId]
end

function M:getRoomData(furnitureId)
	return self._dictRoomFurnitures[furnitureId]
end

function M:getEditData(furnitureId)
	return self._dictAllEditFurnitures[furnitureId]
end

function M:getBagItemCount(furnitureId)
	local count = 0
	local data = self._dictBagFurnitures[furnitureId]

	if data then
		count = data:getCount()
	end

	return count
end

function M:getRoomItemCount(furnitureId)
	local count = 0
	local data = self._dictRoomFurnitures[furnitureId]

	if data then
		count = data:getCount()
	end

	return count
end

function M:getAllBagDatas()
	return self._arrayBagFurnitures
end

function M:getAllRoomDatas()
	return self._arrayRoomFurnitures
end

function M:getCurrEditingPaper()
	local currScene = SceneMgr.instance:getCurScene()

	if currScene and currScene.roomMgr then
		local roomId = HouseFurnitureModel.instance:getEditRoomId()
		local roomUnit = currScene.roomMgr:getUnitById(roomId)
		local floorId, floorUUId = roomUnit.furniturePaper:getFloorPaperId()
		local wallId, wallUUId = roomUnit.furniturePaper:getWallPaperId()

		return floorId, wallId
	end
end

function M:_onFurnitureProduct()
	if self._roomId then
		self:initDatas(self._roomId)
	end
end

M.instance = M.New()

return M
