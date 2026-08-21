-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tooltips/view/ToolTipsEquipViewPresentor.lua

module("logic.extensions.tooltips.view.ToolTipsEquipViewPresentor", package.seeall)

local M = class("ToolTipsEquipViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Tips_equip_detail_tips,
		IconLoader.getSpriteAtlasUrl(IconType.Skinlib),
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_CharacterSystem)
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, ToolTipsMaskComp.New())
	table.insert(views, ToolTipsEquipComp.New())
	table.insert(views, ToolTipsLimitInScreenComp.New())

	return views
end

return M
