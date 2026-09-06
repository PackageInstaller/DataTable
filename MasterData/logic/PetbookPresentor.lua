-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/handbook/view/PetbookPresentor.lua

module("logic.extensions.handbook.view.PetbookPresentor", package.seeall)

local PetbookPresentor = class("PetbookPresentor", ViewPresentor)

PetbookPresentor.bookCanvasPath = "ui/views/handbook/bookcanvas.prefab"

function PetbookPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PetbookPresentor:dependWhatResources()
	return {
		"ui/views/handbook/petbookview.prefab",
		PetbookPresentor.bookCanvasPath
	}
end

function PetbookPresentor:buildViews()
	return {
		PetbookView.New()
	}
end

return PetbookPresentor
