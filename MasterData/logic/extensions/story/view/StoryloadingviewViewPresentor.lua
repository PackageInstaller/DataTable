-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/view/StoryloadingviewViewPresentor.lua

module("logic.extensions.story.view.StoryloadingviewViewPresentor", package.seeall)

local M = class("StoryloadingviewViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Story_storyloadingview
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, StoryLoadingViewComponent.New())

	return views
end

function M:attachToWhichRoot()
	return ViewRootType.Top
end

function M:onClickOutside()
	return
end

return M
