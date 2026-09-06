-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/view/ZoorecycleViewPresentor.lua

module("logic.extensions.zoo.view.ZoorecycleViewPresentor", package.seeall)

local ZoorecycleViewPresentor = class("ZoorecycleViewPresentor", ViewPresentor)

function ZoorecycleViewPresentor:ctor()
	ZoorecycleViewPresentor.super.ctor(self)
end

function ZoorecycleViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ZoorecycleViewPresentor:dependWhatResources()
	return {
		"ui/views/zoo/zoorecycleview.prefab"
	}
end

function ZoorecycleViewPresentor:buildViews()
	return {
		ZoorecycleView.New()
	}
end

return ZoorecycleViewPresentor
