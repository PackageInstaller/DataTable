-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/view/SpineInterfaceBubbleGamePresentor.lua

module("logic.extensions.bag.view.SpineInterfaceBubbleGamePresentor", package.seeall)

local SpineInterfaceBubbleGamePresentor = class("SpineInterfaceBubbleGamePresentor", ViewPresentor)

function SpineInterfaceBubbleGamePresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SpineInterfaceBubbleGamePresentor:dependWhatResources()
	return {
		"ui/views/bag/spineinterfacebubblegame.prefab"
	}
end

function SpineInterfaceBubbleGamePresentor:buildViews()
	return {
		SpineInterfaceBubbleGame.New()
	}
end

function SpineInterfaceBubbleGamePresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return SpineInterfaceBubbleGamePresentor
