-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/materialchallenge/view/ResCopyViewPresentor.lua

module("logic.extensions.materialchallenge.view.ResCopyViewPresentor", package.seeall)

local ResCopyViewPresentor = class("ResCopyViewPresentor", ViewWithGuidePresentor)

function ResCopyViewPresentor:ctor()
	ResCopyViewPresentor.super.ctor(self)
end

function ResCopyViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ResCopyViewPresentor:dependWhatResources()
	return {
		"ui/views/materialchallenge/rescopyview.prefab"
	}
end

function ResCopyViewPresentor:buildViews()
	return {
		ResCopyView.New()
	}
end

return ResCopyViewPresentor
