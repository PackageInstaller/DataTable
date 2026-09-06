-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/doushouqi/view/DoushouqiendgameViewPresentor.lua

module("logic.extensions.doushouqi.view.DoushouqiendgameViewPresentor", package.seeall)

local DoushouqiendgameViewPresentor = class("DoushouqiendgameViewPresentor", ViewPresentor)

function DoushouqiendgameViewPresentor:ctor()
	DoushouqiendgameViewPresentor.super.ctor(self)
end

function DoushouqiendgameViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function DoushouqiendgameViewPresentor:dependWhatResources()
	return {
		"ui/views/doushouqi/doushouqiendgameview.prefab"
	}
end

function DoushouqiendgameViewPresentor:buildViews()
	return {
		DoushouqiendgameView.New()
	}
end

return DoushouqiendgameViewPresentor
