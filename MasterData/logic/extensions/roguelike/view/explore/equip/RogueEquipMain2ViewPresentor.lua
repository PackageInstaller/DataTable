-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/equip/RogueEquipMain2ViewPresentor.lua

module("logic.extensions.roguelike.view.explore.equip.RogueEquipMain2ViewPresentor", package.seeall)

local M = class("RogueEquipMain2ViewPresentor", RogueEquipMainViewPresentor)

function M:buildViews()
	local views = {}

	table.insert(views, RogueEquipMainView2.New())
	table.insert(views, MoneyView.New(CommEnum.MoneyShowType.RoguelikeEquipShowType))
	table.insert(views, TitleView.New(CommEnum.ManualKey.RogueEquipTips))

	return views
end

return M
