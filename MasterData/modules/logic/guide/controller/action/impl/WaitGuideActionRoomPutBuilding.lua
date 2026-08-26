-- chunkname: @modules/logic/guide/controller/action/impl/WaitGuideActionRoomPutBuilding.lua

module("modules.logic.guide.controller.action.impl.WaitGuideActionRoomPutBuilding", package.seeall)

local WaitGuideActionRoomPutBuilding = class("WaitGuideActionRoomPutBuilding", BaseGuideAction)

function WaitGuideActionRoomPutBuilding:onStart(context)
	self._sceneType = SceneType.Room

	WaitGuideActionRoomPutBuilding.super.onStart(self, context)
	RoomMapController.instance:registerCallback(RoomEvent.UseBuildingReply, self._onUseBuildingReply, self)
	GameSceneMgr.instance:registerCallback(self._sceneType, self._onEnterScene, self)

	local param = string.splitToNumber(self.actionParam, "#")

	self._buildingId = param[1]
	self._notAutoPutBuilding = param[2] == 1
	self._toastId = param[3]

	self:_check()
end

function WaitGuideActionRoomPutBuilding:_check()
	if self._waitUseBuildingReply or self._waitManufactureBuildingInfoChange then
		return
	end

	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Room then
		return
	end

	local list = RoomModel.instance:getBuildingInfoList()
	local mo

	if list then
		for k, v in pairs(list) do
			if v.buildingId == self._buildingId then
				mo = v

				break
			end
		end
	end

	if mo and mo.use then
		self:onDone(true)
	elseif mo then
		if not self._notAutoPutBuilding then
			self:putBuilding(mo)
		elseif self._toastId then
			GameFacade.showToast(self._toastId)
		end
	else
		self:onDone(true)
	end
end

function WaitGuideActionRoomPutBuilding:_onUseBuildingReply()
	self._waitUseBuildingReply = false

	self:_check()
end

function WaitGuideActionRoomPutBuilding:_onManufactureBuildingInfoChange()
	self._waitManufactureBuildingInfoChange = false

	self:_check()
end

function WaitGuideActionRoomPutBuilding:_onEnterScene(sceneId, enterOrExit)
	if enterOrExit == 1 then
		self:_check()
	end
end

function WaitGuideActionRoomPutBuilding:clearWork()
	RoomMapController.instance:unregisterCallback(RoomEvent.UseBuildingReply, self._onUseBuildingReply, self)
	GameSceneMgr.instance:unregisterCallback(self._sceneType, self._onEnterScene, self)
	ManufactureController.instance:unregisterCallback(ManufactureEvent.ManufactureBuildingInfoChange, self._onManufactureBuildingInfoChange, self)
end

function WaitGuideActionRoomPutBuilding:putBuilding(mo)
	local uid = mo.uid
	local nearRotate = self:getNearRotate(self._buildingId)
	local bestPositionParam = RoomBuildingHelper.getRecommendHexPoint(self._buildingId, nil, nil, nil, nearRotate)

	if bestPositionParam then
		if not bestPositionParam.rotate then
			local rotate = nearRotate
			local hexPoint = bestPositionParam and bestPositionParam.hexPoint

			if hexPoint then
				local param = {
					buildingUid = uid,
					hexPoint = hexPoint,
					rotate = rotate
				}
				local scene = RoomCameraController.instance:getRoomScene()

				scene.fsm:triggerEvent(RoomSceneEvent.TryPlaceBuilding, param)

				self._waitUseBuildingReply = true

				if self._buildingId == 22001 then
					self._waitManufactureBuildingInfoChange = true

					ManufactureController.instance:registerCallback(ManufactureEvent.ManufactureBuildingInfoChange, self._onManufactureBuildingInfoChange, self)
				end

				RoomMapController.instance:useBuildingRequest(uid, rotate, hexPoint.x, hexPoint.y)
			else
				self:onDone(true)
			end
		end
	end
end

function WaitGuideActionRoomPutBuilding:getNearRotate(buildingId)
	local roomScene = RoomCameraController.instance:getRoomScene()
	local nearRotate = roomScene.camera:getCameraRotate()
	local rotation = nearRotate * Mathf.Rad2Deg

	nearRotate = RoomRotateHelper.getCameraNearRotate(rotation)

	local buildingConfig = RoomConfig.instance:getBuildingConfig(buildingId)

	nearRotate = nearRotate + buildingConfig.rotate

	return nearRotate
end

return WaitGuideActionRoomPutBuilding
