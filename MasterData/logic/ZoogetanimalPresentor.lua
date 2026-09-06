-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/view/ZoogetanimalPresentor.lua

module("logic.extensions.zoo.view.ZoogetanimalPresentor", package.seeall)

local ZoogetanimalPresentor = class("ZoogetanimalPresentor", ViewPresentor)

function ZoogetanimalPresentor:ctor()
	ZoogetanimalPresentor.super.ctor(self)
end

function ZoogetanimalPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ZoogetanimalPresentor:dependWhatResources()
	return {
		"ui/views/zoo/zoogetanimalview.prefab"
	}
end

function ZoogetanimalPresentor:buildViews()
	return {
		ZoogetanimalView.New()
	}
end

return ZoogetanimalPresentor
