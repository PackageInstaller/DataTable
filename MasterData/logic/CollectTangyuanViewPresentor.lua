-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/collecttangyuan/view/CollectTangyuanViewPresentor.lua

module("logic.extensions.collecttangyuan.view.CollectTangyuanViewPresentor", package.seeall)

local CollectTangyuanViewPresentor = class("CollectTangyuanViewPresentor", ViewWithGuidePresentor)

function CollectTangyuanViewPresentor:ctor()
	CollectTangyuanViewPresentor.super.ctor(self)
end

function CollectTangyuanViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CollectTangyuanViewPresentor:dependWhatResources()
	return {
		"ui/views/collecttangyuan/collecttangyuanview.prefab"
	}
end

function CollectTangyuanViewPresentor:buildViews()
	return {
		CollectTangyuanView.New()
	}
end

return CollectTangyuanViewPresentor
