-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/powerland/view/TargetColConViewPresentor.lua

module("logic.extensions.powerland.view.TargetColConViewPresentor", package.seeall)

local TargetColConViewPresentor = class("TargetColConViewPresentor", ViewPresentor)

function TargetColConViewPresentor:ctor()
	TargetColConViewPresentor.super.ctor(self)
end

function TargetColConViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function TargetColConViewPresentor:dependWhatResources()
	return {
		"ui/views/powerland/targetcolconview.prefab"
	}
end

function TargetColConViewPresentor:buildViews()
	return {
		TargetColConView.New()
	}
end

return TargetColConViewPresentor
