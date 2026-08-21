-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/info/PlayerInfoShowViewViewPresentor.lua

module("logic.extensions.playerinfo.view.info.PlayerInfoShowViewViewPresentor", package.seeall)

local M = class("PlayerInfoShowViewViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Info_player_info_show_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, TitleView.New())
	table.insert(views, PlayerInfoShowView.New())

	return views
end

return M
