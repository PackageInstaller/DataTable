-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/characterinformation/view/new/CharacterVoiceTipsViewPresentor.lua

module("logic.extensions.characterinformation.view.new.CharacterVoiceTipsViewPresentor", package.seeall)

local M = class("CharacterVoiceTipsViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.CharacterSystem_role_voice_tips_copy
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, CharacterVoiceTipsView.New())
	table.insert(views, TitleView.New())
	table.insert(views, BlurBgView.New())

	return views
end

return M
