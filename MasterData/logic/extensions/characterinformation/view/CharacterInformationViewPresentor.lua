-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/characterinformation/view/CharacterInformationViewPresentor.lua

module("logic.extensions.characterinformation.view.CharacterInformationViewPresentor", package.seeall)

local M = class("CharacterInformationViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Charactersystem_role_information_panel,
		ResName.Information_role_other_item,
		ResName.Information_role_voice_item,
		ResName.Information_role_special_voice_item
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, CharacterInformationView.New())
	table.insert(views, TitleView.New())

	return views
end

return M
