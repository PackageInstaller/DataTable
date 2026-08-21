-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/info/PlayerSelectCharacterViewPresentor.lua

module("logic.extensions.playerinfo.view.info.PlayerSelectCharacterViewPresentor", package.seeall)

local M = class("PlayerSelectCharacterViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Info_player_info_character_depot_view,
		ResName.Info_player_show_item,
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_CharacterDepot),
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_Dice)
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, PlayerSelectCharacterView.New())

	return views
end

return M
