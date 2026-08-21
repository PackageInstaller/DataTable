-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/preview/CharacterSkillPreviewPresentor.lua

module("logic.extensions.charactersystem.view.preview.CharacterSkillPreviewPresentor", package.seeall)

local M = class("CharacterSkillPreviewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Character_preview_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, CharacterSkillPreviewView.New())
	table.insert(views, BlurBgView.New("common_blur_rt"))

	return views
end

return M
