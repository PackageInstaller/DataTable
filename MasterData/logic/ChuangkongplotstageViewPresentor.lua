-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chuangkongunion/view/ChuangkongplotstageViewPresentor.lua

module("logic.extensions.scenariocopy.view.father.ChuangkongplotstageViewPresentor", package.seeall)

local ChuangkongplotstageViewPresentor = class("ChuangkongplotstageViewPresentor", ViewPresentor)

function ChuangkongplotstageViewPresentor:ctor()
	ChuangkongplotstageViewPresentor.super.ctor(self)
end

function ChuangkongplotstageViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ChuangkongplotstageViewPresentor:dependWhatResources()
	return {
		"ui/views/chuangkongunion/chuangkongplotstageview.prefab"
	}
end

function ChuangkongplotstageViewPresentor:buildViews()
	return {
		ChuangkongplotstageView.New()
	}
end

return ChuangkongplotstageViewPresentor
