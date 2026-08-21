-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/store/view/firstcharge/FirstChargeViewPresentor.lua

module("logic.extensions.store.view.firstcharge.FirstChargeViewPresentor", package.seeall)

local M = class("FirstChargeViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.First_charge
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, FirstChargeView.New())

	return views
end

return M
