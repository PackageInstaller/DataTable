-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/view/ZooBuildingLevelupViewPresentor.lua

module("logic.extensions.zoo.view.ZooBuildingLevelupViewPresentor", package.seeall)

local ZooBuildingLevelupViewPresentor = class("ZooBuildingLevelupViewPresentor", ViewPresentor)

function ZooBuildingLevelupViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ZooBuildingLevelupViewPresentor:dependWhatResources()
	return {
		"ui/views/zoo/zoobuildinglevelview.prefab"
	}
end

function ZooBuildingLevelupViewPresentor:buildViews()
	return {
		ZooBuildingLevelupView.New()
	}
end

return ZooBuildingLevelupViewPresentor
