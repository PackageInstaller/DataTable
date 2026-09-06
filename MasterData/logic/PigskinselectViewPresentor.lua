-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pigraise/view/PigskinselectViewPresentor.lua

module("logic.extensions.pigraise.view.PigskinselectViewPresentor", package.seeall)

local PigskinselectViewPresentor = class("PigskinselectViewPresentor", ViewPresentor)

function PigskinselectViewPresentor:ctor()
	PigskinselectViewPresentor.super.ctor(self)
end

function PigskinselectViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PigskinselectViewPresentor:dependWhatResources()
	return {
		"ui/views/pigraise/pigskinselectview.prefab"
	}
end

function PigskinselectViewPresentor:buildViews()
	return {
		PigskinselectView.New()
	}
end

return PigskinselectViewPresentor
