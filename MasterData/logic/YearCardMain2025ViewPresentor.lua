-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2025/main/YearCardMain2025ViewPresentor.lua

module("logic.extensions.yearcard.view.yearcard2025.main.YearCardMain2025ViewPresentor", package.seeall)

local YearCardMain2025ViewPresentor = class("YearCardMain2025ViewPresentor", ViewPresentor)

function YearCardMain2025ViewPresentor:ctor()
	YearCardMain2025ViewPresentor.super.ctor(self)
end

function YearCardMain2025ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YearCardMain2025ViewPresentor:dependWhatResources()
	return {
		"ui/views/yearcard2025/main/yearcardmain2025view.prefab"
	}
end

function YearCardMain2025ViewPresentor:buildViews()
	return {
		YearCardMain2025View.New()
	}
end

return YearCardMain2025ViewPresentor
