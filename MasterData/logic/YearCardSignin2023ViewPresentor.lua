-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2023/main/YearCardSignin2023ViewPresentor.lua

module("logic.extensions.yearcard.view.yearcard2023.main.YearCardSignin2023ViewPresentor", package.seeall)

local YearCardSignin2023ViewPresentor = class("YearCardSignin2023ViewPresentor", ViewPresentor)

function YearCardSignin2023ViewPresentor:ctor()
	YearCardSignin2023ViewPresentor.super.ctor(self)
end

function YearCardSignin2023ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YearCardSignin2023ViewPresentor:dependWhatResources()
	return {
		"ui/views/yearcard2023/main/yearcardsignin2023view.prefab"
	}
end

function YearCardSignin2023ViewPresentor:buildViews()
	return {
		YearCardSignin2023View.New()
	}
end

return YearCardSignin2023ViewPresentor
