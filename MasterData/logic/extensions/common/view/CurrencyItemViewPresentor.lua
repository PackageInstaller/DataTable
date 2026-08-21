-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/view/CurrencyItemViewPresentor.lua

module("logic.extensions.common.view.CurrencyItemViewPresentor", package.seeall)

local M = class("CurrencyItemViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		CommonResPath.Url_Currency_Item
	}
end

function M:buildViews()
	local views = {}

	return views
end

return M
