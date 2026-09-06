-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chuangkongunion/view/ChuangkongunionViewPresentor.lua

module("logic.extensions.chuangkongunion.view.ChuangkongunionViewPresentor", package.seeall)

local ChuangkongunionViewPresentor = class("ChuangkongunionViewPresentor", ViewPresentor)

function ChuangkongunionViewPresentor:ctor()
	ChuangkongunionViewPresentor.super.ctor(self)
end

function ChuangkongunionViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ChuangkongunionViewPresentor:dependWhatResources()
	return {
		"ui/views/chuangkongunion/chuangkongunionview.prefab"
	}
end

function ChuangkongunionViewPresentor:buildViews()
	return {
		ChuangkongunionView.New()
	}
end

return ChuangkongunionViewPresentor
