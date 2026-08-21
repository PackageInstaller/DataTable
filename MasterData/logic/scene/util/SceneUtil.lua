-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/util/SceneUtil.lua

module("logic.scene.util.SceneUtil", package.seeall)

local SceneUtil = {}
local kBaseSceneName = "Starter"
local kTestRegex = ".+_[b|B]ack"

function SceneUtil.removeArtTestSceneGameObject(sceneName)
	local goList = BattleTableUtil.getTempList()

	GameObjectUtils.FindChildRecursivelyBySceneName(sceneName, 1, kTestRegex, goList)

	for _, go in pairs(goList) do
		SceneUtil.moveGameObjectToBaseScene(go)
		goutil.destroy(go)
	end

	BattleTableUtil.releaseTempList(goList)
end

function SceneUtil.findSceneHumamoidAgent(sceneName)
	local goList = {}

	GameObjectUtils.FindChildRecursivelyBySceneName(sceneName, 6, "sx-s202_t-scenehight_L01", goList)

	return goList
end

function SceneUtil.moveGameObjectToBaseScene(go)
	SceneLoadUtils.MoveGameObjectToScene(go, kBaseSceneName)
end

function SceneUtil.moveGameObjectToScene(go, sceneName)
	SceneLoadUtils.MoveGameObjectToScene(go, sceneName)
end

function SceneUtil.setBaseSceneName(name)
	kBaseSceneName = name
end

function SceneUtil.getActiveSceneName()
	return SceneLoadUtils.GetActiveSceneName()
end

function SceneUtil.setupSceneOptimization(sceneName)
	local isSceneOptimizationEnable = GfxModel.instance:isSceneOptimizationEnable()

	if enableLog then
		printInfo("SceneUtil::setupSceneOptimization apply", sceneName, isSceneOptimizationEnable)
	end

	local goList = BattleTableUtil.getTempList()

	GameObjectUtils.FindChildRecursivelyBySceneName(sceneName, 6, "scene_layer_2", goList)

	for _, go in pairs(goList) do
		goutil.setActive(go, not isSceneOptimizationEnable)
	end

	BattleTableUtil.releaseTempList(goList)
end

return SceneUtil
