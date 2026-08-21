-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/info/RenameTipsViewPresentor.lua

module("logic.extensions.playerinfo.view.info.RenameTipsViewPresentor", package.seeall)

local M = class("RenameTipsViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Playerinfo_rename_tips
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, RenameTipsView.New())
	table.insert(views, BlurBgView.New())

	return views
end

return M
