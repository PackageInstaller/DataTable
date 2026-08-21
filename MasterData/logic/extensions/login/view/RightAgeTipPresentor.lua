-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/login/view/RightAgeTipPresentor.lua

module("logic.extensions.login.view.RightAgeTipPresentor", package.seeall)

local M = class("RightAgeTipPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Login_right_age_hint_tips
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, RightAgeTip.New())

	return views
end

function M:attachToWhichRoot()
	return ViewRootType.TopMost
end

return M
