-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recap2021/view/Recap2021gamelookbacksubViewPresentor.lua

module("logic.extensions.recap2021.view.Recap2021gamelookbacksubViewPresentor", package.seeall)

local Recap2021gamelookbacksubViewPresentor = class("Recap2021gamelookbacksubViewPresentor", ViewPresentor)

function Recap2021gamelookbacksubViewPresentor:ctor()
	Recap2021gamelookbacksubViewPresentor.super.ctor(self)
end

function Recap2021gamelookbacksubViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function Recap2021gamelookbacksubViewPresentor:dependWhatResources()
	return {
		"ui/views/recap2021/recap2021gamelookbacksubview.prefab"
	}
end

function Recap2021gamelookbacksubViewPresentor:buildViews()
	return {
		Recap2021gamelookbacksubView.New()
	}
end

return Recap2021gamelookbacksubViewPresentor
