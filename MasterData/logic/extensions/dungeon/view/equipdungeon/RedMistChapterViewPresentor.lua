-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/equipdungeon/RedMistChapterViewPresentor.lua

module("logic.extensions.dungeon.view.equipdungeon.RedMistChapterViewPresentor", package.seeall)

local M = class("RedMistChapterViewPresentor", ViewPresentor)
local GuideId = 1005

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Red_mist_chapter_view,
		CommonResPath.Url_Currency_Item,
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_ResourcesExplore)
	}
end

function M:buildViews()
	local views = {}

	self._chapterView = RedMistChapterView.New()
	self._bossComp = RedMistBossComp.New()
	self._detailComp = RedMistDungeonDetailComp.New()

	table.insert(views, self._chapterView)
	table.insert(views, self._bossComp)
	table.insert(views, self._detailComp)
	table.insert(views, MoneyView.New(CommEnum.MoneyShowType.OnlyEnergyShowType))
	table.insert(views, TitleView.New(GuideId))

	return views
end

function M:getChapterView()
	return self._chapterView
end

function M:getBossComp()
	return self._bossComp
end

function M:getDetailComp()
	return self._detailComp
end

return M
