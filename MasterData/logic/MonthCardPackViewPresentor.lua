-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/monthcardspack/view/MonthCardPackViewPresentor.lua

module("logic.extensions.monthcardspack.view.MonthCardPackViewPresentor", package.seeall)

local MonthCardPackViewPresentor = class("MonthCardPackViewPresentor", ViewPresentor)

function MonthCardPackViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MonthCardPackViewPresentor:dependWhatResources()
	return {
		"ui/views/monthcardspack/monthcardspack.prefab"
	}
end

function MonthCardPackViewPresentor:buildViews()
	return {
		MonthCardPackView.New()
	}
end

return MonthCardPackViewPresentor
