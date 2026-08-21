-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/utils/StorySceneMgr.lua

module("logic.extensions.story.core.utils.StorySceneMgr", package.seeall)

loaderList = {}

function hasSceneLoader(url)
	return loaderList[url] ~= nil
end

function getSceneLoader(url)
	return loaderList[url]
end

function addSceneLoader(url, loader)
	if StorySceneMgr.hasSceneLoader(url) then
		printWarn("已存在加载场景的loader,url=", url)

		return
	end

	if loader == nil then
		printError("loader不能为空")

		return
	end

	if not url then
		return
	end

	if string.nilorempty(url) then
		return
	end

	loaderList[url] = loader
end

function removeSceneLoader(url, isDispose)
	if isDispose and hasSceneLoader(url) then
		loaderList[url]:dispose()
	end

	loaderList[url] = nil
end

function disposeAllSceneLoader()
	for key, value in pairs(StorySceneMgr.loaderList) do
		value:dispose()
	end

	StorySceneMgr.loaderList = {}
end
