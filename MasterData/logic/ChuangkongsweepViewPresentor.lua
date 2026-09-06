-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chuangkongunion/view/ChuangkongsweepViewPresentor.lua

module("logic.extensions.chuangkongunion.view.ChuangkongsweepViewPresentor", package.seeall)

local ChuangkongsweepViewPresentor = class("ChuangkongsweepViewPresentor", ViewPresentor)

function ChuangkongsweepViewPresentor:ctor()
	ChuangkongsweepViewPresentor.super.ctor(self)
end

function ChuangkongsweepViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ChuangkongsweepViewPresentor:dependWhatResources()
	return {
		"ui/views/chuangkongunion/chuangkongsweepview.prefab"
	}
end

function ChuangkongsweepViewPresentor:buildViews()
	return {
		ChuangkongsweepView.New()
	}
end

return ChuangkongsweepViewPresentor
