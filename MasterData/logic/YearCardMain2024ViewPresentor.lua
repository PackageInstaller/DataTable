-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2024/main/YearCardMain2024ViewPresentor.lua

module("logic.extensions.yearcard.view.yearcard2024.main.YearCardMain2024ViewPresentor", package.seeall)

local YearCardMain2024ViewPresentor = class("YearCardMain2024ViewPresentor", ViewPresentor)

function YearCardMain2024ViewPresentor:ctor()
	YearCardMain2024ViewPresentor.super.ctor(self)
end

function YearCardMain2024ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YearCardMain2024ViewPresentor:dependWhatResources()
	return {
		"ui/views/yearcard2024/main/yearcardmain2024view.prefab"
	}
end

function YearCardMain2024ViewPresentor:buildViews()
	return {
		YearCardMain2024View.New()
	}
end

return YearCardMain2024ViewPresentor
