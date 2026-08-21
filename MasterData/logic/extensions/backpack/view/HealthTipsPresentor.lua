-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/view/HealthTipsPresentor.lua

module("logic.extensions.backpack.view.HealthTipsPresentor", package.seeall)

local M = class("HealthTipsPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Backpack_health_tips,
		CommonResPath.Url_Currency_Item
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, HealthTipsView.New())
	table.insert(views, MoneyView.New(CommEnum.MoneyShowType.OnlyEnergyWithOutAddBtn))
	table.insert(views, BlurBgView.New())

	return views
end

return M
