-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/growup/view/HeartGrowUpLetterViewPresentor.lua

module("logic.extensions.growup.view.HeartGrowUpLetterViewPresentor", package.seeall)

local HeartGrowUpLetterViewPresentor = class("HeartGrowUpLetterViewPresentor", ViewPresentor)

function HeartGrowUpLetterViewPresentor:ctor()
	HeartGrowUpLetterViewPresentor.super.ctor(self)
end

function HeartGrowUpLetterViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function HeartGrowUpLetterViewPresentor:dependWhatResources()
	return {
		"ui/views/growup/heartgrowupletterview.prefab"
	}
end

function HeartGrowUpLetterViewPresentor:buildViews()
	return {
		HeartGrowUpLetterView.New()
	}
end

return HeartGrowUpLetterViewPresentor
