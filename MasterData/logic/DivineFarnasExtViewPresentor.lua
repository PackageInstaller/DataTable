-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinefarnas/view/DivineFarnasExtViewPresentor.lua

module("logic.extensions.divinefarnas.view.DivineFarnasExtViewPresentor", package.seeall)

local DivineFarnasExtViewPresentor = class("DivineFarnasExtViewPresentor", ViewPresentor)

function DivineFarnasExtViewPresentor:ctor()
	DivineFarnasExtViewPresentor.super.ctor(self)
end

function DivineFarnasExtViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineFarnasExtViewPresentor:dependWhatResources()
	return {
		"ui/views/divinefarnas/divinefarnasextview.prefab"
	}
end

function DivineFarnasExtViewPresentor:buildViews()
	return {
		DivineFarnasExtView.New()
	}
end

return DivineFarnasExtViewPresentor
