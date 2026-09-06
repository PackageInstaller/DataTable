-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eternalholydragon/view/EternalholydragongameViewPresentor.lua

module("logic.extensions.eternalholydragon.view.EternalholydragongameViewPresentor", package.seeall)

local EternalholydragongameViewPresentor = class("EternalholydragongameViewPresentor", ViewPresentor)

function EternalholydragongameViewPresentor:ctor()
	EternalholydragongameViewPresentor.super.ctor(self)
end

function EternalholydragongameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function EternalholydragongameViewPresentor:dependWhatResources()
	return {
		"ui/views/eternalholydragon/eternalholydragongameview.prefab"
	}
end

function EternalholydragongameViewPresentor:buildViews()
	return {
		EternalholydragongameView.New()
	}
end

return EternalholydragongameViewPresentor
