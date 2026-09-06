-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chuangkongunion/view/ChuangkongcopyViewPresentor.lua

module("logic.extensions.scenariocopy.view.dreamteammutualhelp.ChuangkongcopyViewPresentor", package.seeall)

local ChuangkongcopyViewPresentor = class("ChuangkongcopyViewPresentor", ViewPresentor)

function ChuangkongcopyViewPresentor:ctor()
	ChuangkongcopyViewPresentor.super.ctor(self)
end

function ChuangkongcopyViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ChuangkongcopyViewPresentor:dependWhatResources()
	return {
		"ui/views/chuangkongunion/chuangkongcopyview.prefab"
	}
end

function ChuangkongcopyViewPresentor:buildViews()
	return {
		ChuangkongcopyView.New()
	}
end

return ChuangkongcopyViewPresentor
