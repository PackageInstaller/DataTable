-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/preinstall/CharacterPreinstallViewPresentor.lua

module("logic.extensions.charactersystem.view.preinstall.CharacterPreinstallViewPresentor", package.seeall)

local M = class("CharacterPreinstallViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.CharacterSystem_Character_Preinstall
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, CharacterPreinstallView.New())
	table.insert(views, BlurBgView.New("common_blur_rt"))

	return views
end

return M
