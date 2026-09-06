-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/activitypopup/view/HdLongHuangViewPresentor.lua

module("logic.extensions.activitypopup.view.HdLongHuangViewPresentor", package.seeall)

local HdLongHuangViewPresentor = class("HdLongHuangViewPresentor", ViewPresentor)

function HdLongHuangViewPresentor:ctor()
	HdLongHuangViewPresentor.super.ctor(self)
end

function HdLongHuangViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HdLongHuangViewPresentor:dependWhatResources()
	return {
		"ui/views/activitypopup/hdlonghuangview.prefab"
	}
end

function HdLongHuangViewPresentor:buildViews()
	return {
		HdLongHuangView.New()
	}
end

return HdLongHuangViewPresentor
