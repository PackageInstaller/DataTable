-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/viewcheck/view/ViewcheckPresentor.lua

module("logic.extensions.viewcheck.view.ViewcheckPresentor", package.seeall)

local ViewcheckPresentor = class("ViewcheckPresentor", ViewPresentor)

function ViewcheckPresentor:ctor()
	ViewcheckPresentor.super.ctor(self)
end

function ViewcheckPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ViewcheckPresentor:dependWhatResources()
	return {
		"ui/views/viewcheck/viewcheckview.prefab"
	}
end

function ViewcheckPresentor:buildViews()
	return {
		ViewCheckView.New()
	}
end

return ViewcheckPresentor
