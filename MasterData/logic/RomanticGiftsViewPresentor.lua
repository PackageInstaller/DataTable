-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/romanticgifts/view/RomanticGiftsViewPresentor.lua

module("logic.extensions.romanticgifts.view.RomanticGiftsViewPresentor", package.seeall)

local RomanticGiftsViewPresentor = class("RomanticGiftsViewPresentor", ViewPresentor)

function RomanticGiftsViewPresentor:ctor()
	RomanticGiftsViewPresentor.super.ctor(self)
end

function RomanticGiftsViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function RomanticGiftsViewPresentor:dependWhatResources()
	return {
		"ui/views/romanticgifts/romanticgiftsview.prefab"
	}
end

function RomanticGiftsViewPresentor:buildViews()
	return {
		RomanticGiftsView.New()
	}
end

return RomanticGiftsViewPresentor
