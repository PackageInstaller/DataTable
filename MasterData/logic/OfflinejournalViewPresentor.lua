-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/offline/view/OfflinejournalViewPresentor.lua

module("logic.extensions.offline.view.OfflinejournalViewPresentor", package.seeall)

local OfflinejournalViewPresentor = class("OfflinejournalViewPresentor", ViewPresentor)

function OfflinejournalViewPresentor:ctor()
	OfflinejournalViewPresentor.super.ctor(self)
end

function OfflinejournalViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OfflinejournalViewPresentor:dependWhatResources()
	return {
		"ui/views/offline/offlinejournalview.prefab"
	}
end

function OfflinejournalViewPresentor:buildViews()
	return {
		OfflinejournalView.New()
	}
end

return OfflinejournalViewPresentor
