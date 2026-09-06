-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/view/ZooBuildingInfoViewPresentor.lua

module("logic.extensions.zoo.view.ZooBuildingInfoViewPresentor", package.seeall)

local ZooBuildingInfoViewPresentor = class("ZooBuildingInfoViewPresentor", ViewPresentor)

function ZooBuildingInfoViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ZooBuildingInfoViewPresentor:dependWhatResources()
	return {
		"ui/views/zoo/zoobuildinginfoview.prefab"
	}
end

function ZooBuildingInfoViewPresentor:buildViews()
	return {
		ZooBuildingInfoView.New()
	}
end

return ZooBuildingInfoViewPresentor
