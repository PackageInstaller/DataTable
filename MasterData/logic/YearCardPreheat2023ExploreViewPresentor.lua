-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcardpreheat2023/view/YearCardPreheat2023ExploreViewPresentor.lua

module("logic.extensions.yearcardpreheat2023.view.YearCardPreheat2023ExploreViewPresentor", package.seeall)

local YearCardPreheat2023ExploreViewPresentor = class("YearCardPreheat2023ExploreViewPresentor", ViewPresentor)

function YearCardPreheat2023ExploreViewPresentor:ctor()
	YearCardPreheat2023ExploreViewPresentor.super.ctor(self)
end

function YearCardPreheat2023ExploreViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YearCardPreheat2023ExploreViewPresentor:dependWhatResources()
	return {
		"ui/views/yearcardpreheat2023/yearcardpreheat2023exploreview.prefab"
	}
end

function YearCardPreheat2023ExploreViewPresentor:buildViews()
	return {
		YearCardPreheat2023ExploreView.New()
	}
end

return YearCardPreheat2023ExploreViewPresentor
