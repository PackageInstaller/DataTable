-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/collecttangyuan/view/CollectTangyuanTaskViewPresentor.lua

module("logic.extensions.collecttangyuan.view.CollectTangyuanTaskViewPresentor", package.seeall)

local CollectTangyuanTaskViewPresentor = class("CollectTangyuanTaskViewPresentor", ViewPresentor)

function CollectTangyuanTaskViewPresentor:ctor()
	CollectTangyuanTaskViewPresentor.super.ctor(self)
end

function CollectTangyuanTaskViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function CollectTangyuanTaskViewPresentor:dependWhatResources()
	return {
		"ui/views/collecttangyuan/collecttangyuantaskview.prefab"
	}
end

function CollectTangyuanTaskViewPresentor:buildViews()
	return {
		CollectTangyuanTaskView.New()
	}
end

return CollectTangyuanTaskViewPresentor
