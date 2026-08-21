-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/tip/view/CommonUsePropSingleTipsViewPresentor.lua

module("logic.extensions.common.tip.view.CommonUsePropSingleTipsViewPresentor", package.seeall)

local M = class("CommonUsePropSingleTipsViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Common_common_use_prop_single_tips,
		CommonResPath.Url_Currency_Item
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, CommonUsePropSingleTipsView.New())
	table.insert(views, BlurBgView.New())
	table.insert(views, MoneyView.New(CommEnum.MoneyShowType.DefaultHideType))

	return views
end

return M
