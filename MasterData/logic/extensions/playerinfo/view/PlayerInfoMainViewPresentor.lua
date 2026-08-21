-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/PlayerInfoMainViewPresentor.lua

module("logic.extensions.playerinfo.view.PlayerInfoMainViewPresentor", package.seeall)

local M = class("PlayerInfoMainViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Playerinfo_player_info_main_view,
		ResName.Common_Backpack_Item,
		IconLoader.getSpriteAtlasUrl(IconType.Skinlib),
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_CharacterSystem),
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_Task),
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_Room),
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_ResourcesExplore)
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, PlayerInfoMainView.New())

	return views
end

return M
