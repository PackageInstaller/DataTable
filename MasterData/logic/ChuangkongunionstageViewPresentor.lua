-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chuangkongunion/view/ChuangkongunionstageViewPresentor.lua

module("logic.extensions.chuangkongunion.view.ChuangkongunionstageViewPresentor", package.seeall)

local ChuangkongunionstageViewPresentor = class("ChuangkongunionstageViewPresentor", ViewPresentor)

function ChuangkongunionstageViewPresentor:ctor()
	ChuangkongunionstageViewPresentor.super.ctor(self)
end

function ChuangkongunionstageViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ChuangkongunionstageViewPresentor:dependWhatResources()
	return {
		"ui/views/chuangkongunion/chuangkongunionstageview.prefab"
	}
end

function ChuangkongunionstageViewPresentor:buildViews()
	return {
		ChuangkongunionstageView.New()
	}
end

return ChuangkongunionstageViewPresentor
