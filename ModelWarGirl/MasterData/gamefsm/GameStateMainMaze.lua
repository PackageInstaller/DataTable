-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/GameFsm\\GameStateMainMaze.lua

local GameState = require("GameFsm/GameState")
local ResScene = require("ClientData/ResScene")
local ResMazeConfig = require("ClientData/ResMazeConfig")
local MazeControl = require("UI/Maze/MazeControl")
local DoLoadWaitLogin = require("System/Load/DoLoadWaitLogin")
local CameraManager = Framework.CameraSystem.CameraManager
local GameObject = UnityEngine.GameObject
local strClassName = "GameStateMainMaze"
local GameStateMainMaze = Class(strClassName, GameState)

function GameStateMainMaze:ctor(name)
	self.sceneNo = 10005
	self.cameraMoveLength = 4
	self._waitSyncDataPhase = DoLoadWaitLogin(self)
end

function GameStateMainMaze:onEnter(preStateName)
	self.preStateName = preStateName

	if CurAvatar and not CurAvatar.syncDataReady then
		LoadManager.addLoadPhase(self._waitSyncDataPhase)
	else
		self:refreshSceneNo()
	end

	GameStateMainMaze.super.onEnter(self, preStateName)
end

function GameStateMainMaze:onExit(nextStateName)
	GameStateMainMaze.super.onExit(self, nextStateName)

	if nextStateName == Const.STATE_MAIN_STAGE then
		MazeControl.destroy()
	end
end

function GameStateMainMaze:onSceneLoaded()
	GameStateMainMaze.super.onSceneLoaded(self)

	self.sceneInfo = ResScene[self.sceneNo]
	self.gridAngle = self.sceneInfo.dir or 0
	self.gridDirection = math.rad(self.gridAngle)
	self.leftDir = Vector3(-math.cos(self.gridDirection), 0, -math.sin(self.gridDirection))
	self.upDir = Vector3(-self.leftDir.z, 0, self.leftDir.x)

	local centerPoint = self.sceneInfo.origin_point

	self.centerPoint = Vector3(centerPoint[1], centerPoint[2], centerPoint[3])
	self.nodeTransform = CameraManager.GetControlNodeTransform(CameraModeManager.mainCamera)

	local rot = self.sceneInfo.camera_rot

	if rot then
		self.nodeTransform.rotation = Quaternion.Euler(rot[1], rot[2], rot[3])
	else
		self.nodeTransform.rotation = Quaternion.Euler(0, 0, 0)
	end

	local startPos = self.sceneInfo.camera_pos

	if startPos then
		self.cameraStartPos = Vector3(startPos[1], startPos[2], startPos[3])
	else
		self.cameraStartPos = Vector3(0, 0, 0)
	end
end

function GameStateMainMaze:onLoadEnded()
	GameStateMainMaze.super.onLoadEnded(self)
	self:refreshSceneNo()

	if not self.cameraOffsetX then
		self.cameraOffsetX = 0
	end

	if not self:checkEnterReason() then
		local preStateName = self.preStateName

		preStateName = preStateName or self.parent.preStateName

		local lookCenter = preStateName ~= Const.STATE_BATTLE or CurAvatar.mazeData.node_id == 0
		local ui = UIManager.getUI("mazeMainDlg", true)

		ui:setMainState(self)

		if lookCenter then
			ui:lookCenter()
		end
	end

	if self.preStateName == nil and self.parent.preStateName == Const.STATE_BATTLE then
		self:cameraToPos(true, 0.8)
		Framework.CameraSystem.CameraManager.CameraGrp:SetFov(self.sceneInfo.camera_fov or 60, 0.8)
	else
		self:cameraToPos(true)
		Framework.CameraSystem.CameraManager.CameraGrp:SetFov(self.sceneInfo.camera_fov or 60, 0)
	end
end

function GameStateMainMaze:cameraToPos(isInit, duration)
	self.nodeTransform.position = self.cameraStartPos + self.leftDir * (self.cameraOffsetX or 0) * 18

	if isInit then
		CameraModeManager.setMazeMode(duration)
	end
end

function GameStateMainMaze:refreshSceneNo(...)
	local data = ResMazeConfig[CurAvatar.mazeData.maze_id]

	if data then
		local no = data[1].scene_id

		if self.sceneNo ~= no then
			MazeControl.destroy()
		end

		self.sceneNo = no
		self.cameraMoveLength = data[1].scene_length
	end
end

function GameStateMainMaze:onDrag(offsetX)
	self:setCameraOffset(self.cameraOffsetX - offsetX)
end

function GameStateMainMaze:setCenterPos(pos)
	self.cameraOffsetX = self:calcCameraOffset(pos)

	self:setCameraOffset(self.cameraOffsetX)
end

function GameStateMainMaze:calcCameraOffset(pos)
	local totalPos = self.upDir * 1.2 + self.leftDir * self.cameraMoveLength * 18
	local offset = (pos - self.centerPoint - self.upDir * 1.2).x / (self.leftDir.x * 18)

	return offset
end

function GameStateMainMaze:setCameraOffset(offsetX)
	self.cameraOffsetX = math.min(self.cameraMoveLength, math.max(0, offsetX))

	self:cameraToPos()
end

return GameStateMainMaze
