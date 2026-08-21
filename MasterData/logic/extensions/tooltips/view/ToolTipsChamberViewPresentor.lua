-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tooltips/view/ToolTipsChamberViewPresentor.lua

module("logic.extensions.tooltips.view.ToolTipsChamberViewPresentor", package.seeall)

local M = class("ToolTipsChamberViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Tips_impression_detail_tips,
		IconLoader.getSpriteAtlasUrl(IconType.Skinlib)
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, ToolTipsMaskComp.New())
	table.insert(views, ToolTipsChamberComp.New())
	table.insert(views, ToolTipsLimitInScreenComp.New())

	return views
end

return M
