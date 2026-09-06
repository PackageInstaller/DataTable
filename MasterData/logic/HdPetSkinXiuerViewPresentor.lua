-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/activitypopup/view/HdPetSkinXiuerViewPresentor.lua

module("logic.extensions.activitypopup.view.HdPetSkinXiuerViewPresentor", package.seeall)

local HdPetSkinXiuerViewPresentor = class("HdPetSkinXiuerViewPresentor", ViewPresentor)

function HdPetSkinXiuerViewPresentor:ctor()
	HdPetSkinXiuerViewPresentor.super.ctor(self)
end

function HdPetSkinXiuerViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HdPetSkinXiuerViewPresentor:dependWhatResources()
	return {
		"ui/views/activitypopup/hdpetskinxiuerview.prefab"
	}
end

function HdPetSkinXiuerViewPresentor:buildViews()
	return {
		HdPetSkinXiuerView.New()
	}
end

return HdPetSkinXiuerViewPresentor
