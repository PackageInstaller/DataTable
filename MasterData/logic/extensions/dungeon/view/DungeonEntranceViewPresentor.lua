-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/DungeonEntranceViewPresentor.lua

module("logic.extensions.dungeon.view.DungeonEntranceViewPresentor", package.seeall)

local M = class("DungeonEntranceViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Fight_fight_entry_view,
		CommonResPath.Url_Currency_Item,
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_Dungeon)
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, DungeonEntranceView.New())
	table.insert(views, MoneyView.New(CommEnum.MoneyShowType.OnlyEnergyShowType))
	table.insert(views, TitleView.New())

	return views
end

return M
