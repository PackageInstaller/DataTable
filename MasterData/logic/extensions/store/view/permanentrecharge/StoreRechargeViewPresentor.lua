-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/store/view/permanentrecharge/StoreRechargeViewPresentor.lua

module("logic.extensions.store.view.permanentrecharge.StoreRechargeViewPresentor", package.seeall)

local M = class("StoreRechargeViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Store_permanent_recharge_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, StoreRechargeView.New())

	return views
end

return M
