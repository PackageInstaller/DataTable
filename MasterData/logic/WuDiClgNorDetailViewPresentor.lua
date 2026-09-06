-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wudiclg/view/WuDiClgNorDetailViewPresentor.lua

module("logic.extensions.wudiclg.view.WuDiClgNorDetailViewPresentor", package.seeall)

local WuDiClgNorDetailViewPresentor = class("WuDiClgNorDetailViewPresentor", ViewPresentor)

function WuDiClgNorDetailViewPresentor:ctor()
	WuDiClgNorDetailViewPresentor.super.ctor(self)
end

function WuDiClgNorDetailViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function WuDiClgNorDetailViewPresentor:dependWhatResources()
	return {
		"ui/views/wudiclg/wudiclgnordetailview.prefab"
	}
end

function WuDiClgNorDetailViewPresentor:buildViews()
	return {
		WuDiClgNorDetailView.New()
	}
end

return WuDiClgNorDetailViewPresentor
