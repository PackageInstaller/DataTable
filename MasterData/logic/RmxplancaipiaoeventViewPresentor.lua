-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/richmanxplan/view/RmxplancaipiaoeventViewPresentor.lua

module("logic.extensions.richmanxplan.view.RmxplancaipiaoeventViewPresentor", package.seeall)

local RmxplancaipiaoeventViewPresentor = class("RmxplancaipiaoeventViewPresentor", ViewPresentor)

function RmxplancaipiaoeventViewPresentor:ctor()
	RmxplancaipiaoeventViewPresentor.super.ctor(self)
end

function RmxplancaipiaoeventViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function RmxplancaipiaoeventViewPresentor:dependWhatResources()
	return {
		"ui/views/richmanxplan/rmxplancaipiaoeventview.prefab"
	}
end

function RmxplancaipiaoeventViewPresentor:buildViews()
	return {
		RmxplancaipiaoeventView.New()
	}
end

return RmxplancaipiaoeventViewPresentor
