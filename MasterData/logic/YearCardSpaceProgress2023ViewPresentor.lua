-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2023/main/YearCardSpaceProgress2023ViewPresentor.lua

module("logic.extensions.yearcard.view.yearcard2023.main.YearCardSpaceProgress2023ViewPresentor", package.seeall)

local YearCardSpaceProgress2023ViewPresentor = class("YearCardSpaceProgress2023ViewPresentor", ViewPresentor)

function YearCardSpaceProgress2023ViewPresentor:ctor()
	YearCardSpaceProgress2023ViewPresentor.super.ctor(self)
end

function YearCardSpaceProgress2023ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YearCardSpaceProgress2023ViewPresentor:dependWhatResources()
	return {
		"ui/views/yearcard2023/main/yearcardspaceprogress2023view.prefab"
	}
end

function YearCardSpaceProgress2023ViewPresentor:buildViews()
	return {
		YearCardSpaceProgress2023View.New()
	}
end

return YearCardSpaceProgress2023ViewPresentor
