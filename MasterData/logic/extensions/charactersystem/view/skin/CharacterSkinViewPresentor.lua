-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/skin/CharacterSkinViewPresentor.lua

module("logic.extensions.charactersystem.view.skin.CharacterSkinViewPresentor", package.seeall)

local M = class("CharacterSkinViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Character_Skin_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, CharacterSkinView.New())
	table.insert(views, TitleView.New():blockOrgBtn(true, false, false))

	return views
end

return M
