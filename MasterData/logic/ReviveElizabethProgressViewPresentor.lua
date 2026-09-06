-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/reviveelizabeth/view/ReviveElizabethProgressViewPresentor.lua

module("logic.extensions.reviveelizabeth.view.ReviveElizabethProgressViewPresentor", package.seeall)

local ReviveElizabethProgressViewPresentor = class("ReviveElizabethProgressViewPresentor", ViewPresentor)

function ReviveElizabethProgressViewPresentor:ctor()
	ReviveElizabethProgressViewPresentor.super.ctor(self)
end

function ReviveElizabethProgressViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ReviveElizabethProgressViewPresentor:dependWhatResources()
	return {
		"ui/views/reviveelizabeth/reviveelizabethprogressview.prefab"
	}
end

function ReviveElizabethProgressViewPresentor:buildViews()
	return {
		ReviveElizabethProgressView.New()
	}
end

return ReviveElizabethProgressViewPresentor
