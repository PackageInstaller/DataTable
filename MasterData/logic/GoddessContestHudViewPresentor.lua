-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscontest/view/GoddessContestHudViewPresentor.lua

module("logic.extensions.goddesscontest.view.GoddessContestHudViewPresentor", package.seeall)

local GoddessContestHudViewPresentor = class("GoddessContestHudViewPresentor", ViewPresentor)

function GoddessContestHudViewPresentor:ctor()
	GoddessContestHudViewPresentor.super.ctor(self)
end

function GoddessContestHudViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoddessContestHudViewPresentor:dependWhatResources()
	return {
		"ui/views/goddesscontest/goddesscontesthudview.prefab"
	}
end

function GoddessContestHudViewPresentor:buildViews()
	return {
		GoddessContestHudView.New()
	}
end

return GoddessContestHudViewPresentor
