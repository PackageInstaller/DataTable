-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/tip/view/CommonExchangeTipsViewPresentor.lua

module("logic.extensions.common.tip.view.CommonExchangeTipsViewPresentor", package.seeall)

local M = class("CommonExchangeTipsViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Dialog_common_use_prop_tips
	}
end

function M:buildViews()
	local views = {}

	self._mainView = CommonExchangeTipsView.New()

	table.insert(views, self._mainView)
	table.insert(views, BlurBgView.New())

	return views
end

return M
