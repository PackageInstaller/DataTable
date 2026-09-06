-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/season/SceneCompSeasonGridsInfo.lua

module("logicscene.scene.component.season.SceneCompSeasonGridsInfo", package.seeall)

local SceneCompSeasonGridsInfo = class("SceneCompSeasonGridsInfo", SceneComponentBase)

function SceneCompSeasonGridsInfo:ctor(scene)
	SceneCompSeasonGridsInfo.super.ctor(self, scene)
end

function SceneCompSeasonGridsInfo:onEnterSceneFinished(sceneId, bornX, bornZ)
	SceneCompSeasonGridsInfo.super.onEnterSceneFinished(self, sceneId, bornX, bornZ)
end

function SceneCompSeasonGridsInfo:getSceneGridsDimension()
	return SeasonPathFindingDataModel.instance:getSceneGridsDimension()
end

function SceneCompSeasonGridsInfo:getScenePreNum()
	return SeasonPathFindingDataModel.instance:getScenePreNum()
end

function SceneCompSeasonGridsInfo:getSceneGridsData()
	return SeasonPathFindingDataModel.instance:getSceneGridsData()
end

function SceneCompSeasonGridsInfo:getSceneGridVersion()
	return SeasonPathFindingDataModel.instance:getSceneGridVersion()
end

function SceneCompSeasonGridsInfo:pos2Grid(posX, posY)
	return SeasonPathFindingDataModel.instance:pos2Grid(posX, posY)
end

function SceneCompSeasonGridsInfo:grid2Pos(gridX, gridY)
	return SeasonPathFindingDataModel.instance:grid2Pos(gridX, gridY)
end

function SceneCompSeasonGridsInfo:getInternalPathFinder()
	return SeasonPathFindingDataModel.instance:getInternalPathFinder()
end

return SceneCompSeasonGridsInfo
