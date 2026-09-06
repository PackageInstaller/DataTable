-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chuangkongunion/view/ChuangkonguniontrialViewPresentor.lua

module("logic.extensions.chuangkongunion.view.ChuangkonguniontrialViewPresentor", package.seeall)

local ChuangkonguniontrialViewPresentor = class("ChuangkonguniontrialViewPresentor", ViewPresentor)

function ChuangkonguniontrialViewPresentor:ctor()
	ChuangkonguniontrialViewPresentor.super.ctor(self)
end

function ChuangkonguniontrialViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ChuangkonguniontrialViewPresentor:dependWhatResources()
	return {
		"ui/views/chuangkongunion/chuangkonguniontrialview.prefab"
	}
end

function ChuangkonguniontrialViewPresentor:buildViews()
	return {
		ChuangkonguniontrialView.New()
	}
end

return ChuangkonguniontrialViewPresentor
