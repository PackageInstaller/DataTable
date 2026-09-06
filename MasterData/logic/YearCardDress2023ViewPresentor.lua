-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2023/main/YearCardDress2023ViewPresentor.lua

module("logic.extensions.yearcard.view.yearcard2023.main.YearCardDress2023ViewPresentor", package.seeall)

local YearCardDress2023ViewPresentor = class("YearCardDress2023ViewPresentor", ViewPresentor)

function YearCardDress2023ViewPresentor:ctor()
	YearCardDress2023ViewPresentor.super.ctor(self)
end

function YearCardDress2023ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YearCardDress2023ViewPresentor:dependWhatResources()
	return {
		"ui/views/yearcard2023/main/yearcarddress2023view.prefab"
	}
end

function YearCardDress2023ViewPresentor:buildViews()
	return {
		YearCardDress2023View.New()
	}
end

return YearCardDress2023ViewPresentor
