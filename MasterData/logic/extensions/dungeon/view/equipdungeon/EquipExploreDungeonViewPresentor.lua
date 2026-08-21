-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/equipdungeon/EquipExploreDungeonViewPresentor.lua

module("logic.extensions.dungeon.view.equipdungeon.EquipExploreDungeonViewPresentor", package.seeall)

local M = class("EquipExploreDungeonViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Equip_explore_equip_explore_seed_view,
		ResName.Common_enemy_head,
		CommonResPath.Url_Currency_Item,
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_Material),
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_EquipExplore)
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, EquipExploreDungeonView.New())
	table.insert(views, EquipExploreSeedView.New())
	table.insert(views, MoneyView.New(CommEnum.MoneyShowType.OnlyEnergyShowType))
	table.insert(views, TitleView.New():blockOrgBtn(true, false, false))

	return views
end

return M
