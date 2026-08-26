-- chunkname: @modules/logic/scene/shelter/comp/SurvivalShelterSceneAmbientComp.lua

module("modules.logic.scene.shelter.comp.SurvivalShelterSceneAmbientComp", package.seeall)

local SurvivalShelterSceneAmbientComp = class("SurvivalShelterSceneAmbientComp", SurvivalSceneAmbientComp)

function SurvivalShelterSceneAmbientComp:onSceneStart(sceneId, levelId)
	SurvivalController.instance:registerCallback(SurvivalEvent.SceneLightLoaded, self._onLightLoaded, self)
end

return SurvivalShelterSceneAmbientComp
