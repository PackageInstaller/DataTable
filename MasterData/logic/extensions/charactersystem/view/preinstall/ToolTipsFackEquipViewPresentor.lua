-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/preinstall/ToolTipsFackEquipViewPresentor.lua

module("logic.extensions.charactersystem.view.preinstall.ToolTipsFackEquipViewPresentor", package.seeall)

local M = class("ToolTipsFackEquipViewPresentor", ToolTipsEquipViewPresentor)

function M:buildViews()
	local views = {}

	table.insert(views, ToolTipsMaskComp.New())
	table.insert(views, ToolTipsFackEquipComp.New())
	table.insert(views, ToolTipsLimitInScreenComp.New())

	return views
end

return M
