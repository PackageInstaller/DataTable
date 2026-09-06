-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timecapsule/view/SearchnoteViewPresentor.lua

module("logic.extensions.timecapsule.view.SearchnoteViewPresentor", package.seeall)

local SearchnoteViewPresentor = class("SearchnoteViewPresentor", ViewPresentor)

function SearchnoteViewPresentor:ctor()
	SearchnoteViewPresentor.super.ctor(self)
end

function SearchnoteViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SearchnoteViewPresentor:dependWhatResources()
	return {
		"ui/views/timecapsule/searchnoteview.prefab"
	}
end

function SearchnoteViewPresentor:buildViews()
	return {
		SearchNoteView.New()
	}
end

return SearchnoteViewPresentor
