-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/logic/handles/StoryHandleSceneOpen.lua

module("logic.extensions.story.core.logic.handles.StoryHandleSceneOpen", package.seeall)

local M = class("StoryHandleSceneOpen")

function M:Handle(config, binder)
	if not config then
		return
	end

	if not binder then
		return
	end

	local _key = config:GetArgValue(StoryArgKeyConst.RefAssets)
	local sceneObj = binder:GetBindObject(_key)
	local sceneName = sceneObj and sceneObj.name or nil

	if string.nilorempty(sceneName) then
		return
	end

	local _url = StoryLogicResPathUtils.GetScenePath(sceneName)

	SceneMapResMgr.instance:load(_url, false)

	return sceneName, _url
end

return M
