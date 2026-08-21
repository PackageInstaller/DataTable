-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/characterinformation/view/new/CharacterFileTipsPresentor.lua

module("logic.extensions.characterinformation.view.new.CharacterFileTipsPresentor", package.seeall)

local M = class("CharacterFileTipsPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.CharacterSystem_role_file_tips_copy
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, CharacterFileTips.New())
	table.insert(views, TitleView.New())
	table.insert(views, BlurBgView.New())
	table.insert(views, GuiTimelineGadgetView.New())

	return views
end

return M
