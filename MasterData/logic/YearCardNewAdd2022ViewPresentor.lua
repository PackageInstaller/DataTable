-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/YearCard2022/YearCardNewAdd2022ViewPresentor.lua

module("logic.extensions.yearcard.view.2022.YearCardNewAdd2022ViewPresentor", package.seeall)

local YearCardNewAdd2022ViewPresentor = class("YearCardNewAdd2022ViewPresentor", ViewPresentor)

function YearCardNewAdd2022ViewPresentor:ctor()
	YearCardNewAdd2022ViewPresentor.super.ctor(self)
end

function YearCardNewAdd2022ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YearCardNewAdd2022ViewPresentor:dependWhatResources()
	return {
		"ui/views/yearcard2022/yearcardnewadd2022view.prefab"
	}
end

function YearCardNewAdd2022ViewPresentor:buildViews()
	return {
		YearCardNewAdd2022View.New()
	}
end

return YearCardNewAdd2022ViewPresentor
