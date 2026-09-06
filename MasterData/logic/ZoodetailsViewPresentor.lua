-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/view/ZoodetailsViewPresentor.lua

module("logic.extensions.zoo.view.ZoodetailsViewPresentor", package.seeall)

local ZoodetailsViewPresentor = class("ZoodetailsViewPresentor", ViewPresentor)

function ZoodetailsViewPresentor:ctor()
	ZoodetailsViewPresentor.super.ctor(self)
end

function ZoodetailsViewPresentor:attachToWhichRoot()
	return ViewRootType.Notify
end

function ZoodetailsViewPresentor:dependWhatResources()
	return {
		"ui/views/zoo/zoodetailsview.prefab"
	}
end

function ZoodetailsViewPresentor:buildViews()
	return {
		ZoodetailsView.New()
	}
end

return ZoodetailsViewPresentor
