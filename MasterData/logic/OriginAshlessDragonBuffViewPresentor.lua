-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originashlessdragon/view/OriginAshlessDragonBuffViewPresentor.lua

module("logic.extensions.originashlessdragon.view.OriginAshlessDragonBuffViewPresentor", package.seeall)

local OriginAshlessDragonBuffViewPresentor = class("OriginAshlessDragonBuffViewPresentor", ViewPresentor)

function OriginAshlessDragonBuffViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginAshlessDragonBuffViewPresentor:dependWhatResources()
	return {
		"ui/views/originashlessdragon/originashlessdragonbuffview.prefab"
	}
end

function OriginAshlessDragonBuffViewPresentor:buildViews()
	return {
		OriginAshlessDragonBuffView.New()
	}
end

return OriginAshlessDragonBuffViewPresentor
