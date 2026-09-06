-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscollector/view/GoddessCollectorNewPetsViewPresentor.lua

module("logic.extensions.goddesscollector.view.GoddessCollectorNewPetsViewPresentor", package.seeall)

local GoddessCollectorNewPetsViewPresentor = class("GoddessCollectorNewPetsViewPresentor", ViewPresentor)

GoddessCollectorNewPetsViewPresentor.bookCanvasPath = "ui/views/goddesscollector/goddesscollectpetsandskinsbookcanvas.prefab"

function GoddessCollectorNewPetsViewPresentor:ctor()
	GoddessCollectorNewPetsViewPresentor.super.ctor(self)
end

function GoddessCollectorNewPetsViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoddessCollectorNewPetsViewPresentor:dependWhatResources()
	return {
		"ui/views/goddesscollector/goddesscollectornewpetsview.prefab",
		GoddessCollectorNewPetsViewPresentor.bookCanvasPath
	}
end

function GoddessCollectorNewPetsViewPresentor:buildViews()
	return {
		GoddessCollectorNewPetsView.New()
	}
end

return GoddessCollectorNewPetsViewPresentor
