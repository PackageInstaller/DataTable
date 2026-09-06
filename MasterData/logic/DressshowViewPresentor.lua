-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dress/view/DressshowViewPresentor.lua

module("logic.extensions.dress.view.DressshowViewPresentor", package.seeall)

local DressshowViewPresentor = class("DressshowViewPresentor", ViewPresentor)

function DressshowViewPresentor:ctor()
	DressshowViewPresentor.super.ctor(self)
end

function DressshowViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DressshowViewPresentor:dependWhatResources()
	return {
		"ui/views/dress/dressshowview.prefab"
	}
end

function DressshowViewPresentor:buildViews()
	return {
		DressshowView.New()
	}
end

return DressshowViewPresentor
