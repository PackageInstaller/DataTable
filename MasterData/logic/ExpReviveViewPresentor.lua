-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/expedition/view/ExpReviveViewPresentor.lua

module("logic.extensions.expedition.view.ExpReviveViewPresentor", package.seeall)

local ExpReviveViewPresentor = class("ExpReviveViewPresentor", ViewPresentor)

function ExpReviveViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ExpReviveViewPresentor:dependWhatResources()
	return {
		"ui/views/expedition/expreviveview.prefab"
	}
end

function ExpReviveViewPresentor:buildViews()
	return {
		ExpReviveView.New()
	}
end

return ExpReviveViewPresentor
