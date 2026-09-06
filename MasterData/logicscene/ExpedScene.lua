-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/impl/ExpedScene.lua

module("logicscene.scene.impl.ExpedScene", package.seeall)

local ExpedScene = class("ExpedScene", TilingScene)

function ExpedScene:_initComponents()
	self:_addComponent("unitFactory", CityUnitFactory)
	self:_addComponent("camera", CitySceneCameraEx)
	self:_addComponent("stage", ExpedSceneStage)
	self:_addComponent("pathFinder", ScenePathFinderEx)
	self:_addComponent("joystick", SceneJoystickListenerEx)
	self:_addComponent("picker", ScenePickerEx)
	self:_addComponent("walkEff", MainPlayerWalkDestEff)
	self:_addComponent("resCache", SceneResObjectCache)
	self:_addComponent("elements", ExpedTilingElemsMgr)
	self:_addComponent("bgm", TilingSceneBgmMgr)
end

function ExpedScene:getSceneType()
	return SceneType.ExpedScene
end

function ExpedScene:getDefaultView()
	return ViewName.ExpMap
end

function ExpedScene:onEnter(sceneId, bornX, bornZ)
	ExpedScene.super.onEnter(self, sceneId, bornX, bornZ)
	ExpeditionTilingModel.instance:setInTilingMapScene(true)
end

function ExpedScene:onExit()
	ExpeditionTilingModel.instance:setInTilingMapScene(nil)
	ExpedScene.super.onExit(self)
end

function ExpedScene:onEnterFinished()
	ExpedScene.super.onEnterFinished(self)

	local battleData = ExpeditionModel.instance:getRunBattleGridData()

	ExpeditionModel.instance:setRunBattleGridData(nil)

	if ExpeditionController.instance:isBattleBuffEvent(battleData) then
		ExpeditionController.instance:openEventView(battleData)
	end
end

return ExpedScene
