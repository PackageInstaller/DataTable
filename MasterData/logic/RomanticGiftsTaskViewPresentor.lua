-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/romanticgifts/view/RomanticGiftsTaskViewPresentor.lua

module("logic.extensions.romanticgifts.view.RomanticGiftsTaskViewPresentor", package.seeall)

local RomanticGiftsTaskViewPresentor = class("RomanticGiftsTaskViewPresentor", ViewPresentor)

function RomanticGiftsTaskViewPresentor:ctor()
	RomanticGiftsTaskViewPresentor.super.ctor(self)
end

function RomanticGiftsTaskViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function RomanticGiftsTaskViewPresentor:dependWhatResources()
	return {
		"ui/views/romanticgifts/romanticgiftstaskview.prefab"
	}
end

function RomanticGiftsTaskViewPresentor:buildViews()
	return {
		RomanticGiftsTaskView.New()
	}
end

return RomanticGiftsTaskViewPresentor
