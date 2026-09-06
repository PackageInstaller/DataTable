-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinecoronate/view/DivineCoronateMainViewPresentor.lua

module("logic.extensions.divinecoronate.view.DivineCoronateMainViewPresentor", package.seeall)

local DivineCoronateMainViewPresentor = class("DivineCoronateMainViewPresentor", ViewPresentor)

function DivineCoronateMainViewPresentor:ctor()
	DivineCoronateMainViewPresentor.super.ctor(self)
end

function DivineCoronateMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineCoronateMainViewPresentor:dependWhatResources()
	return {
		"ui/views/divinecoronate/divinecoronatemainview.prefab"
	}
end

function DivineCoronateMainViewPresentor:buildViews()
	return {
		DivineCoronateMainView.New()
	}
end

return DivineCoronateMainViewPresentor
