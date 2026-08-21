-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/welfare/view/claw_doll/ClawDollOperationViewPresentor.lua

module("logic.extensions.welfare.view.claw_doll.ClawDollOperationViewPresentor", package.seeall)

local M = class("ClawDollOperationViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.ClawDoll_operation_view,
		CommonResPath.Url_Currency_Item
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, ClawDollOperationView.New())
	table.insert(views, MoneyView.New(CommEnum.MoneyShowType.ClawDollCoin))

	return views
end

return M
