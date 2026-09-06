-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chuangkongunion/view/ChuangkonguniontaskViewPresentor.lua

module("logic.extensions.chuangkongunion.view.ChuangkonguniontaskViewPresentor", package.seeall)

local ChuangkonguniontaskViewPresentor = class("ChuangkonguniontaskViewPresentor", ViewPresentor)

function ChuangkonguniontaskViewPresentor:ctor()
	ChuangkonguniontaskViewPresentor.super.ctor(self)
end

function ChuangkonguniontaskViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ChuangkonguniontaskViewPresentor:dependWhatResources()
	return {
		"ui/views/chuangkongunion/chuangkonguniontaskview.prefab"
	}
end

function ChuangkonguniontaskViewPresentor:buildViews()
	return {
		ChuangkonguniontaskView.New()
	}
end

return ChuangkonguniontaskViewPresentor
