-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/family/view/FamilymgremailViewPresentor.lua

module("logic.extensions.family.view.FamilymgremailViewPresentor", package.seeall)

local FamilymgremailViewPresentor = class("FamilymgremailViewPresentor", ViewPresentor)

function FamilymgremailViewPresentor:ctor()
	FamilymgremailViewPresentor.super.ctor(self)
end

function FamilymgremailViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FamilymgremailViewPresentor:dependWhatResources()
	return {
		"ui/views/family/familymgremailview.prefab"
	}
end

function FamilymgremailViewPresentor:buildViews()
	return {
		FamilymgremailView.New()
	}
end

function FamilymgremailViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return FamilymgremailViewPresentor
