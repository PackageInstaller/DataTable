-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscollector/view/GoddesscollectorSkinInfoViewPresentor.lua

module("logic.extensions.goddesscollector.view.GoddesscollectorShinInfoViewPresentor", package.seeall)

local GoddesscollectorShinInfoViewPresentor = class("GoddesscollectorShinInfoViewPresentor", ViewPresentor)

function GoddesscollectorShinInfoViewPresentor:ctor()
	GoddesscollectorShinInfoViewPresentor.super.ctor(self)
end

function GoddesscollectorShinInfoViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoddesscollectorShinInfoViewPresentor:dependWhatResources()
	return {
		"ui/views/goddesscollector/goddesscollectorskininfoview.prefab"
	}
end

function GoddesscollectorShinInfoViewPresentor:buildViews()
	return {
		GoddesscollectorSkinInfoView.New()
	}
end

function GoddesscollectorShinInfoViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return GoddesscollectorShinInfoViewPresentor
