-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/healthexchange/view/HealthGetActionTimeTipsViewPresentor.lua

module("logic.extensions.healthexchange.view.HealthGetActionTimeTipsViewPresentor", package.seeall)

local M = class("HealthGetActionTimeTipsViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Backpack_Health_Get_Action_Time_View
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, HealthGetActionTimeTipsView.New())

	return views
end

return M
