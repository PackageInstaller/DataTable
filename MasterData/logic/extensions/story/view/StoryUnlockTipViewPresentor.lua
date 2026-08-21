-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/view/StoryUnlockTipViewPresentor.lua

module("logic.extensions.story.view.StoryUnlockTipViewPresentor", package.seeall)

local M = class("StoryUnlockTipViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Dialog_juqing_hint
	}
end

function M:attachToWhichRoot()
	return ViewRootType.Notify
end

function M:buildViews()
	local views = {}

	table.insert(views, StoryUnlockTipView.New())

	return views
end

return M
