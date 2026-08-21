-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/mainline/MainlineChapterSelectViewPresentor.lua

module("logic.extensions.dungeon.view.mainline.MainlineChapterSelectViewPresentor", package.seeall)

local M = class("MainlineChapterSelectViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Instance_instance_chapter_view,
		CommonResPath.Url_Currency_Item,
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_Dungeon)
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, MainlineChapterSelectView.New())
	table.insert(views, MoneyView.New(CommEnum.MoneyShowType.DungeonShowType))

	return views
end

return M
