-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinefarnas/view/DivineFarnasExtUsePetViewPresentor.lua

module("logic.extensions.divinefarnas.view.DivineFarnasExtUsePetViewPresentor", package.seeall)

local DivineFarnasExtUsePetViewPresentor = class("DivineFarnasExtUsePetViewPresentor", ViewPresentor)

function DivineFarnasExtUsePetViewPresentor:ctor()
	DivineFarnasExtUsePetViewPresentor.super.ctor(self)
end

function DivineFarnasExtUsePetViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineFarnasExtUsePetViewPresentor:dependWhatResources()
	return {
		"ui/views/divinefarnas/divinefarnasextusepetview.prefab"
	}
end

function DivineFarnasExtUsePetViewPresentor:buildViews()
	return {
		DivineFarnasExtUsePetView.New()
	}
end

return DivineFarnasExtUsePetViewPresentor
