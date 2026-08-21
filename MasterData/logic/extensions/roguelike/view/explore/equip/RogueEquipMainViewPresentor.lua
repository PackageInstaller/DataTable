-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/equip/RogueEquipMainViewPresentor.lua

module("logic.extensions.roguelike.view.explore.equip.RogueEquipMainViewPresentor", package.seeall)

local M = class("RogueEquipMainViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Rungroupother_rungroup_equip_main_view,
		CommonResPath.Url_Currency_Item
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, RogueEquipMainView.New())
	table.insert(views, TitleView.New(CommEnum.ManualKey.RogueEquip))

	return views
end

return M
