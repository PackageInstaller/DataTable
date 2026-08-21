-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/player/view/playercreate/PlayerCreateMainViewPresentor.lua

module("logic.extensions.player.view.playercreate.PlayerCreateMainViewPresentor", package.seeall)

local M = class("PlayerCreateMainViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Player_create_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, PlayerCreatePlotView.New())

	return views
end

return M
