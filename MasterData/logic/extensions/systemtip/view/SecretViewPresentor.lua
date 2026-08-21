-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/systemtip/view/SecretViewPresentor.lua

module("logic.extensions.systemtip.view.SecretViewPresentor", package.seeall)

local M = class("SecretViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Systemtip_secret_tips
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, SecretView.New())

	return views
end

function M:attachToWhichRoot()
	return ViewRootType.TopMost
end

return M
