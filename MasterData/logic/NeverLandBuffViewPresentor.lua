-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/neverland/view/NeverLandBuffViewPresentor.lua

module("logic.extensions.neverland.view.NeverLandBuffViewPresentor", package.seeall)

local NeverLandBuffViewPresentor = class("NeverLandBuffViewPresentor", ViewPresentor)

function NeverLandBuffViewPresentor:ctor()
	NeverLandBuffViewPresentor.super.ctor(self)
end

function NeverLandBuffViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NeverLandBuffViewPresentor:dependWhatResources()
	return {
		"ui/views/neverland/neverlandbuffview.prefab"
	}
end

function NeverLandBuffViewPresentor:buildViews()
	return {
		NeverLandBuffView.New()
	}
end

return NeverLandBuffViewPresentor
