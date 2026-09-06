-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinefarnas/view/DivineFarnasMainViewPresentor.lua

module("logic.extensions.divinefarnas.view.DivineFarnasMainViewPresentor", package.seeall)

local DivineFarnasMainViewPresentor = class("DivineFarnasMainViewPresentor", ViewPresentor)

function DivineFarnasMainViewPresentor:ctor()
	DivineFarnasMainViewPresentor.super.ctor(self)
end

function DivineFarnasMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineFarnasMainViewPresentor:dependWhatResources()
	return {
		"ui/views/divinefarnas/divinefarnasmainview.prefab"
	}
end

function DivineFarnasMainViewPresentor:buildViews()
	return {
		DivineFarnasMainView.New()
	}
end

return DivineFarnasMainViewPresentor
