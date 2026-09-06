-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origingoddragonclg/view/OriginGodDragonClgZoneViewPresentor.lua

module("logic.extensions.origingoddragonclg.view.OriginGodDragonClgZoneViewPresentor", package.seeall)

local OriginGodDragonClgZoneViewPresentor = class("OriginGodDragonClgZoneViewPresentor", ViewPresentor)

function OriginGodDragonClgZoneViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginGodDragonClgZoneViewPresentor:dependWhatResources()
	return {
		"ui/views/origingoddragonclg/origingoddragonclgzoneview.prefab"
	}
end

function OriginGodDragonClgZoneViewPresentor:buildViews()
	return {
		OriginGodDragonClgZoneView.New()
	}
end

return OriginGodDragonClgZoneViewPresentor
