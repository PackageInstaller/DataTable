-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/activitypopup/view/HdLongYanViewPresentor.lua

module("logic.extensions.activitypopup.view.HdLongYanViewPresentor", package.seeall)

local HdLongYanViewPresentor = class("HdLongYanViewPresentor", ViewPresentor)

function HdLongYanViewPresentor:ctor()
	HdLongYanViewPresentor.super.ctor(self)
end

function HdLongYanViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HdLongYanViewPresentor:dependWhatResources()
	return {
		"ui/views/activitypopup/hdlongyanview.prefab"
	}
end

function HdLongYanViewPresentor:buildViews()
	return {
		HdLongYanView.New()
	}
end

return HdLongYanViewPresentor
