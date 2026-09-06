-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2024/main/YearCardSignin2024ViewPresentor.lua

module("logic.extensions.yearcard.view.yearcard2024.main.YearCardSignin2024ViewPresentor", package.seeall)

local YearCardSignin2024ViewPresentor = class("YearCardSignin2024ViewPresentor", ViewPresentor)

function YearCardSignin2024ViewPresentor:ctor()
	YearCardSignin2024ViewPresentor.super.ctor(self)
end

function YearCardSignin2024ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YearCardSignin2024ViewPresentor:dependWhatResources()
	return {
		"ui/views/yearcard2024/main/yearcardsignin2024view.prefab"
	}
end

function YearCardSignin2024ViewPresentor:buildViews()
	return {
		YearCardSignin2024View.New()
	}
end

return YearCardSignin2024ViewPresentor
