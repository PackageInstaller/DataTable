-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscontest/view/GoddessContestMainViewPresentor.lua

module("logic.extensions.goddesscontest.view.GoddessContestMainViewPresentor", package.seeall)

local GoddessContestMainViewPresentor = class("GoddessContestMainViewPresentor", ViewPresentor)

function GoddessContestMainViewPresentor:ctor()
	GoddessContestMainViewPresentor.super.ctor(self)
end

function GoddessContestMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoddessContestMainViewPresentor:dependWhatResources()
	return {
		"ui/views/goddesscontest/goddesscontestmainview.prefab"
	}
end

function GoddessContestMainViewPresentor:buildViews()
	return {
		GoddessContestMainView.New()
	}
end

return GoddessContestMainViewPresentor
