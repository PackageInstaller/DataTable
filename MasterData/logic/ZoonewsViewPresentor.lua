-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/view/ZoonewsViewPresentor.lua

module("logic.extensions.zoo.view.ZoonewsViewPresentor", package.seeall)

local ZoonewsViewPresentor = class("ZoonewsViewPresentor", ViewPresentor)

function ZoonewsViewPresentor:ctor()
	ZoonewsViewPresentor.super.ctor(self)
end

function ZoonewsViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ZoonewsViewPresentor:dependWhatResources()
	return {
		"ui/views/zoo/zoonewsview.prefab"
	}
end

function ZoonewsViewPresentor:buildViews()
	return {
		ZoonewsView.New()
	}
end

return ZoonewsViewPresentor
