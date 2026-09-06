-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscollector/view/GoddesscollectorpetdetailViewPresentor.lua

module("logic.extensions.goddesscollector.view.GoddesscollectorpetdetailViewPresentor", package.seeall)

local GoddesscollectorpetdetailViewPresentor = class("GoddesscollectorpetdetailViewPresentor", ViewPresentor)

function GoddesscollectorpetdetailViewPresentor:ctor()
	GoddesscollectorpetdetailViewPresentor.super.ctor(self)
end

function GoddesscollectorpetdetailViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoddesscollectorpetdetailViewPresentor:dependWhatResources()
	return {
		"ui/views/goddesscollector/goddesscollectorpetdetailview.prefab"
	}
end

function GoddesscollectorpetdetailViewPresentor:buildViews()
	return {
		GoddesscollectorpetdetailView.New()
	}
end

return GoddesscollectorpetdetailViewPresentor
