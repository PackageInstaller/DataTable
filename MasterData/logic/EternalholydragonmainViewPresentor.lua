-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eternalholydragon/view/EternalholydragonmainViewPresentor.lua

module("logic.extensions.eternalholydragon.view.EternalholydragonmainViewPresentor", package.seeall)

local EternalholydragonmainViewPresentor = class("EternalholydragonmainViewPresentor", ViewPresentor)

function EternalholydragonmainViewPresentor:ctor()
	EternalholydragonmainViewPresentor.super.ctor(self)
end

function EternalholydragonmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function EternalholydragonmainViewPresentor:dependWhatResources()
	return {
		"ui/views/eternalholydragon/eternalholydragonmainview.prefab"
	}
end

function EternalholydragonmainViewPresentor:buildViews()
	return {
		EternalholydragonmainView.New()
	}
end

return EternalholydragonmainViewPresentor
