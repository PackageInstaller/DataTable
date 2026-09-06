-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/breakformation/view/PozhenSweepViewPresentor.lua

module("logic.extensions.breakformation.view.PozhenSweepViewPresentor", package.seeall)

local PozhenSweepViewPresentor = class("PozhenSweepViewPresentor", ViewPresentor)

function PozhenSweepViewPresentor:ctor()
	PozhenSweepViewPresentor.super.ctor(self)
end

function PozhenSweepViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PozhenSweepViewPresentor:dependWhatResources()
	return {
		"ui/views/breakformation/pozhenclearanceview.prefab"
	}
end

function PozhenSweepViewPresentor:buildViews()
	return {
		PozhenSweepView.New()
	}
end

return PozhenSweepViewPresentor
