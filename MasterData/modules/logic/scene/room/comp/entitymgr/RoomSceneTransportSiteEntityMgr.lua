-- chunkname: @modules/logic/scene/room/comp/entitymgr/RoomSceneTransportSiteEntityMgr.lua

module("modules.logic.scene.room.comp.entitymgr.RoomSceneTransportSiteEntityMgr", package.seeall)

local RoomSceneTransportSiteEntityMgr = class("RoomSceneTransportSiteEntityMgr", BaseSceneUnitMgr)

function RoomSceneTransportSiteEntityMgr:onInit()
	return
end

function RoomSceneTransportSiteEntityMgr:init(sceneId, levelId)
	self:_addEvents()

	self._scene = self:getCurScene()

	self:refreshAllSiteEntity()
end

function RoomSceneTransportSiteEntityMgr:onSwitchMode()
	self:refreshAllSiteEntity()
end

function RoomSceneTransportSiteEntityMgr:_addEvents()
	if self._isInitAddEvent then
		return
	end

	self._isInitAddEvent = true

	RoomMapController.instance:registerCallback(RoomEvent.TransportPathLineChanged, self.refreshAllSiteEntity, self)
end

function RoomSceneTransportSiteEntityMgr:_removeEvents()
	if not self._isInitAddEvent then
		return
	end

	self._isInitAddEvent = false

	RoomMapController.instance:unregisterCallback(RoomEvent.TransportPathLineChanged, self.refreshAllSiteEntity, self)
end

function RoomSceneTransportSiteEntityMgr:refreshAllSiteEntity()
	local buildingTypeList = RoomTransportHelper.getSiteBuildingTypeList()

	for i = 1, #buildingTypeList do
		local siteType = buildingTypeList[i]
		local hexPoint = RoomMapTransportPathModel.instance:getSiteHexPointByType(siteType)
		local entity = self:getSiteEntity(siteType)

		if hexPoint then
			if entity then
				self:moveToHexPoint(entity, hexPoint)
			else
				entity = self:spawnRoomTransportSite(siteType, hexPoint)
			end

			entity:refreshBuilding()
		elseif entity then
			self:destroySiteEntity(entity)
		end
	end
end

function RoomSceneTransportSiteEntityMgr:spawnRoomTransportSite(siteType, hexPoint)
	local buildingRoot = self._scene.go.buildingRoot
	local siteGO = gohelper.create3d(buildingRoot, string.format("site_%s", siteType))
	local entity = MonoHelper.addNoUpdateLuaComOnceToGo(siteGO, RoomTransportSiteEntity, siteType)

	self:addUnit(entity)
	gohelper.addChild(buildingRoot, siteGO)
	self:moveToHexPoint(entity, hexPoint)

	return entity
end

function RoomSceneTransportSiteEntityMgr:moveToHexPoint(entity, hexPoint)
	if entity and hexPoint then
		local posX, posZ = HexMath.hexXYToPosXY(hexPoint.x, hexPoint.y, RoomBlockEnum.BlockSize)

		entity:setLocalPos(posX, 0, posZ)
	end
end

function RoomSceneTransportSiteEntityMgr:moveTo(entity, position)
	entity:setLocalPos(position.x, position.y, position.z)
end

function RoomSceneTransportSiteEntityMgr:destroySiteEntity(entity)
	self:removeUnit(entity:getTag(), entity.id)
end

function RoomSceneTransportSiteEntityMgr:getSiteEntity(id)
	return self:getUnit(RoomTransportSiteEntity:getTag(), id)
end

function RoomSceneTransportSiteEntityMgr:getRoomSiteEntityDict()
	return self._tagUnitDict[RoomTransportSiteEntity:getTag()] or {}
end

function RoomSceneTransportSiteEntityMgr:_onUpdate()
	return
end

function RoomSceneTransportSiteEntityMgr:onSceneClose()
	RoomSceneTransportSiteEntityMgr.super.onSceneClose(self)
	self:_removeEvents()
end

return RoomSceneTransportSiteEntityMgr
