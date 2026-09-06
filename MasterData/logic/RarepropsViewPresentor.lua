-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/xiaonuobirthday/RarepropsViewPresentor.lua

module("logic.extensions.bonus.view.xiaonuobirthday.RarepropsViewPresentor", package.seeall)

local RarepropsViewPresentor = class("RarepropsViewPresentor", ViewPresentor)

function RarepropsViewPresentor:ctor()
	RarepropsViewPresentor.super.ctor(self)
end

function RarepropsViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function RarepropsViewPresentor:dependWhatResources()
	return {
		"ui/views/bonus/xiaonuobirthday/rarepropsview.prefab"
	}
end

function RarepropsViewPresentor:buildViews()
	return {
		RarepropsView.New()
	}
end

return RarepropsViewPresentor
