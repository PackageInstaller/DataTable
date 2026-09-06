-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/view/ZoogetanimalbeforeViewPresentor.lua

module("logic.extensions.zoo.view.ZoogetanimalbeforeViewPresentor", package.seeall)

local ZoogetanimalbeforeViewPresentor = class("ZoogetanimalbeforeViewPresentor", ViewWithGuidePresentor)

function ZoogetanimalbeforeViewPresentor:ctor()
	ZoogetanimalbeforeViewPresentor.super.ctor(self)
end

function ZoogetanimalbeforeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ZoogetanimalbeforeViewPresentor:dependWhatResources()
	return {
		"ui/views/zoo/zoogetanimalbeforeview.prefab"
	}
end

function ZoogetanimalbeforeViewPresentor:buildViews()
	return {
		ZoogetanimalbeforeView.New()
	}
end

return ZoogetanimalbeforeViewPresentor
