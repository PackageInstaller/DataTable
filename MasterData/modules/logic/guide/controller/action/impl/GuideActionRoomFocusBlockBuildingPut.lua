-- chunkname: @modules/logic/guide/controller/action/impl/GuideActionRoomFocusBlockBuildingPut.lua

module("modules.logic.guide.controller.action.impl.GuideActionRoomFocusBlockBuildingPut", package.seeall)

local GuideActionRoomFocusBlockBuildingPut = class("GuideActionRoomFocusBlockBuildingPut", BaseGuideAction)

function GuideActionRoomFocusBlockBuildingPut:onStart(context)
	GuideActionRoomFocusBlockBuildingPut.super.onStart(self, context)

	if self.actionParam then
		local arr = string.splitToNumber(self.actionParam, "#")
		local buildingId = arr[1]

		if not arr[2] then
			if not arr[3] then
				local posOffsetY = 0

				if GameSceneMgr.instance:getCurSceneType() == SceneType.Room then
					if buildingId < 100 then
						self:focusByBuildingType(buildingId, arr[2], posOffsetY)
					else
						self:focusByBuildingId(buildingId, arr[2], posOffsetY)
					end
				else
					logError("不在小屋场景，指引失败 " .. self.guideId .. "_" .. self.stepId)
					self:onDone(true)
				end
			end
		end
	end
end

function GuideActionRoomFocusBlockBuildingPut:focusByBuildingType(buildingType, posOffsetX, posOffsetY)
	local list = RoomMapBuildingModel.instance:getBuildingListByType(buildingType)
	local hexPoint

	if list then
		for i, v in ipairs(list) do
			if v:isInMap() then
				hexPoint = v.hexPoint

				local scene = GameSceneMgr.instance:getCurScene()

				if scene.buildingmgr then
					local entity = scene.buildingmgr:getBuildingEntity(v.id, SceneTag.RoomBuilding)
					local goPath = entity and SLFramework.GameObjectHelper.GetPath(entity.go)

					GuideModel.instance:setNextStepGOPath(self.guideId, self.stepId, goPath)

					break
				end
			end
		end
	end

	self:_focusByPoint(hexPoint, posOffsetX, posOffsetY)
end

function GuideActionRoomFocusBlockBuildingPut:focusByBuildingId(buildingId, posOffsetX, posOffsetY)
	local mo = RoomMapBuildingModel.instance:getBuildingMoByBuildingId(buildingId)
	local hexPoint

	if mo and mo:isInMap() then
		hexPoint = mo.hexPoint
	else
		local nearRotate = self:getNearRotate(buildingId)
		local bestPositionParam = RoomBuildingHelper.getRecommendHexPoint(buildingId, nil, nil, nil, nearRotate)

		hexPoint = bestPositionParam and bestPositionParam.hexPoint
	end

	self:_focusByPoint(hexPoint, posOffsetX, posOffsetY)
end

function GuideActionRoomFocusBlockBuildingPut:_focusByPoint(hexPoint, posOffsetX, posOffsetY)
	if hexPoint then
		local pos = HexMath.hexToPosition(hexPoint, RoomBlockEnum.BlockSize)
		local cameraParam = {
			focusX = pos.x + posOffsetX,
			focusY = pos.y + posOffsetY
		}

		GameSceneMgr.instance:getCurScene().camera:tweenCamera(cameraParam)
		TaskDispatcher.runDelay(self._onDone, self, 0.7)
	else
		self:onDone(true)
	end
end

function GuideActionRoomFocusBlockBuildingPut:_onDone(percent)
	self:onDone(true)
end

function GuideActionRoomFocusBlockBuildingPut:getNearRotate(buildingId)
	local roomScene = RoomCameraController.instance:getRoomScene()
	local nearRotate = roomScene.camera:getCameraRotate()
	local rotation = nearRotate * Mathf.Rad2Deg

	nearRotate = RoomRotateHelper.getCameraNearRotate(rotation)

	local buildingConfig = RoomConfig.instance:getBuildingConfig(buildingId)

	nearRotate = nearRotate + buildingConfig.rotate

	return nearRotate
end

function GuideActionRoomFocusBlockBuildingPut:clearWork()
	TaskDispatcher.cancelTask(self._onDone, self)
end

return GuideActionRoomFocusBlockBuildingPut
