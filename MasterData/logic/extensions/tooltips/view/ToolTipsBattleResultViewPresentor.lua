-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tooltips/view/ToolTipsBattleResultViewPresentor.lua

module("logic.extensions.tooltips.view.ToolTipsBattleResultViewPresentor", package.seeall)

local M = class("ToolTipsBattleResultViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Tips_item_detail_tips,
		ResName.Common_path_get_item,
		IconLoader.getSpriteAtlasUrl(IconType.Skinlib),
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_CharacterSystem)
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, ToolTipsMaskComp.New())
	table.insert(views, ToolTipsItemHeadComp.New())
	table.insert(views, ToolTipsGetWaysComp.New())
	table.insert(views, ToolTipsBattleResultComp.New())
	table.insert(views, ToolTipsLimitInScreenComp.New())

	return views
end

function M:onClickOutside()
	ViewMgr.instance:close(ViewName.ToolTipsBattleResultViewPresentor)
end

return M
