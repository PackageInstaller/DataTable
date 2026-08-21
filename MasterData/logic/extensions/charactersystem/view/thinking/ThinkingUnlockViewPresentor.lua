-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/thinking/ThinkingUnlockViewPresentor.lua

module("logic.extensions.charactersystem.view.thinking.ThinkingUnlockViewPresentor", package.seeall)

local M = class("ThinkingUnlockViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Thought_thought_unlock_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, ThinkingUnlockView.New())
	table.insert(views, BlurBgView.New())

	return views
end

return M
