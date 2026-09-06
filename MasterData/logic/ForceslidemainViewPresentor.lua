-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/forceslide/ForceslidemainViewPresentor.lua

module("logic.extensions.operationsummary.view.forceslide.ForceslidemainViewPresentor", package.seeall)

local ForceslidemainViewPresentor = class("ForceslidemainViewPresentor", ViewPresentor)

function ForceslidemainViewPresentor:ctor()
	ForceslidemainViewPresentor.super.ctor(self)
end

function ForceslidemainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ForceslidemainViewPresentor:dependWhatResources()
	return {
		"ui/views/operationsummary/forceslidemainview.prefab"
	}
end

function ForceslidemainViewPresentor:buildViews()
	return {
		ForceSlideMainView.New()
	}
end

return ForceslidemainViewPresentor
