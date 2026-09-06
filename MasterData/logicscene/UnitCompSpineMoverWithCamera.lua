-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/battle/UnitCompSpineMoverWithCamera.lua

module("logicscene.scene.unit.component.UnitCompSpineMoverWithCamera", package.seeall)

local UnitCompSpineMoverWithCamera = class("UnitCompSpineMoverWithCamera", UnitCompSpineMover)
local cameraTransform

function UnitCompSpineMoverWithCamera:playWalkAnim(dirX, dirY, dirZ)
	if not cameraTransform then
		local mainCamera = CameraTargetMgr.instance:getMainCameraTarget()

		cameraTransform = mainCamera:getCamera().transform
	end

	local dx, dy, _ = AMTargetPosition.InverseTransformDirection(cameraTransform, dirX, dirY, dirZ, nil, nil, nil)

	UnitCompSpineMoverWithCamera.super.playWalkAnim(self, dx, dy)
end

return UnitCompSpineMoverWithCamera
