-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/darkdragonknife/view/DarkdragonknifemainViewPresentor.lua

module("logic.extensions.darkdragonknife.view.DarkdragonknifemainViewPresentor", package.seeall)

local DarkdragonknifemainViewPresentor = class("DarkdragonknifemainViewPresentor", ViewPresentor)

function DarkdragonknifemainViewPresentor:ctor()
	DarkdragonknifemainViewPresentor.super.ctor(self)
end

function DarkdragonknifemainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DarkdragonknifemainViewPresentor:dependWhatResources()
	return {
		"ui/views/darkdragonknife/darkdragonknifemainview.prefab"
	}
end

function DarkdragonknifemainViewPresentor:buildViews()
	return {
		DarkDragonKnifeMainView.New()
	}
end

return DarkdragonknifemainViewPresentor
