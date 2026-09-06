-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/saintknight/WholecardpublicityViewPresentor.lua

module("logic.extensions.bonus.view.saintknight.WholecardpublicityViewPresentor", package.seeall)

local WholecardpublicityViewPresentor = class("WholecardpublicityViewPresentor", ViewPresentor)

function WholecardpublicityViewPresentor:ctor()
	WholecardpublicityViewPresentor.super.ctor(self)
end

function WholecardpublicityViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function WholecardpublicityViewPresentor:dependWhatResources()
	return {
		"ui/views/bonus/saintknight/wholecardpublicityview.prefab"
	}
end

function WholecardpublicityViewPresentor:buildViews()
	return {
		WholecardpublicityView.New()
	}
end

return WholecardpublicityViewPresentor
