-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/view/ZoogetanimaleggViewPresentor.lua

module("logic.extensions.zoo.view.ZoogetanimaleggViewPresentor", package.seeall)

local ZoogetanimaleggViewPresentor = class("ZoogetanimaleggViewPresentor", ViewPresentor)

function ZoogetanimaleggViewPresentor:ctor()
	ZoogetanimaleggViewPresentor.super.ctor(self)
end

function ZoogetanimaleggViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ZoogetanimaleggViewPresentor:dependWhatResources()
	return {
		"ui/views/zoo/zoogetanimaleggview.prefab"
	}
end

function ZoogetanimaleggViewPresentor:buildViews()
	return {
		ZoogetanimaleggView.New()
	}
end

return ZoogetanimaleggViewPresentor
