-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originashlessdragon/view/OriginAshlessDragonFmtExViewPresentor.lua

module("logic.extensions.originashlessdragon.view.OriginAshlessDragonFmtExViewPresentor", package.seeall)

local OriginAshlessDragonFmtExViewPresentor = class("OriginAshlessDragonFmtExViewPresentor", ViewPresentor)

function OriginAshlessDragonFmtExViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginAshlessDragonFmtExViewPresentor:dependWhatResources()
	return {
		"ui/views/originashlessdragon/originashlessdragonfmtexview.prefab"
	}
end

function OriginAshlessDragonFmtExViewPresentor:buildViews()
	return {
		OriginAshlessDragonFmtExView.New()
	}
end

return OriginAshlessDragonFmtExViewPresentor
