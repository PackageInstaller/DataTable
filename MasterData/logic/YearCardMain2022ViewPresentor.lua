-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/YearCard2022/YearCardMain2022ViewPresentor.lua

module("logic.extensions.yearcard.view.2022.YearCardMain2022ViewPresentor", package.seeall)

local YearCardMain2022ViewPresentor = class("YearCardMain2022ViewPresentor", ViewPresentor)

function YearCardMain2022ViewPresentor:ctor()
	YearCardMain2022ViewPresentor.super.ctor(self)
end

function YearCardMain2022ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YearCardMain2022ViewPresentor:dependWhatResources()
	return {
		"ui/views/yearcard2022/yearcardmain2022view.prefab"
	}
end

function YearCardMain2022ViewPresentor:buildViews()
	return {
		YearCardMain2022View.New()
	}
end

return YearCardMain2022ViewPresentor
