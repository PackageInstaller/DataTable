-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/login/view/PreroleViewPresentor.lua

module("logic.extensions.login.view.PreroleViewPresentor", package.seeall)

local PreroleViewPresentor = class("PreroleViewPresentor", ViewPresentor)

function PreroleViewPresentor:ctor()
	PreroleViewPresentor.super.ctor(self)
end

function PreroleViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PreroleViewPresentor:dependWhatResources()
	return {
		"ui/views/login/preroleview.prefab"
	}
end

function PreroleViewPresentor:buildViews()
	return {
		PreroleView.New()
	}
end

return PreroleViewPresentor
