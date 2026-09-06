-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/view/ZooWorkingViewPresentor.lua

module("logic.extensions.zoo.view.ZooWorkingViewPresentor", package.seeall)

local ZooWorkingViewPresentor = class("ZooWorkingViewPresentor", ViewPresentor)

function ZooWorkingViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ZooWorkingViewPresentor:dependWhatResources()
	return {
		"ui/views/zoo/zooworkingview.prefab"
	}
end

function ZooWorkingViewPresentor:buildViews()
	return {
		ZooWorkingView.New()
	}
end

return ZooWorkingViewPresentor
