-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/teenchampionking/view/TCKKnockoutRoomViewPresentor.lua

module("logic.extensions.teenchampionking.view.TCKKnockoutRoomViewPresentor", package.seeall)

local TCKKnockoutRoomViewPresentor = class("TCKKnockoutRoomViewPresentor", ViewPresentor)

function TCKKnockoutRoomViewPresentor:ctor()
	TCKKnockoutRoomViewPresentor.super.ctor(self)
end

function TCKKnockoutRoomViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TCKKnockoutRoomViewPresentor:dependWhatResources()
	return {
		"ui/views/teenchampionking/tckknockoutroomview.prefab"
	}
end

function TCKKnockoutRoomViewPresentor:buildViews()
	return {
		TCKKnockoutRoomView.New()
	}
end

function TCKKnockoutRoomViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return TCKKnockoutRoomViewPresentor
