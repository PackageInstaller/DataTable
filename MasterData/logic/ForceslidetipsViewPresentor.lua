-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/forceslide/ForceslidetipsViewPresentor.lua

module("logic.extensions.operationsummary.view.forceslide.ForceslidetipsViewPresentor", package.seeall)

local ForceslidetipsViewPresentor = class("ForceslidetipsViewPresentor", ViewPresentor)

function ForceslidetipsViewPresentor:ctor()
	ForceslidetipsViewPresentor.super.ctor(self)
end

function ForceslidetipsViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ForceslidetipsViewPresentor:dependWhatResources()
	return {
		"ui/views/operationsummary/forceslidetipsview.prefab"
	}
end

function ForceslidetipsViewPresentor:buildViews()
	return {
		ForceSlideTipsView.New()
	}
end

return ForceslidetipsViewPresentor
