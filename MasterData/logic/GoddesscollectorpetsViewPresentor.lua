-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscollector/view/GoddesscollectorpetsViewPresentor.lua

module("logic.extensions.goddesscollector.view.GoddesscollectorpetsViewPresentor", package.seeall)

local GoddesscollectorpetsViewPresentor = class("GoddesscollectorpetsViewPresentor", ViewPresentor)

GoddesscollectorpetsViewPresentor.bookCanvasPath = "ui/views/goddesscollector/goddesscollectbookcanvas.prefab"

function GoddesscollectorpetsViewPresentor:ctor()
	GoddesscollectorpetsViewPresentor.super.ctor(self)
end

function GoddesscollectorpetsViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoddesscollectorpetsViewPresentor:dependWhatResources()
	return {
		"ui/views/goddesscollector/goddesscollectorpetsview.prefab",
		GoddesscollectorpetsViewPresentor.bookCanvasPath
	}
end

function GoddesscollectorpetsViewPresentor:buildViews()
	return {
		GoddesscollectorpetsView.New()
	}
end

return GoddesscollectorpetsViewPresentor
