-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/richmanxplan/view/RmxplanzhanbueventViewPresentor.lua

module("logic.extensions.richmanxplan.view.RmxplanzhanbueventViewPresentor", package.seeall)

local RmxplanzhanbueventViewPresentor = class("RmxplanzhanbueventViewPresentor", ViewPresentor)

function RmxplanzhanbueventViewPresentor:ctor()
	RmxplanzhanbueventViewPresentor.super.ctor(self)
end

function RmxplanzhanbueventViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function RmxplanzhanbueventViewPresentor:dependWhatResources()
	return {
		"ui/views/richmanxplan/rmxplanzhanbueventview.prefab"
	}
end

function RmxplanzhanbueventViewPresentor:buildViews()
	return {
		RmxplanzhanbueventView.New()
	}
end

return RmxplanzhanbueventViewPresentor
