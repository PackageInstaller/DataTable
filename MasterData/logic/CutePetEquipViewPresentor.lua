-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/CutePetEquipViewPresentor.lua

module("logic.extensions.cutepet.view.CutePetEquipViewPresentor", package.seeall)

local CutePetEquipViewPresentor = class("CutePetEquipViewPresentor", ViewPresentor)

function CutePetEquipViewPresentor:ctor()
	CutePetEquipViewPresentor.super.ctor(self)
end

function CutePetEquipViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CutePetEquipViewPresentor:dependWhatResources()
	return {
		"ui/views/cutepet/cutepetequipview.prefab"
	}
end

function CutePetEquipViewPresentor:buildViews()
	return {
		CutePetEquipView.New()
	}
end

function CutePetEquipViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return CutePetEquipViewPresentor
