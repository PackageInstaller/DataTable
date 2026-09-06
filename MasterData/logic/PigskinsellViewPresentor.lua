-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firstcharge/view/PigskinsellViewPresentor.lua

module("logic.extensions.firstcharge.view.PigskinsellViewPresentor", package.seeall)

local PigskinsellViewPresentor = class("PigskinsellViewPresentor", ViewPresentor)

function PigskinsellViewPresentor:ctor()
	PigskinsellViewPresentor.super.ctor(self)
end

function PigskinsellViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PigskinsellViewPresentor:dependWhatResources()
	return {
		"ui/views/firstcharge/pigskinsellview.prefab"
	}
end

function PigskinsellViewPresentor:buildViews()
	return {
		PigskinsellView.New()
	}
end

return PigskinsellViewPresentor
