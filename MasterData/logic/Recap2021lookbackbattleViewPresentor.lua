-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recap2021/view/Recap2021lookbackbattleViewPresentor.lua

module("logic.extensions.recap2021.view.Recap2021lookbackbattleViewPresentor", package.seeall)

local Recap2021lookbackbattleViewPresentor = class("Recap2021lookbackbattleViewPresentor", ViewPresentor)

function Recap2021lookbackbattleViewPresentor:ctor()
	Recap2021lookbackbattleViewPresentor.super.ctor(self)
end

function Recap2021lookbackbattleViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function Recap2021lookbackbattleViewPresentor:dependWhatResources()
	return {
		"ui/views/recap2021/recap2021lookbackbattleview.prefab"
	}
end

function Recap2021lookbackbattleViewPresentor:buildViews()
	return {
		Recap2021lookbackbattleView.New()
	}
end

function Recap2021lookbackbattleViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return Recap2021lookbackbattleViewPresentor
