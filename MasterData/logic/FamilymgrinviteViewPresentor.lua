-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/family/view/FamilymgrinviteViewPresentor.lua

module("logic.extensions.family.view.FamilymgrinviteViewPresentor", package.seeall)

local FamilymgrinviteViewPresentor = class("FamilymgrinviteViewPresentor", ViewPresentor)

function FamilymgrinviteViewPresentor:ctor()
	FamilymgrinviteViewPresentor.super.ctor(self)
end

function FamilymgrinviteViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FamilymgrinviteViewPresentor:dependWhatResources()
	return {
		"ui/views/family/familymgrinviteview.prefab"
	}
end

function FamilymgrinviteViewPresentor:buildViews()
	return {
		FamilymgrinviteView.New()
	}
end

function FamilymgrinviteViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return FamilymgrinviteViewPresentor
