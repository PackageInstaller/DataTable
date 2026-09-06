-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/reviveelizabeth/view/ReviveElizabethFlowerViewPresentor.lua

module("logic.extensions.reviveelizabeth.view.ReviveElizabethFlowerViewPresentor", package.seeall)

local ReviveElizabethFlowerViewPresentor = class("ReviveElizabethFlowerViewPresentor", ViewPresentor)

function ReviveElizabethFlowerViewPresentor:ctor()
	ReviveElizabethFlowerViewPresentor.super.ctor(self)
end

function ReviveElizabethFlowerViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ReviveElizabethFlowerViewPresentor:dependWhatResources()
	return {
		"ui/views/reviveelizabeth/reviveelizabethflowerview.prefab"
	}
end

function ReviveElizabethFlowerViewPresentor:buildViews()
	return {
		ReviveElizabethFlowerView.New()
	}
end

return ReviveElizabethFlowerViewPresentor
