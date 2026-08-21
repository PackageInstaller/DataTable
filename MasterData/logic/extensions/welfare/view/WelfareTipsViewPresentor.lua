-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/welfare/view/WelfareTipsViewPresentor.lua

module("logic.extensions.welfare.view.WelfareTipsViewPresentor", package.seeall)

local M = class("WelfareTipsViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Wekfare_wekfare_detail_tips
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, WelfareTipsView.New())
	table.insert(views, BlurBgView.New("common_blur_rt"))

	return views
end

return M
