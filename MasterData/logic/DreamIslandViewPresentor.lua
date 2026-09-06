-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/accumulategift/view/DreamIslandViewPresentor.lua

module("logic.extensions.accumulategift.view.DreamIslandViewPresentor", package.seeall)

local DreamIslandViewPresentor = class("DreamIslandViewPresentor", ViewWithGuidePresentor)

function DreamIslandViewPresentor:ctor()
	DreamIslandViewPresentor.super.ctor(self)
end

function DreamIslandViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DreamIslandViewPresentor:dependWhatResources()
	return {
		"ui/views/accumulategift/dreamislandview.prefab"
	}
end

function DreamIslandViewPresentor:buildViews()
	return {
		DreamIslandView.New()
	}
end

return DreamIslandViewPresentor
