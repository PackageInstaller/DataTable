-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originan/view/OriginAnMainViewPresentor.lua

module("logic.extensions.originan.view.OriginAnMainViewPresentor", package.seeall)

local OriginAnMainViewPresentor = class("OriginAnMainViewPresentor", ViewPresentor)

function OriginAnMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginAnMainViewPresentor:dependWhatResources()
	return {
		"ui/views/originan/originanmainview.prefab"
	}
end

function OriginAnMainViewPresentor:buildViews()
	return {
		OriginAnMainView.New()
	}
end

return OriginAnMainViewPresentor
