-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/activitypopup/view/DreamspeedgiftViewPresentor.lua

module("logic.extensions.activitypopup.view.DreamspeedgiftViewPresentor", package.seeall)

local DreamspeedgiftViewPresentor = class("DreamspeedgiftViewPresentor", ViewPresentor)

function DreamspeedgiftViewPresentor:ctor()
	DreamspeedgiftViewPresentor.super.ctor(self)
end

function DreamspeedgiftViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DreamspeedgiftViewPresentor:dependWhatResources()
	return {
		"ui/views/activitypopup/dreamspeedgiftview.prefab"
	}
end

function DreamspeedgiftViewPresentor:buildViews()
	return {
		DreamspeedgiftView.New()
	}
end

return DreamspeedgiftViewPresentor
