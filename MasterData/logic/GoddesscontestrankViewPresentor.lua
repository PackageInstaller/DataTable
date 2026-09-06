-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscontest/view/GoddesscontestrankViewPresentor.lua

module("logic.extensions.goddesscontest.view.GoddesscontestrankViewPresentor", package.seeall)

local GoddesscontestrankViewPresentor = class("GoddesscontestrankViewPresentor", ViewPresentor)

function GoddesscontestrankViewPresentor:ctor()
	GoddesscontestrankViewPresentor.super.ctor(self)
end

function GoddesscontestrankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoddesscontestrankViewPresentor:dependWhatResources()
	return {
		"ui/views/goddesscontest/goddesscontestrankview.prefab"
	}
end

function GoddesscontestrankViewPresentor:buildViews()
	return {
		GoddessContestRankView.New()
	}
end

return GoddesscontestrankViewPresentor
