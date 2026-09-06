-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origindragonnoah/view/OriginDragonNoahMainViewPresentor.lua

module("logic.extensions.origindragonnoah.view.OriginDragonNoahMainViewPresentor", package.seeall)

local OriginDragonNoahMainViewPresentor = class("OriginDragonNoahMainViewPresentor", ViewPresentor)

function OriginDragonNoahMainViewPresentor:ctor()
	OriginDragonNoahMainViewPresentor.super.ctor(self)
end

function OriginDragonNoahMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginDragonNoahMainViewPresentor:dependWhatResources()
	return {
		"ui/views/origindragonnoah/origindragonnoahmainview.prefab"
	}
end

function OriginDragonNoahMainViewPresentor:buildViews()
	return {
		OriginDragonNoahMainView.New()
	}
end

return OriginDragonNoahMainViewPresentor
