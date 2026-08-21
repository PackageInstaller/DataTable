-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/scene/unit/component/room/UnitCompRoomFurniturePaper.lua

module("logic.extensions.house.scene.unit.component.room.UnitCompRoomFurniturePaper", package.seeall)

local M = class("UnitCompRoomFurniturePaper", UnitComponentBase)
local RoomSize = HouseEnum.RoomSize
local FurnitureOperaType = HouseEnum.FurnitureOperaType
local kPaperMaterialUrl = "room_%s"
local kDefaultRes = "00"
local kPaperPathStrSmall = "trigger/chufa_trigger/room_s00_p/%s"
local kPaperPathStrBig = "trigger/chufa_trigger/room_b00_p/%s"
local kFloorRootName = "floor"
local kWallRootName = "wallpaper"
local kCeillRootName = "ceilling"
local kDoorRootName = "door"

function M:ctor(unit)
	M.super.ctor(self, unit)

	self._floorPaperId = nil
	self._floorPaperUUId = nil
	self._floorResLoader = nil
	self._floorRootGOs = nil
	self._wallPaperId = nil
	self._wallPaperUUId = nil
	self._wallResLoader = nil
	self._wallRootGOs = nil
	self._floorRootGO = nil
	self._wallRootGO = nil
	self._ceillRootGO = nil
end

function M:onInit()
	self._floorPaperId = false
	self._floorPaperUUId = false
	self._floorResLoader = SingleResLoader.New()
	self._floorRootGOs = false
	self._wallPaperId = false
	self._wallPaperUUId = false
	self._wallResLoader = SingleResLoader.New()
	self._wallRootGOs = false
end

function M:onReuse()
	return
end

function M:onReset()
	self._floorPaperId = false
	self._floorPaperUUId = false
	self._wallPaperId = false
	self._wallPaperUUId = false

	self._floorResLoader:clear()
	self._wallResLoader:clear()
end

function M:onRoomResLoaded()
	self:_findRootGOs()
	self:_setFloorPaperRes()
	self:_setWallPaperRes()
end

function M:onRoomResUnload()
	self:_clearRootGOs()
	self._floorResLoader:clear()
	self._wallResLoader:clear()
end

function M:onDestroy()
	self:onReset()

	self._floorResLoader = nil
	self._wallResLoader = nil
end

function M:_isEdit()
	return HouseFacade.instance:isEditingFurniture() and self._unit.model:getRoomId() == HouseFurnitureModel.instance:getEditRoomId()
end

function M:setFloorPaper(id, uuid, recycleSame)
	if not id then
		id = false
		uuid = nil
	end

	if self._floorPaperId == id then
		if id ~= false and recycleSame then
			self:_tryRecycleFurniture(self._floorPaperId, self._floorPaperUUId)

			self._floorPaperId = false
			self._floorPaperUUId = nil

			self:_setFloorPaperRes()
		else
			self._floorPaperUUId = uuid
		end
	else
		self:_tryRecycleFurniture(self._floorPaperId, self._floorPaperUUId)

		self._floorPaperId = id
		self._floorPaperUUId = uuid

		self:_setFloorPaperRes()
	end

	HouseDispatcher:dispatchEvent(HouseEventType.ON_FURNITURE_PAPER_CHANGE, self._unit.model:getRoomId(), self._floorPaperId)
end

function M:getFloorPaperId()
	return self._floorPaperId, self._floorPaperUUId
end

function M:needLoadNewFloorRes(id)
	id = id or false

	if not self._floorResLoader:getUrl() then
		return true
	end

	if self._floorPaperId == id then
		return false
	end

	return true
end

function M:setWallPaper(id, uuid, recycleSame)
	if not id then
		id = false
		uuid = nil
	end

	if self._wallPaperId == id then
		if id ~= false and recycleSame then
			self:_tryRecycleFurniture(self._wallPaperId, self._wallPaperUUId)

			self._wallPaperId = false
			self._wallPaperUUId = nil

			self:_setWallPaperRes()
		else
			self._wallPaperUUId = uuid
		end
	else
		self:_tryRecycleFurniture(self._wallPaperId, self._wallPaperUUId)

		self._wallPaperId = id
		self._wallPaperUUId = uuid

		self:_setWallPaperRes()
	end

	HouseDispatcher:dispatchEvent(HouseEventType.ON_FURNITURE_PAPER_CHANGE, self._unit.model:getRoomId(), self._wallPaperId)
end

function M:getWallPaperId()
	return self._wallPaperId, self._wallPaperUUId
end

function M:needLoadNewWallRes(id)
	id = id or false

	if not self._wallResLoader:getUrl() then
		return true
	end

	if self._wallPaperId == id then
		return false
	end

	return true
end

function M:changeLayerByType(operaType)
	local function _changeLayer(rootGO, layerValue)
		local visible = layerValue == SceneLayer.Stone_Value
		local colliders = rootGO.transform:GetComponentsInChildren(typeof(UnityEngine.Collider), true)
		local len = colliders.Length

		if len > 0 then
			for i = 0, len - 1 do
				local collider = colliders[i]

				collider.gameObject.layer = layerValue

				goutil.setActive(collider.gameObject, visible)
			end
		end
	end

	local floorLayer = SceneLayer.Default_Value
	local wallLayer = SceneLayer.Default_Value
	local ceilLayer = SceneLayer.Default_Value

	if operaType == FurnitureOperaType.Floor or operaType == FurnitureOperaType.Carpet then
		floorLayer = SceneLayer.Stone_Value
	elseif operaType == FurnitureOperaType.Wall then
		wallLayer = SceneLayer.Stone_Value
	elseif operaType == FurnitureOperaType.Ceiling then
		ceilLayer = SceneLayer.Stone_Value
	end

	if self._floorRootGO then
		_changeLayer(self._floorRootGO, floorLayer)
	end

	if self._wallRootGO then
		_changeLayer(self._wallRootGO, wallLayer)
	end

	if self._ceillRootGO then
		_changeLayer(self._ceillRootGO, ceilLayer)
	end
end

function M:_tryRecycleFurniture(furnitureId, uuid)
	if self:_isEdit() and furnitureId then
		HouseDispatcher:dispatchEvent(HouseEventType.FURNITURE_HAVE_RECYCLE, furnitureId, uuid)
	end
end

function M:_changeResPathBySize(resPathStr)
	local suffix = "s"

	if self._unit.model:getSizeType() == RoomSize.Big then
		suffix = "b"
	end

	return string.format("%s%s", suffix, resPathStr)
end

function M:_setFloorPaperRes()
	if self._floorRootGOs and #self._floorRootGOs > 0 then
		local resStr = kDefaultRes

		if self._floorPaperId then
			local furnitureCO = BackpackConfig.instance:getItemInfoByItemId(self._floorPaperId)

			resStr = furnitureCO.resPath
		end

		resStr = self:_changeResPathBySize(resStr)

		local url = GameUrl.getHouseMaterialPath(string.format(kPaperMaterialUrl, resStr))

		self._floorResLoader:load(url, self._onFloorResLoaded, self)
	end
end

function M:_onFloorResLoaded(res)
	self:_setMaterial(res, self._floorRootGOs)
	self._unit:dispatchInnerEvent(UnitActionType.RoomFurnitureResLoaded, FurnitureOperaType.FloorPaper, self._floorPaperId, self._floorPaperUUId)
end

function M:_setWallPaperRes()
	if self._wallRootGOs and #self._wallRootGOs > 0 then
		local resStr = kDefaultRes

		if self._wallPaperId then
			local furnitureCO = BackpackConfig.instance:getItemInfoByItemId(self._wallPaperId)

			resStr = furnitureCO.resPath
		end

		resStr = self:_changeResPathBySize(resStr)

		local url = GameUrl.getHouseMaterialPath(string.format(kPaperMaterialUrl, resStr))

		self._wallResLoader:load(url, self._onWallResLoaded, self)
	end
end

function M:_onWallResLoaded(res)
	self:_setMaterial(res, self._wallRootGOs)
	self._unit:dispatchInnerEvent(UnitActionType.RoomFurnitureResLoaded, FurnitureOperaType.WallPaper, self._wallPaperId, self._wallPaperUUId)
end

function M:_setMaterial(res, arrayGO)
	local newMaterial = res and res:GetMainAsset()

	for _, rootGO in ipairs(arrayGO) do
		local renderers = rootGO.transform:GetComponentsInChildren(typeof(UnityEngine.Renderer), true)
		local len = renderers.Length

		if len > 0 then
			for i = 0, len - 1 do
				local renderer = renderers[i]

				renderer.material = newMaterial
			end
		end
	end
end

function M:_findRootGOs()
	self._floorRootGOs = {}
	self._wallRootGOs = {}

	local roomGO = self._unit.resLoader:getRoomGO()

	if roomGO then
		local paperPath = kPaperPathStrSmall

		if self._unit.model:getSizeType() == RoomSize.Big then
			paperPath = kPaperPathStrBig
		end

		local floorRootGO = goutil.findChild(roomGO, string.format(paperPath, kFloorRootName))
		local wallRootGO = goutil.findChild(roomGO, string.format(paperPath, kWallRootName))
		local ceillRootGO = goutil.findChild(roomGO, string.format(paperPath, kCeillRootName))
		local doorRootGO = goutil.findChild(roomGO, string.format(paperPath, kDoorRootName))

		if floorRootGO then
			table.insert(self._floorRootGOs, floorRootGO)
		end

		if wallRootGO then
			table.insert(self._wallRootGOs, wallRootGO)
		end

		if ceillRootGO then
			table.insert(self._wallRootGOs, ceillRootGO)
		end

		if doorRootGO then
			table.insert(self._wallRootGOs, doorRootGO)
		end

		self._floorRootGO = floorRootGO
		self._wallRootGO = wallRootGO
		self._ceillRootGO = ceillRootGO
	end
end

function M:_clearRootGOs()
	self._floorRootGOs = false
	self._wallRootGOs = false
	self._floorRootGO = nil
	self._wallRootGO = nil
	self._ceillRootGO = nil
end

return M
