-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originashlessdragon/view/OriginAshlessDragonMainViewPresentor.lua

module("logic.extensions.originashlessdragon.view.OriginAshlessDragonMainViewPresentor", package.seeall)

local OriginAshlessDragonMainViewPresentor = class("OriginAshlessDragonMainViewPresentor", ViewPresentor)

function OriginAshlessDragonMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginAshlessDragonMainViewPresentor:dependWhatResources()
	return {
		"ui/views/originashlessdragon/originashlessdragonmainview.prefab"
	}
end

function OriginAshlessDragonMainViewPresentor:buildViews()
	return {
		OriginAshlessDragonMainView.New()
	}
end

return OriginAshlessDragonMainViewPresentor
