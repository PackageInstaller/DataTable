-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wudiclg/view/WuDiClgExtDetailViewPresentor.lua

module("logic.extensions.wudiclg.view.WuDiClgExtDetailViewPresentor", package.seeall)

local WuDiClgExtDetailViewPresentor = class("WuDiClgExtDetailViewPresentor", ViewPresentor)

function WuDiClgExtDetailViewPresentor:ctor()
	WuDiClgExtDetailViewPresentor.super.ctor(self)
end

function WuDiClgExtDetailViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function WuDiClgExtDetailViewPresentor:dependWhatResources()
	return {
		"ui/views/wudiclg/wudiclgextdetailview.prefab"
	}
end

function WuDiClgExtDetailViewPresentor:buildViews()
	return {
		WuDiClgExtDetailView.New()
	}
end

return WuDiClgExtDetailViewPresentor
