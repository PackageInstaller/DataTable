-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/liyangking/view/LiYangKingEventViewPresentor.lua

module("logic.extensions.liyangking.view.LiYangKingEventViewPresentor", package.seeall)

local LiYangKingEventViewPresentor = class("LiYangKingEventViewPresentor", ViewPresentor)

function LiYangKingEventViewPresentor:ctor()
	LiYangKingEventViewPresentor.super.ctor(self)
end

function LiYangKingEventViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LiYangKingEventViewPresentor:dependWhatResources()
	return {
		"ui/views/liyangking/liyangkingeventview.prefab"
	}
end

function LiYangKingEventViewPresentor:buildViews()
	return {
		LiYangKingEventView.New()
	}
end

return LiYangKingEventViewPresentor
