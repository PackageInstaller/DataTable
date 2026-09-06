-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recap2021/view/Recap2021lookbackpetViewPresentor.lua

module("logic.extensions.recap2021.view.Recap2021lookbackpetViewPresentor", package.seeall)

local Recap2021lookbackpetViewPresentor = class("Recap2021lookbackpetViewPresentor", ViewPresentor)

function Recap2021lookbackpetViewPresentor:ctor()
	Recap2021lookbackpetViewPresentor.super.ctor(self)
end

function Recap2021lookbackpetViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function Recap2021lookbackpetViewPresentor:dependWhatResources()
	return {
		"ui/views/recap2021/recap2021lookbackpetview.prefab"
	}
end

function Recap2021lookbackpetViewPresentor:buildViews()
	return {
		Recap2021lookbackpetView.New()
	}
end

function Recap2021lookbackpetViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return Recap2021lookbackpetViewPresentor
