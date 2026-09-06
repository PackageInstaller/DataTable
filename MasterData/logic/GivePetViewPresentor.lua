-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/givepet/view/GivePetViewPresentor.lua

module("logic.extensions.givepet.view.GivePetViewPresentor", package.seeall)

local GivePetViewPresentor = class("GivePetViewPresentor", ViewPresentor)

function GivePetViewPresentor:ctor()
	GivePetViewPresentor.super.ctor(self)
end

function GivePetViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GivePetViewPresentor:dependWhatResources()
	return {
		"ui/views/givepet/givepetview.prefab"
	}
end

function GivePetViewPresentor:buildViews()
	return {
		GivePetView.New()
	}
end

return GivePetViewPresentor
