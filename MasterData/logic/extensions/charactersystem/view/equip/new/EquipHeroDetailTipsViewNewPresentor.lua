-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/equip/new/EquipHeroDetailTipsViewNewPresentor.lua

module("logic.extensions.charactersystem.view.equip.new.EquipHeroDetailTipsViewNewPresentor", package.seeall)

local M = class("EquipHeroDetailTipsViewNewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Equipsystem_new_timing_detail_tips
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, EquipHeroDetailTipsViewNew.New())
	table.insert(views, BlurBgView.New("common_blur_rt"))

	return views
end

return M
