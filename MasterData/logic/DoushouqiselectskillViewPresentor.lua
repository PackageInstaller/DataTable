-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/doushouqi/view/DoushouqiselectskillViewPresentor.lua

module("logic.extensions.doushouqi.view.DoushouqiselectskillViewPresentor", package.seeall)

local DoushouqiselectskillViewPresentor = class("DoushouqiselectskillViewPresentor", ViewPresentor)

function DoushouqiselectskillViewPresentor:ctor()
	DoushouqiselectskillViewPresentor.super.ctor(self)
end

function DoushouqiselectskillViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function DoushouqiselectskillViewPresentor:dependWhatResources()
	return {
		"ui/views/doushouqi/doushouqiselectskillview.prefab"
	}
end

function DoushouqiselectskillViewPresentor:buildViews()
	return {
		DoushouqiselectskillView.New()
	}
end

return DoushouqiselectskillViewPresentor
