-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcardpreheat2023/view/YearCardPreheat2023ViewPresentor.lua

module("logic.extensions.yearcardpreheat2023.view.YearCardPreheat2023ViewPresentor", package.seeall)

local YearCardPreheat2023ViewPresentor = class("YearCardPreheat2023ViewPresentor", ViewPresentor)

function YearCardPreheat2023ViewPresentor:ctor()
	YearCardPreheat2023ViewPresentor.super.ctor(self)
end

function YearCardPreheat2023ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YearCardPreheat2023ViewPresentor:dependWhatResources()
	return {
		"ui/views/yearcardpreheat2023/yearcardpreheat2023view.prefab"
	}
end

function YearCardPreheat2023ViewPresentor:buildViews()
	return {
		YearCardPreheat2023View.New()
	}
end

return YearCardPreheat2023ViewPresentor
