-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2026/main/YearCardMain2026ViewPresentor.lua

module("logic.extensions.yearcard.view.yearcard2026.main.YearCardMain2026ViewPresentor", package.seeall)

local YearCardMain2026ViewPresentor = class("YearCardMain2026ViewPresentor", ViewPresentor)

function YearCardMain2026ViewPresentor:ctor()
	YearCardMain2026ViewPresentor.super.ctor(self)
end

function YearCardMain2026ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YearCardMain2026ViewPresentor:dependWhatResources()
	return {
		"ui/views/yearcard2026/main/yearcardmain2026view.prefab"
	}
end

function YearCardMain2026ViewPresentor:buildViews()
	return {
		YearCardMain2026View.New()
	}
end

return YearCardMain2026ViewPresentor
