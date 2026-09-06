-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2023/main/YearCardMain2023ViewPresentor.lua

module("logic.extensions.yearcard.view.yearcard2023.main.YearCardMain2023ViewPresentor", package.seeall)

local YearCardMain2023ViewPresentor = class("YearCardMain2023ViewPresentor", ViewPresentor)

function YearCardMain2023ViewPresentor:ctor()
	YearCardMain2023ViewPresentor.super.ctor(self)
end

function YearCardMain2023ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YearCardMain2023ViewPresentor:dependWhatResources()
	return {
		"ui/views/yearcard2023/main/yearcardmain2023view.prefab"
	}
end

function YearCardMain2023ViewPresentor:buildViews()
	return {
		YearCardMain2023View.New()
	}
end

return YearCardMain2023ViewPresentor
