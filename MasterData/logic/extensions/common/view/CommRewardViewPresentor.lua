-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/view/CommRewardViewPresentor.lua

module("logic.extensions.common.view.CommRewardViewPresentor", package.seeall)

local M = class("CommRewardViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Branchline_settle_details_view,
		ResName.Common_Backpack_Item
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, BlurBgView.New())
	table.insert(views, CommRewardView.New())

	return views
end

return M
