-- chunkname: @modules/logic/room/entity/comp/RoomBuildingLinkBlockComp.lua

module("modules.logic.room.entity.comp.RoomBuildingLinkBlockComp", package.seeall)

local RoomBuildingLinkBlockComp = class("RoomBuildingLinkBlockComp", LuaCompBase)

function RoomBuildingLinkBlockComp:ctor(entity)
	self.entity = entity
	self._effectKey = RoomEnum.EffectKey.BuildingGOKey
end

function RoomBuildingLinkBlockComp:init(go)
	self.go = go

	local mo = self:getMO()

	self._linkBlockDefineIds = string.splitToNumber(mo.config.linkBlock, "#") or {}
	self._linkBlockDefineDict = {}

	for _, defineId in ipairs(self._linkBlockDefineIds) do
		self._linkBlockDefineDict[defineId] = true
	end

	self._isLink = self:_checkLinkBlock()
end

function RoomBuildingLinkBlockComp:addEventListeners()
	RoomMapController.instance:registerCallback(RoomEvent.ClientPlaceBlock, self._onBlockChange, self)
	RoomMapController.instance:registerCallback(RoomEvent.ClientCancelBlock, self._onBlockChange, self)
	RoomMapController.instance:registerCallback(RoomEvent.ConfirmBackBlock, self._onBlockChange, self)
	RoomBuildingController.instance:registerCallback(RoomEvent.DropBuildingDown, self._onBlockChange, self)
end

function RoomBuildingLinkBlockComp:removeEventListeners()
	RoomMapController.instance:unregisterCallback(RoomEvent.ClientPlaceBlock, self._onBlockChange, self)
	RoomMapController.instance:unregisterCallback(RoomEvent.ClientCancelBlock, self._onBlockChange, self)
	RoomMapController.instance:unregisterCallback(RoomEvent.ConfirmBackBlock, self._onBlockChange, self)
	RoomBuildingController.instance:unregisterCallback(RoomEvent.DropBuildingDown, self._onBlockChange, self)
end

function RoomBuildingLinkBlockComp:beforeDestroy()
	self:removeEventListeners()
end

function RoomBuildingLinkBlockComp:_onBlockChange()
	self:refreshLink()
end

function RoomBuildingLinkBlockComp:refreshLink()
	local isLink = self:_checkLinkBlock()

	if self._isLink ~= isLink then
		self._isLink = isLink

		self:_updateLink()
	end
end

function RoomBuildingLinkBlockComp:_updateLink()
	local golist = self.entity.effect:getGameObjectsByName(self._effectKey, RoomEnum.EntityChildKey.BuildingLinkBlockGOKey)

	if golist and #golist > 0 then
		for i, tempGO in ipairs(golist) do
			gohelper.setActive(tempGO, self._isLink)
		end
	end
end

function RoomBuildingLinkBlockComp:_checkLinkBlock()
	if not self._linkBlockDefineIds or #self._linkBlockDefineIds < 1 or self.entity.id == RoomBuildingController.instance:isPressBuilding() then
		return false
	end

	local occupyDict, hexPointList = self:_getOccupyDict()

	if not occupyDict then
		return false
	end

	local tRoomMapBlockModel = RoomMapBlockModel.instance
	local directions = HexPoint.directions

	for i, hexPoint in ipairs(hexPointList) do
		for direction = 1, 6 do
			local dirHex = directions[direction]
			local x = dirHex.x + hexPoint.x
			local y = dirHex.y + hexPoint.y

			if not occupyDict[x] or not occupyDict[x][y] then
				local blockMO = tRoomMapBlockModel:getBlockMO(x, y)

				if blockMO and blockMO:isInMapBlock() then
					local defineId = blockMO:getDefineId()

					if self._linkBlockDefineDict[defineId] then
						return true
					end
				end
			end
		end
	end

	return false
end

function RoomBuildingLinkBlockComp:_getOccupyDict()
	return self.entity:getOccupyDict()
end

function RoomBuildingLinkBlockComp:getMO()
	return self.entity:getMO()
end

function RoomBuildingLinkBlockComp:onEffectRebuild()
	local effect = self.entity.effect

	if effect:isHasEffectGOByKey(self._effectKey) and not effect:isSameResByKey(self._effectKey, self._effectRes) then
		self._effectRes = effect:getEffectRes(self._effectKey)

		self:_updateLink()
	end
end

return RoomBuildingLinkBlockComp
