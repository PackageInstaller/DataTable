-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/romanticgifts/view/RomanticGiftsRankViewPresentor.lua

module("logic.extensions.romanticgifts.view.RomanticGiftsRankViewPresentor", package.seeall)

local RomanticGiftsRankViewPresentor = class("RomanticGiftsRankViewPresentor", ViewPresentor)

function RomanticGiftsRankViewPresentor:ctor()
	RomanticGiftsRankViewPresentor.super.ctor(self)
end

function RomanticGiftsRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function RomanticGiftsRankViewPresentor:dependWhatResources()
	return {
		"ui/views/romanticgifts/romanticgiftsrankview.prefab"
	}
end

function RomanticGiftsRankViewPresentor:buildViews()
	return {
		RomanticGiftsRankView.New()
	}
end

return RomanticGiftsRankViewPresentor
