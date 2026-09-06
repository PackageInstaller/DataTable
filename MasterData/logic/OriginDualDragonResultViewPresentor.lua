-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origindualdragon/view/OriginDualDragonResultViewPresentor.lua

module("logic.extensions.origindualdragon.view.OriginDualDragonResultViewPresentor", package.seeall)

local OriginDualDragonResultViewPresentor = class("OriginDualDragonResultViewPresentor", ViewPresentor)

function OriginDualDragonResultViewPresentor:ctor()
	OriginDualDragonResultViewPresentor.super.ctor(self)
end

function OriginDualDragonResultViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function OriginDualDragonResultViewPresentor:dependWhatResources()
	return {
		"ui/views/origindualdragon/origindualdragonresultview.prefab"
	}
end

function OriginDualDragonResultViewPresentor:buildViews()
	return {
		OriginDualDragonResultView.New()
	}
end

return OriginDualDragonResultViewPresentor
