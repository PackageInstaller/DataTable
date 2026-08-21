-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/characterportrait/view/CharacterPotraitPreviewViewPresentor.lua

module("logic.extensions.characterportrait.view.CharacterPotraitPreviewViewPresentor", package.seeall)

local M = class("CharacterPotraitPreviewViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Background_backgroup_preview
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, CharacterPotraitPreviewView.New())

	return views
end

return M
