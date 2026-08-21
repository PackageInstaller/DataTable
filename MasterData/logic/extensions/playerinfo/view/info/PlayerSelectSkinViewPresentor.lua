-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/info/PlayerSelectSkinViewPresentor.lua

module("logic.extensions.playerinfo.view.info.PlayerSelectSkinViewPresentor", package.seeall)

local M = class("PlayerSelectSkinViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Info_player_select_skin,
		ResName.Info_player_skin_item,
		CommonResPath.Url_Currency_Item
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, PlayerSelectSkinView.New())
	table.insert(views, TitleView.New())

	return views
end

return M
