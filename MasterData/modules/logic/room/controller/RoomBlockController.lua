-- chunkname: @modules/logic/room/controller/RoomBlockController.lua

module("modules.logic.room.controller.RoomBlockController", package.seeall)

local RoomBlockController = class("RoomBlockController", BaseController)

function RoomBlockController:onInit()
	self._lastUpdatePathGraphicTimeDic = {}

	self:clear()
end

function RoomBlockController:reInit()
	self:clear()
end

function RoomBlockController:clear()
	return
end

function RoomBlockController:refreshResourceLight()
	local curIsLight = self:_isHasResourceLight()

	if self._isLastHasResourceLight or curIsLight then
		self._isLastHasResourceLight = curIsLight

		RoomMapController.instance:dispatchEvent(RoomEvent.ResourceLight)
	end
end

function RoomBlockController:_isHasResourceLight()
	local tempBlockMO = RoomMapBlockModel.instance:getTempBlockMO()

	if tempBlockMO and tempBlockMO:isHasLight() then
		local tRoomResourceModel = RoomResourceModel.instance
		local hexPoint = tempBlockMO.hexPoint

		for direction = 1, 6 do
			if tRoomResourceModel:isLightResourcePoint(hexPoint.x, hexPoint.y, direction) then
				return true
			end
		end
	end

	return false
end

function RoomBlockController:refreshNearLand(hexPoint, withoutSelf)
	local nearMapEntityList = RoomBlockHelper.getNearBlockEntity(false, hexPoint, 1, withoutSelf, false)

	RoomBlockHelper.refreshBlockEntity(nearMapEntityList, "refreshLand")

	local nearEmptyEntityList = RoomBlockHelper.getNearBlockEntity(true, hexPoint, 1, withoutSelf, true)

	RoomBlockHelper.refreshBlockEntity(nearEmptyEntityList, "refreshWaveEffect")
end

function RoomBlockController:refreshBackBuildingEffect()
	if not self._ishasWaitBlockBuildingEffect then
		self._ishasWaitBlockBuildingEffect = true

		TaskDispatcher.runDelay(self._onRefreshBackBuildingEffect, self, 0.01)
	end
end

function RoomBlockController:_onRefreshBackBuildingEffect()
	self._ishasWaitBlockBuildingEffect = false

	local blockMOList = RoomMapBlockModel.instance:getFullBlockMOList()
	local scene = GameSceneMgr.instance:getCurScene()

	for i = 1, #blockMOList do
		local blockMO = blockMOList[i]
		local entity = scene.mapmgr:getBlockEntity(blockMO.id, SceneTag.RoomMapBlock)

		if entity then
			entity:refreshBackBuildingEffect(blockMO)
		end
	end
end

RoomBlockController.instance = RoomBlockController.New()

return RoomBlockController
