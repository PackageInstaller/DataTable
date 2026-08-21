-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/equip/EquipTimingAnimationViewPresentor.lua

module("logic.extensions.charactersystem.view.equip.EquipTimingAnimationViewPresentor", package.seeall)

local M = class("EquipTimingAnimationViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Equipsystem_timing_or_reset_show_view,
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_CharacterSystem)
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, EquipTimingAnimationView.New())
	table.insert(views, BlurBgView.New())

	return views
end

return M
