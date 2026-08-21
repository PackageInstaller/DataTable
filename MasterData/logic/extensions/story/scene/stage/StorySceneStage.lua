-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/scene/stage/StorySceneStage.lua

module("logic.extensions.story.scene.stage.StorySceneStage", package.seeall)

local StorySceneStage = class("StorySceneStage", SceneStageBase)
local kEmptySceneName = "sx-story_empty_run"
local kEmptyScenePath = "sx-story_empty/scene_run/sx-story_empty_run"

function StorySceneStage:onInit()
	self._resLoader = MultiResLoader.New()
	self._mainSceneName = false
end

function StorySceneStage:load(sceneId)
	self._mainSceneName = kEmptySceneName

	local resLoader = self._resLoader

	resLoader:addResPath(GameUrl.getSceneUrl(kEmptyScenePath), false)
	resLoader:load(self._onAllResourceLoaded, false, self)
end

function StorySceneStage:getSceneName()
	return self._mainSceneName
end

function StorySceneStage:_onAllResourceLoaded()
	local resLoader = self._resLoader

	if not resLoader:isAllSuccess() and enableErrorLog then
		printError("load resource failed!")
	end

	SceneUtil.removeArtTestSceneGameObject(self._mainSceneName)
	self:_onAllLoaded()
	ViewMgr.instance:close(ViewName.MainUIView)
end

function StorySceneStage:unload()
	self._resLoader:clear()
end

return StorySceneStage
