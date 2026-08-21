-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/welfare/view/claw_doll/ClawDollExchangeViewPresentor.lua

module("logic.extensions.welfare.view.claw_doll.ClawDollExchangeViewPresentor", package.seeall)

local M = class("ClawDollExchangeViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.ClawDoll_exchangereward_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, ClawDollExchangeView.New())
	table.insert(views, BlurBgView.New("common_blur_rt"))

	return views
end

return M
