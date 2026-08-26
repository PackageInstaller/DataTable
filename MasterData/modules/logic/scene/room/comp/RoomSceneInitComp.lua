-- chunkname: @modules/logic/scene/room/comp/RoomSceneInitComp.lua

module("modules.logic.scene.room.comp.RoomSceneInitComp", package.seeall)

local RoomSceneInitComp = class("RoomSceneInitComp", BaseSceneComp)

function RoomSceneInitComp:onInit()
	self._originalCameraTransparencySortModeList = nil
end

function RoomSceneInitComp:init(sceneId, levelId)
	self:_setTransparencySortMode()
	RoomMapController.instance:initMap()
	RoomHelper.initSceneRootTrs()
end

function RoomSceneInitComp:onSceneClose()
	self:_revertTransparencySortMode()

	local nextSceneType = GameSceneMgr.instance:getNextSceneType()

	if nextSceneType ~= SceneType.Room and RoomController.instance:isObMode() then
		-- block empty
	end

	RoomMapController.instance:clearMap()
end

function RoomSceneInitComp:_setTransparencySortMode()
	self._originalCameraTransparencySortModeList = {}

	local mainCamera = CameraMgr.instance:getMainCamera()
	local unitCamera = CameraMgr.instance:getUnitCamera()
	local orthCamera = CameraMgr.instance:getOrthCamera()

	self:_setTransparencySortModeSingleCamera(mainCamera)
	self:_setTransparencySortModeSingleCamera(unitCamera)
	self:_setTransparencySortModeSingleCamera(orthCamera)
end

function RoomSceneInitComp:_setTransparencySortModeSingleCamera(camera)
	if not camera then
		return
	end

	table.insert(self._originalCameraTransparencySortModeList, {
		camera = camera,
		originalTransparencySortMode = camera.transparencySortMode
	})

	camera.transparencySortMode = UnityEngine.TransparencySortMode.Default
end

function RoomSceneInitComp:_revertTransparencySortMode()
	if not self._originalCameraTransparencySortModeList then
		return
	end

	for i, param in ipairs(self._originalCameraTransparencySortModeList) do
		param.camera.transparencySortMode = param.originalTransparencySortMode
	end
end

return RoomSceneInitComp
