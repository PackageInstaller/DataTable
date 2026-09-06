-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2025/main/YearCardSignin2025ViewPresentor.lua

module("logic.extensions.yearcard.view.yearcard2025.main.YearCardSignin2025ViewPresentor", package.seeall)

local YearCardSignin2025ViewPresentor = class("YearCardSignin2025ViewPresentor", ViewPresentor)

function YearCardSignin2025ViewPresentor:ctor()
	YearCardSignin2025ViewPresentor.super.ctor(self)
end

function YearCardSignin2025ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YearCardSignin2025ViewPresentor:dependWhatResources()
	return {
		"ui/views/yearcard2025/main/yearcardsignin2025view.prefab"
	}
end

function YearCardSignin2025ViewPresentor:buildViews()
	return {
		YearCardSignin2025View.New()
	}
end

return YearCardSignin2025ViewPresentor
