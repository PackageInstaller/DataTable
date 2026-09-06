-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/stage/PetZooSceneStage.lua

module("logicscene.scene.component.stage.PetZooSceneStage", package.seeall)

local PetZooSceneStage = class("PetZooSceneStage", SceneCityStage)

function PetZooSceneStage:_startJumperUIRes()
	self:_onlyLoadDeaultUIRes()
end

function PetZooSceneStage:_prepareElementsResourcesByDetector(x, y, sz, sy)
	local eleResources = self.wholeScene:GetTerrainElementsResourcesByDetector(x, y, sz, sy)
	local cnt = eleResources.Count - 1

	for i = 0, cnt do
		self:_addSceneResource(eleResources[i])
		self:_addNeedLoadResource(eleResources[i])
	end
end

function PetZooSceneStage:_getStageResources(sceneId)
	local tilingConfig = TilingSceneMgr.instance:getTilingSceneConfig(sceneId)

	return {
		tilingConfig.assetPath
	}
end

return PetZooSceneStage
