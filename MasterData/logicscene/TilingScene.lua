-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/impl/TilingScene.lua

module("logicscene.scene.impl.TilingScene", package.seeall)

local TilingScene = class("TilingScene", CityScene)

function TilingScene:_initComponents()
	self:_addComponent("unitFactory", CityUnitFactory)
	self:_addComponent("camera", CitySceneCameraEx)
	self:_addComponent("stage", TilingSceneStage)
	self:_addComponent("pathFinder", ScenePathFinderEx)
	self:_addComponent("joystick", SceneJoystickListenerEx)
	self:_addComponent("picker", ScenePickerEx)
	self:_addComponent("walkEff", MainPlayerWalkDestEff)
	self:_addComponent("resCache", SceneResObjectCache)
	self:_addComponent("elements", TilingElemsMgr)
	self:_addComponent("bgm", TilingSceneBgmMgr)
end

function TilingScene:onEnterFinished()
	TilingScene.super.onEnterFinished(self)

	local mainPlayer = SceneMainPlayer.instance:getMainPlayer()

	if mainPlayer then
		mainPlayer.syncPos:disable(true)
	end
end

return TilingScene
