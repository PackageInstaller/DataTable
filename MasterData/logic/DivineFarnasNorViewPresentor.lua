-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinefarnas/view/DivineFarnasNorViewPresentor.lua

module("logic.extensions.divinefarnas.view.DivineFarnasNorViewPresentor", package.seeall)

local DivineFarnasNorViewPresentor = class("DivineFarnasNorViewPresentor", ViewPresentor)

function DivineFarnasNorViewPresentor:ctor()
	DivineFarnasNorViewPresentor.super.ctor(self)
end

function DivineFarnasNorViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineFarnasNorViewPresentor:dependWhatResources()
	return {
		"ui/views/divinefarnas/divinefarnasnorview.prefab"
	}
end

function DivineFarnasNorViewPresentor:buildViews()
	return {
		DivineFarnasNorView.New()
	}
end

return DivineFarnasNorViewPresentor
