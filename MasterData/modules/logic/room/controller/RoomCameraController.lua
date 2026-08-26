-- chunkname: @modules/logic/room/controller/RoomCameraController.lua

module("modules.logic.room.controller.RoomCameraController", package.seeall)

local RoomCameraController = class("RoomCameraController", BaseController)

function RoomCameraController:onInit()
	return
end

function RoomCameraController:reInit()
	return
end

function RoomCameraController:onInitFinish()
	return
end

function RoomCameraController:resetCameraStateByKey(keyname)
	if self:isHasCameraStateByKey(keyname) then
		local cameraParam = self._viewNameCameraStateDict[keyname]

		self._viewNameCameraStateDict[keyname] = nil

		local scene = self:getRoomScene()

		if scene then
			scene.cameraFollow:setFollowTarget(nil)
			scene.camera:switchCameraState(cameraParam.cameraState, {
				zoom = cameraParam.zoom
			})
			scene.fovblock:clearLookParam()
		end
	end
end

function RoomCameraController:saveCameraStateByKey(keyname, replaceCameraState)
	self._viewNameCameraStateDict = self._viewNameCameraStateDict or {}

	local roomCamera = self:getRoomCamera()

	if roomCamera then
		local cameraState = replaceCameraState or roomCamera:getCameraState()

		self._viewNameCameraStateDict[keyname] = {
			cameraState = cameraState,
			zoom = roomCamera:getCameraZoom()
		}
	end
end

function RoomCameraController:isHasCameraStateByKey(keyname)
	if self._viewNameCameraStateDict and self._viewNameCameraStateDict[keyname] then
		return true
	end

	return false
end

function RoomCameraController:getRoomScene()
	local scene = GameSceneMgr.instance:getCurScene()

	if scene and GameSceneMgr.instance:getCurSceneType() == SceneType.Room then
		return scene
	end

	return nil
end

function RoomCameraController:getRoomCamera()
	local scene = self:getRoomScene()

	if scene then
		return scene.camera
	end

	return nil
end

function RoomCameraController:tweenCameraFocusBuildingUseCameraId(buildingUid, cameraId, finishCallback, callbackObj)
	self:tweenCameraByBuildingUid(buildingUid, RoomEnum.CameraState.Manufacture, cameraId, finishCallback, callbackObj)

	local scene = self:getRoomScene()

	scene.fovblock:setLookBuildingUid(RoomEnum.CameraState.Manufacture, buildingUid)
end

function RoomCameraController:tweenCameraByBuildingUid(buildingUid, cameraState, cameraId, finishCallback, callbackObj)
	local scene = self:getRoomScene()
	local cfg = RoomConfig.instance:getCharacterBuildingInteractCameraConfig(cameraId)
	local focusXYZ = cfg and string.splitToNumber(cfg.focusXYZ, "#")

	if focusXYZ then
		if not focusXYZ[1] then
			local fx = 0

			if focusXYZ then
				if not focusXYZ[2] then
					local fy = 0

					if focusXYZ then
						if not focusXYZ[3] then
							local fz = 0

							if cfg then
								if not cfg.rotate then
									local rotate = 0
									local buildingEntity = scene.buildingmgr:getBuildingEntity(buildingUid, SceneTag.RoomBuilding)
									local foucsPos = buildingEntity:transformPoint(fx, fy, fz)
									local targetRotate = tonumber(rotate) + buildingEntity:getMO().rotate * 60

									targetRotate = RoomRotateHelper.getMod(targetRotate, 360) * Mathf.Deg2Rad

									local cameraState = cameraState
									local cameraParam = {
										focusX = foucsPos.x,
										focusY = foucsPos.z,
										zoom = scene.camera:getZoomInitValue(cameraState),
										rotate = targetRotate
									}

									scene.cameraFollow:setFollowTarget(nil)
									scene.camera:setChangeCameraParamsById(cameraState, cameraId)
									scene.camera:switchCameraState(cameraState, cameraParam, nil, finishCallback, callbackObj)
								end
							end
						end
					end
				end
			end
		end
	end
end

RoomCameraController.instance = RoomCameraController.New()

return RoomCameraController
