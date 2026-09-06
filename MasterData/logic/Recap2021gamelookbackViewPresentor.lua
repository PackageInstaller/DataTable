-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recap2021/view/Recap2021gamelookbackViewPresentor.lua

module("logic.extensions.recap2021.view.Recap2021gamelookbackViewPresentor", package.seeall)

local Recap2021gamelookbackViewPresentor = class("Recap2021gamelookbackViewPresentor", ViewPresentor)

function Recap2021gamelookbackViewPresentor:ctor()
	Recap2021gamelookbackViewPresentor.super.ctor(self)
end

function Recap2021gamelookbackViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function Recap2021gamelookbackViewPresentor:dependWhatResources()
	return {
		"ui/views/recap2021/recap2021gamelookbackview.prefab"
	}
end

function Recap2021gamelookbackViewPresentor:buildViews()
	return {
		Recap2021gamelookbackView.New()
	}
end

return Recap2021gamelookbackViewPresentor
