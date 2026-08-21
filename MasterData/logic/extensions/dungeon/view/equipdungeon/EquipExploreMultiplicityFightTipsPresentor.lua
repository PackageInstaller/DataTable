-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/equipdungeon/EquipExploreMultiplicityFightTipsPresentor.lua

module("logic.extensions.dungeon.view.equipdungeon.EquipExploreMultiplicityFightTipsPresentor", package.seeall)

local M = class("EquipExploreMultiplicityFightTipsPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Equip_explore_multiplicity_fight_tips,
		CommonResPath.Url_Currency_Item
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, EquipExploreMultiplicityFightTipsView.New())
	table.insert(views, MoneyView.New(CommEnum.MoneyShowType.OnlyEnergyShowType))
	table.insert(views, BlurBgView.New())

	return views
end

return M
