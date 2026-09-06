-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recap2021/view/Recap2021lookbackbaoganViewPresentor.lua

module("logic.extensions.recap2021.view.Recap2021lookbackbaoganViewPresentor", package.seeall)

local Recap2021lookbackbaoganViewPresentor = class("Recap2021lookbackbaoganViewPresentor", ViewPresentor)

function Recap2021lookbackbaoganViewPresentor:ctor()
	Recap2021lookbackbaoganViewPresentor.super.ctor(self)
end

function Recap2021lookbackbaoganViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function Recap2021lookbackbaoganViewPresentor:dependWhatResources()
	return {
		"ui/views/recap2021/recap2021lookbackbaoganview.prefab"
	}
end

function Recap2021lookbackbaoganViewPresentor:buildViews()
	return {
		Recap2021lookbackbaoganView.New()
	}
end

function Recap2021lookbackbaoganViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return Recap2021lookbackbaoganViewPresentor
