-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/richmanxplan/view/RmxplanshangpueventViewPresentor.lua

module("logic.extensions.richmanxplan.view.RmxplanshangpueventViewPresentor", package.seeall)

local RmxplanshangpueventViewPresentor = class("RmxplanshangpueventViewPresentor", ViewPresentor)

function RmxplanshangpueventViewPresentor:ctor()
	RmxplanshangpueventViewPresentor.super.ctor(self)
end

function RmxplanshangpueventViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function RmxplanshangpueventViewPresentor:dependWhatResources()
	return {
		"ui/views/richmanxplan/rmxplanshangpueventview.prefab"
	}
end

function RmxplanshangpueventViewPresentor:buildViews()
	return {
		RmxplanshangpueventView.New()
	}
end

return RmxplanshangpueventViewPresentor
