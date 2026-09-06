-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscontest/view/GoddessContestCheckViewPresentor.lua

module("logic.extensions.goddesscontest.view.GoddessContestCheckViewPresentor", package.seeall)

local GoddessContestCheckViewPresentor = class("GoddessContestCheckViewPresentor", ViewPresentor)

function GoddessContestCheckViewPresentor:ctor()
	GoddessContestCheckViewPresentor.super.ctor(self)
end

function GoddessContestCheckViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoddessContestCheckViewPresentor:dependWhatResources()
	return {
		"ui/views/goddesscontest/goddesscontestcheckview.prefab"
	}
end

function GoddessContestCheckViewPresentor:buildViews()
	return {
		GoddessContestCheckView.New()
	}
end

return GoddessContestCheckViewPresentor
