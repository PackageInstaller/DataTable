-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscollector/view/GoddesscollectorPetInfoViewPresentor.lua

module("logic.extensions.goddesscollector.view.GoddesscollectorPetInfoViewPresentor", package.seeall)

local GoddesscollectorPetInfoViewPresentor = class("GoddesscollectorPetInfoViewPresentor", ViewPresentor)

function GoddesscollectorPetInfoViewPresentor:ctor()
	GoddesscollectorPetInfoViewPresentor.super.ctor(self)
end

function GoddesscollectorPetInfoViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoddesscollectorPetInfoViewPresentor:dependWhatResources()
	return {
		"ui/views/goddesscollector/goddesscollectorpetinfoview.prefab"
	}
end

function GoddesscollectorPetInfoViewPresentor:buildViews()
	return {
		GoddesscollectorPetInfoView.New()
	}
end

function GoddesscollectorPetInfoViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return GoddesscollectorPetInfoViewPresentor
