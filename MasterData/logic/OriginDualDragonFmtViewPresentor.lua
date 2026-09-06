-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origindualdragon/view/OriginDualDragonFmtViewPresentor.lua

module("logic.extensions.origindualdragon.view.OriginDualDragonFmtViewPresentor", package.seeall)

local OriginDualDragonFmtViewPresentor = class("OriginDualDragonFmtViewPresentor", ViewPresentor)

function OriginDualDragonFmtViewPresentor:ctor()
	OriginDualDragonFmtViewPresentor.super.ctor(self)
end

function OriginDualDragonFmtViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginDualDragonFmtViewPresentor:dependWhatResources()
	return {
		"ui/views/origindualdragon/origindualdragonfmtview.prefab"
	}
end

function OriginDualDragonFmtViewPresentor:buildViews()
	return {
		OriginDualDragonFmtView.New()
	}
end

return OriginDualDragonFmtViewPresentor
