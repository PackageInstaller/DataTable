-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/celebratebirthday/view/CelebratebirthdayViewPresentor.lua

module("logic.extensions.celebratebirthday.view.CelebratebirthdayViewPresentor", package.seeall)

local CelebratebirthdayViewPresentor = class("CelebratebirthdayViewPresentor", ViewPresentor)

function CelebratebirthdayViewPresentor:ctor()
	CelebratebirthdayViewPresentor.super.ctor(self)
end

function CelebratebirthdayViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CelebratebirthdayViewPresentor:dependWhatResources()
	return {
		"ui/views/celebratebirthday/celebratebirthdayview.prefab"
	}
end

function CelebratebirthdayViewPresentor:buildViews()
	return {
		CelebrateBirthdayView.New()
	}
end

return CelebratebirthdayViewPresentor
