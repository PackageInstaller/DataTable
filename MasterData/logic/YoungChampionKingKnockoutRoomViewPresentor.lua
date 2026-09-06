-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youngchampionking/view/YoungChampionKingKnockoutRoomViewPresentor.lua

module("logic.extensions.youngchampionking.view.YoungChampionKingKnockoutRoomViewPresentor", package.seeall)

local YoungChampionKingKnockoutRoomViewPresentor = class("YoungChampionKingKnockoutRoomViewPresentor", ViewPresentor)

function YoungChampionKingKnockoutRoomViewPresentor:ctor()
	YoungChampionKingKnockoutRoomViewPresentor.super.ctor(self)
end

function YoungChampionKingKnockoutRoomViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YoungChampionKingKnockoutRoomViewPresentor:dependWhatResources()
	return {
		"ui/views/youngchampionking/youngchampionkingknockoutroomview.prefab"
	}
end

function YoungChampionKingKnockoutRoomViewPresentor:buildViews()
	return {
		YoungChampionKingKnockoutRoomView.New()
	}
end

return YoungChampionKingKnockoutRoomViewPresentor
