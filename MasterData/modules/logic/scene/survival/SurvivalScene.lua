-- chunkname: @modules/logic/scene/survival/SurvivalScene.lua

module("modules.logic.scene.survival.SurvivalScene", package.seeall)

local SurvivalScene = class("SurvivalScene", BaseScene)

function SurvivalScene:_createAllComps()
	self:_addComp("pointEffect", SurvivalPointEffectComp)
	self:_addComp("fog", SurvivalSceneFogComp)
	self:_addComp("camera", SurvivalSceneCameraComp)
	self:_addComp("director", SurvivalSceneDirector)
	self:_addComp("block", SurvivalSceneMapBlock)
	self:_addComp("spBlock", SurvivalSceneMapSpBlock)
	self:_addComp("path", SurvivalSceneMapPath)
	self:_addComp("unit", SurvivaSceneMapUnitComp)
	self:_addComp("level", SurvivalSceneLevel)
	self:_addComp("view", SurvivalSceneViewComp)
	self:_addComp("preloader", SurvivalScenePreloader)
	self:_addComp("volume", SurvivalScenePPVolume)
	self:_addComp("graphics", SurvivalSceneGraphicsComp)
	self:_addComp("cloud", SurvivalSceneCloudComp)
	self:_addComp("ambient", SurvivalSceneAmbientComp)
end

function SurvivalScene:onClose()
	local nextSceneType = GameSceneMgr.instance:getNextSceneType()

	if not SurvivalMapHelper.instance:isSurvivalScene(nextSceneType) then
		SurvivalMapHelper.instance:clear()
	end

	SurvivalScene.super.onClose(self)
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.stop_ui_fuleyuan_tansuo_dutiao_loop)
end

return SurvivalScene
