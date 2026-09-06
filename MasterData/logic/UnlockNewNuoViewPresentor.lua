-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/idlegame/view/UnlockNewNuoViewPresentor.lua

module("logic.extensions.idlegame.view.UnlockNewNuoViewPresentor", package.seeall)

local UnlockNewNuoViewPresentor = class("UnlockNewNuoViewPresentor", ViewWithGuidePresentor)

function UnlockNewNuoViewPresentor:ctor()
	UnlockNewNuoViewPresentor.super.ctor(self)
end

function UnlockNewNuoViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function UnlockNewNuoViewPresentor:dependWhatResources()
	return {
		"ui/views/idlegame/unlocknewnuoview.prefab"
	}
end

function UnlockNewNuoViewPresentor:buildViews()
	return {
		UnlockNewNuoView.New()
	}
end

return UnlockNewNuoViewPresentor
