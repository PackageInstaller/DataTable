-- chunkname: @modules/logic/scene/survival/comp/SurvivalSceneAmbientComp.lua

module("modules.logic.scene.survival.comp.SurvivalSceneAmbientComp", package.seeall)

local SurvivalSceneAmbientComp = class("SurvivalSceneAmbientComp", BaseSceneComp)

function SurvivalSceneAmbientComp:onSceneStart(sceneId, levelId)
	SurvivalController.instance:registerCallback(SurvivalEvent.SceneLightLoaded, self._onLightLoaded, self)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnMapGameTimeUpdate, self.updateSceneAmbient, self)
end

function SurvivalSceneAmbientComp:_onLightLoaded(lightGo)
	SurvivalSceneAmbientUtil.instance:_onLightLoaded(lightGo)
end

function SurvivalSceneAmbientComp:updateSceneAmbient()
	SurvivalSceneAmbientUtil.instance:updateSceneAmbient()
end

function SurvivalSceneAmbientComp:onSceneClose()
	SurvivalController.instance:unregisterCallback(SurvivalEvent.SceneLightLoaded, self._onLightLoaded, self)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnMapGameTimeUpdate, self.updateSceneAmbient, self)
	SurvivalSceneAmbientUtil.instance:disable()
end

return SurvivalSceneAmbientComp
