-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/miya/MiyaPlayChessViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.miya.MiyaPlayChessViewPresentor", package.seeall)

local MiyaPlayChessViewPresentor = class("MiyaPlayChessViewPresentor", ViewPresentor)

function MiyaPlayChessViewPresentor:ctor()
	MiyaPlayChessViewPresentor.super.ctor(self)
end

function MiyaPlayChessViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MiyaPlayChessViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/miyaplaychessview.prefab"
	}
end

function MiyaPlayChessViewPresentor:buildViews()
	return {
		MiyaPlayChessView.New()
	}
end

return MiyaPlayChessViewPresentor
