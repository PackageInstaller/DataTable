-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origindualdragon/view/OriginDualDragonMainViewPresentor.lua

module("logic.extensions.origindualdragon.view.OriginDualDragonMainViewPresentor", package.seeall)

local OriginDualDragonMainViewPresentor = class("OriginDualDragonMainViewPresentor", ViewPresentor)

function OriginDualDragonMainViewPresentor:ctor()
	OriginDualDragonMainViewPresentor.super.ctor(self)
end

function OriginDualDragonMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginDualDragonMainViewPresentor:dependWhatResources()
	return {
		"ui/views/origindualdragon/origindualdragonmainview.prefab"
	}
end

function OriginDualDragonMainViewPresentor:buildViews()
	return {
		OriginDualDragonMainView.New()
	}
end

return OriginDualDragonMainViewPresentor
