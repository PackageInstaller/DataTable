-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/view/StoryViewViewPresentor.lua

module("logic.extensions.story.view.StoryViewViewPresentor", package.seeall)

local M = class("StoryViewViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Story_story_main_view,
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_Plot)
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, StoryUIElementsView.New())
	table.insert(views, StoryAfflatuseEffectView.New())
	table.insert(views, StoryViewComponent.New())
	table.insert(views, StoryOperateViewComponent.New())
	table.insert(views, StoryPrintViewComponent.New())
	table.insert(views, StoryRadioViewComponent.New())
	table.insert(views, StoryAutoPlayViewComponent.New())
	table.insert(views, StoryHistoryViewComponent.New())
	table.insert(views, StoryPlayVideoViewComponent.New())
	table.insert(views, StoryFullEfxRTViewComponent.New())
	table.insert(views, StoryExtraView.New())
	table.insert(views, StoryIntroView.New())
	table.insert(views, StoryFullTextView.New())
	table.insert(views, StorySubCgViewComponent.New())
	table.insert(views, StoryRogueView.New())

	return views
end

function M:attachToWhichRoot()
	return ViewRootType.Notify
end

function M:onClickOutside()
	return
end

return M
