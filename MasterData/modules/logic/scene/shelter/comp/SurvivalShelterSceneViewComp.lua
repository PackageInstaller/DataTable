-- chunkname: @modules/logic/scene/shelter/comp/SurvivalShelterSceneViewComp.lua

module("modules.logic.scene.shelter.comp.SurvivalShelterSceneViewComp", package.seeall)

local SurvivalShelterSceneViewComp = class("SurvivalShelterSceneViewComp", BaseSceneComp)

function SurvivalShelterSceneViewComp:onScenePrepared(sceneId, levelId)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._checkLevelUp, self)
	SurvivalController.instance:registerCallback(SurvivalEvent.onFlowEnd, self._checkLevelUp, self)
end

function SurvivalShelterSceneViewComp:_checkLevelUp()
	SurvivalMapHelper.instance:checkRoleLevelUpCache()
end

function SurvivalShelterSceneViewComp:onSceneClose(sceneId, levelId)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._checkLevelUp, self)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.onFlowEnd, self._checkLevelUp, self)
end

return SurvivalShelterSceneViewComp
