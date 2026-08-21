-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/viewlib/ui3d/UI3dBackground.lua

module("logic.common.viewlib.ui3d.UI3dBackground", package.seeall)

local M = class("UI3dBackground")
local kUICameraPriority = 100

function M:ctor()
	self._sceneName = false
	self._virtualCamera = false
	self._resLoader = SingleResLoader.New()
end

function M:loadScene(sceneName)
	if string.nilorempty(sceneName) then
		if enableErrorLog then
			printError("scene name is nil!")
		end

		return
	end

	self:_hideGameScene()
	self:_tryCreateVirtualCamera()

	self._sceneName = sceneName

	self._resLoader:load(GameUrl.getSceneUrl(sceneName))
end

function M:clear()
	self._sceneName = false

	self._resLoader:clear()
	self:_showGameScene()
	self:_releaseVirtualCamera()
end

function M:getSceneName()
	return self._sceneName
end

function M:setCameraPosition(x, y, z)
	self._virtualCamera:setPosition(x, y, z)
end

function M:setCameraRotation(x, y, z)
	self._virtualCamera:setRotation(x, y, z)
end

function M:setCameraFieldOfView(fov)
	self._virtualCamera:setFieldOfView(fov)
end

function M:_hideGameScene()
	local sceneName = SceneMgr.instance:getCurSceneName()

	if sceneName then
		GameObjectUtils.SetSceneActive(sceneName, false)
	end
end

function M:_showGameScene()
	local sceneName = SceneMgr.instance:getCurSceneName()

	if sceneName then
		GameObjectUtils.SetSceneActive(sceneName, true)
	end
end

function M:_tryCreateVirtualCamera()
	if not self._virtualCamera then
		self._virtualCamera = VirtualCameraUnit:createInstance()

		self._virtualCamera:setPosition(0, 0, 0)
		self._virtualCamera:setRotation(0, 0, 0)
		self._virtualCamera:setFieldOfView(60)
	end
end

function M:_releaseVirtualCamera()
	if self._virtualCamera then
		self._virtualCamera:returnSelf()

		self._virtualCamera = false
	end
end

return M
