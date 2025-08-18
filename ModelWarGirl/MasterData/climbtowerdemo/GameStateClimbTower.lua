-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClimbTowerDemo\\GameStateClimbTower.lua

local GameState = require("GameFsm/GameState")
local ResScene = require("ClientData/ResScene")
local UIUtils = require("Framework.UI.UIUtils")
local GameSettings = require("Helper/GameSettings")
local ClimbTowerDragCenter = require("ClimbTowerDemo/ClimbTowerDragCenter")
local DeviceHelper = require("Helper/DeviceHelper")
local DoLoadWaitClimbTower = require("ClimbTowerDemo/DoLoadWaitClimbTower")
local ClimbTowerDragWall = require("ClimbTowerDemo/ClimbTowerDragWall")
local ResMiniGameMisc = require("ClientData/ResMiniGameMisc")
local CameraManager = Framework.CameraSystem.CameraManager
local GameObject = UnityEngine.GameObject
local strClassName = "GameStateClimbTower"
local GameStateClimbTower = Class(strClassName, GameState)
local SCREEN_RATIO = DeviceHelper.curWidth / DeviceHelper.curHeight
local MAX_Z = 66.3
local csharpScale = 1

if SCREEN_RATIO < 1.7777777777777777 then
	csharpScale = SCREEN_RATIO / 1.7777777777777777
end

local csharpScaleAll = SCREEN_RATIO / 1.7777777777777777
local CAMERA_START_DEFAULT_Y = 15.8
local CAMERA_MODE = {
	{
		fov = 23,
		pos = Vector3(42.6, 17, 66.3)
	}
}
local BOUNDS_TYPE = {
	EDIT_ZOOM = 2,
	EDIT_MOVE = 1
}

function GameStateClimbTower:ctor(name)
	self.sceneNo = 12
	self._waitLoadFinishPhase = DoLoadWaitClimbTower(self)
end

function GameStateClimbTower:onEnter(preStateName)
	GameStateClimbTower.super.onEnter(self, preStateName)

	self.limitHeight = nil
	self.curCameraMode = 3
	self.isInitIn = true
	self.debugTime = Time.time

	LoadManager.addLoadPhase(self._waitLoadFinishPhase)
end

function GameStateClimbTower:onExit(nextStateName)
	self:setCameraOrthographic(false)
	ClimbTowerDragCenter.destroy()
	GameSettings.resetShadowDistance("Rear")
	GameStateClimbTower.super.onExit(self, nextStateName)

	self.curUI = nil
end

function GameStateClimbTower:onSceneLoaded()
	GameStateClimbTower.super.onSceneLoaded(self)

	if ResScene[self.sceneNo] and ResScene[self.sceneNo].camera_pos and ResScene[self.sceneNo].camera_rot then
		local pos = ResScene[self.sceneNo].camera_pos
		local rot = ResScene[self.sceneNo].camera_rot
		local fov = ResScene[self.sceneNo].camera_fov or 20

		if SCREEN_RATIO < 1.7777777777777777 then
			fov = ResMiniGameMisc[1].special_fov or 24
		end

		CameraModeManager.setMainStageMode()

		local transform = CameraManager.GetControlNodeTransform(CameraModeManager.mainCamera)

		if transform then
			transform.position = Vector3(pos[1], pos[2], pos[3])
			transform.rotation = Quaternion.Euler(rot[1], rot[2], rot[3])
			self.nodeTransform = transform
		end

		self:_setCameraFov(fov, 0)
		self:setCameraPostProcess(ResScene[self.sceneNo].camera_post_cue)
	end

	self:init()
end

function GameStateClimbTower:setCameraPostProcess(postCue)
	if self.postCue then
		CueManager.releaseCue(nil, self.postCue)
	end

	self.postCue = postCue

	if self.postCue then
		CueManager.playCue(nil, self.postCue)
	end
end

function GameStateClimbTower:setRearHouseShadow(...)
	GameSettings.setShadowDistance(50, "Rear")
end

function GameStateClimbTower:onLoadEnded()
	GameStateClimbTower.super.onLoadEnded(self)
	CameraManager.SetMainCameraEnable(true)
	self:setRearHouseShadow()
end

function GameStateClimbTower:calculateLimitData(...)
	local editBounds = self:getBoundsByType(BOUNDS_TYPE.EDIT_ZOOM)
	local width = editBounds.leftUpPos.x - editBounds.rightDownPos.x
	local height = editBounds.leftUpPos.y - self:getLimitHeight() - editBounds.rightDownPos.y

	if SCREEN_RATIO > width / height then
		local xOffset = (editBounds.leftUpPos.x - editBounds.rightDownPos.x) * 0.5
		local yOffset = xOffset / SCREEN_RATIO
		local distance = yOffset / math.tan(math.rad(CAMERA_MODE[1].fov * 0.5))
		local z = distance + editBounds.z

		CAMERA_MODE[1].pos.z = math.min(z, MAX_Z)
	else
		local halfHeight = height * 0.5
		local distance = halfHeight / math.tan(math.rad(CAMERA_MODE[1].fov * 0.5))
		local z = distance + editBounds.z

		CAMERA_MODE[1].pos.z = math.min(z, MAX_Z)
	end

	local centerY = (editBounds.leftUpPos.x - editBounds.rightDownPos.x) / 2
	local widthY = centerY - CAMERA_START_DEFAULT_Y

	CAMERA_MODE[1].pos.y = centerY - widthY * csharpScaleAll
end

function GameStateClimbTower:getLimitHeight(...)
	self.limitHeight = 15

	return self.limitHeight
end

function GameStateClimbTower:tweenMoveCamreaX(xOffset, time)
	local cameraPos = self.nodeTransform.position

	cameraPos.x = cameraPos.x + xOffset

	self:tweenPosAndFov(cameraPos, time)
end

function GameStateClimbTower:tweenMoveCamreaBack(time)
	local cameraPos = self.nodeTransform.position

	cameraPos.x = ResScene[self.sceneNo].camera_pos[1]

	self:tweenPosAndFov(cameraPos, time or 1)
end

function GameStateClimbTower:tweenPosAndFov(cameraPos, duration)
	cameraPos.z = self.fov

	if duration == 0 then
		self:tweenFovCallBack(cameraPos.x, cameraPos.y, cameraPos.z)
	else
		CameraManager.CameraGrp:SetPosAndFov(cameraPos, duration, Slot(self.tweenFovCallBack, self), Const.TWEEN_EASE.InOutSine)
	end
end

function GameStateClimbTower:initBoundsInfo(...)
	self.bounds = {}

	local bounds
	local boundsInfo = ClimbTowerDragCenter.getCurWallBoundsInfo()

	for k, v in pairs(BOUNDS_TYPE) do
		if string.find(k, "EDIT") ~= nil then
			bounds = utils.deepcopy(boundsInfo.edit)
		end

		self.bounds[v] = bounds
	end
end

function GameStateClimbTower:getBoundsByType(typeId)
	return self.bounds[typeId]
end

function GameStateClimbTower:getDistance(...)
	local boundsInfo = ClimbTowerDragCenter.getCurWallBoundsInfo()

	if boundsInfo then
		return self.nodeTransform.position.z - boundsInfo.edit.z
	else
		return 0
	end
end

function GameStateClimbTower:getSizeByFov(fov)
	return math.tan(math.rad(fov * 0.5)) * self:getDistance()
end

function GameStateClimbTower:_setCameraFov(fov, duration)
	self.fov = fov

	CameraManager.CameraGrp:SetFov(fov, duration)
end

function GameStateClimbTower:tweenFovCallBack(x, y, fov)
	fov = self.fov

	local pos = self:getCameraPos()

	pos.x = x
	pos.y = y
	self.nodeTransform.position = pos
end

function GameStateClimbTower:setCurUI(ui)
	self.curUI = ui
end

function GameStateClimbTower:setCameraOrthographic(v)
	self.CameraOrthographic = v

	CameraManager.CameraGrp:SetCameraOrthographic(v)

	local size = math.tan(math.rad(self.fov * 0.5)) * self:getDistance()

	CameraManager.CameraGrp.CameraOrthographicSize = size
end

function GameStateClimbTower:init(...)
	ClimbTowerDragCenter.start(self)
	self:initCreate()
end

function GameStateClimbTower:initCreate(...)
	ClimbTowerDragCenter.dataReady()
end

function GameStateClimbTower:getCameraPos(...)
	return self.nodeTransform.position
end

function GameStateClimbTower:initWall(index, withoutCheck)
	ClimbTowerDragCenter.initWall(index, withoutCheck)
end

function GameStateClimbTower:checkMainDlg(...)
	local mainName = "miniGameInfoDlg"
	local ui = UIManager.tryGetUI(mainName)

	if ui then
		return
	end

	if not self:checkEnterReason() and not ui then
		UIManager.getUI(mainName, true):setData(Const.MINI_GAME_TYPE_CLIMB_TOWER)
	end

	UIManager.tryHideUI("mainMenu")
	UIManager.tryHideUI("mainStageDlg")
	UIManager.tryHideUI("homeBg")
end

return GameStateClimbTower
