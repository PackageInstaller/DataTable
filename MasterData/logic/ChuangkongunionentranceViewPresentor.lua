-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chuangkongunion/view/ChuangkongunionentranceViewPresentor.lua

module("logic.extensions.chuangkongunion.view.ChuangkongunionentranceViewPresentor", package.seeall)

local ChuangkongunionentranceViewPresentor = class("ChuangkongunionentranceViewPresentor", ViewPresentor)

function ChuangkongunionentranceViewPresentor:ctor()
	ChuangkongunionentranceViewPresentor.super.ctor(self)
end

function ChuangkongunionentranceViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ChuangkongunionentranceViewPresentor:dependWhatResources()
	return {
		"ui/views/chuangkongunion/chuangkongunionentranceview.prefab"
	}
end

function ChuangkongunionentranceViewPresentor:buildViews()
	return {
		ChuangkongunionentranceView.New()
	}
end

return ChuangkongunionentranceViewPresentor
