-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/view/ZooegginfoViewPresentor.lua

module("logic.extensions.zoo.view.ZooegginfoViewPresentor", package.seeall)

local ZooegginfoViewPresentor = class("ZooegginfoViewPresentor", ViewPresentor)

function ZooegginfoViewPresentor:ctor()
	ZooegginfoViewPresentor.super.ctor(self)
end

function ZooegginfoViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ZooegginfoViewPresentor:dependWhatResources()
	return {
		"ui/views/zoo/zooegginfoview.prefab"
	}
end

function ZooegginfoViewPresentor:buildViews()
	return {
		ZooegginfoView.New()
	}
end

return ZooegginfoViewPresentor
