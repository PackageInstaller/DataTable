-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origindragonnoah/view/OriginDragonNoahLevelViewPresentor.lua

module("logic.extensions.origindragonnoah.view.OriginDragonNoahLevelViewPresentor", package.seeall)

local OriginDragonNoahLevelViewPresentor = class("OriginDragonNoahLevelViewPresentor", ViewPresentor)

function OriginDragonNoahLevelViewPresentor:ctor()
	OriginDragonNoahLevelViewPresentor.super.ctor(self)
end

function OriginDragonNoahLevelViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginDragonNoahLevelViewPresentor:dependWhatResources()
	return {
		"ui/views/origindragonnoah/origindragonnoahlevelview.prefab"
	}
end

function OriginDragonNoahLevelViewPresentor:buildViews()
	return {
		OriginDragonNoahLevelView.New()
	}
end

return OriginDragonNoahLevelViewPresentor
