-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/darkdragonknife/view/DarkdragonknifegameViewPresentor.lua

module("logic.extensions.darkdragonknife.view.DarkdragonknifegameViewPresentor", package.seeall)

local DarkdragonknifegameViewPresentor = class("DarkdragonknifegameViewPresentor", ViewPresentor)

function DarkdragonknifegameViewPresentor:ctor()
	DarkdragonknifegameViewPresentor.super.ctor(self)
end

function DarkdragonknifegameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DarkdragonknifegameViewPresentor:dependWhatResources()
	return {
		"ui/views/darkdragonknife/darkdragonknifegameview.prefab"
	}
end

function DarkdragonknifegameViewPresentor:buildViews()
	return {
		DarkDragonKnifeGameView.New()
	}
end

return DarkdragonknifegameViewPresentor
