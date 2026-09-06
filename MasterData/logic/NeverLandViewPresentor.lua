-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/neverland/view/NeverLandViewPresentor.lua

module("logic.extensions.neverland.view.NeverLandViewPresentor", package.seeall)

local NeverLandViewPresentor = class("NeverLandViewPresentor", ViewPresentor)

function NeverLandViewPresentor:ctor()
	NeverLandViewPresentor.super.ctor(self)
end

function NeverLandViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NeverLandViewPresentor:dependWhatResources()
	return {
		"ui/views/neverland/neverlandview.prefab"
	}
end

function NeverLandViewPresentor:buildViews()
	return {
		NeverLandView.New()
	}
end

return NeverLandViewPresentor
