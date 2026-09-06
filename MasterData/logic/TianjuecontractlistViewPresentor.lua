-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/contract/view/TianjuecontractlistViewPresentor.lua

module("logic.extensions.contract.view.TianjuecontractlistViewPresentor", package.seeall)

local TianjuecontractlistViewPresentor = class("TianjuecontractlistViewPresentor", ViewPresentor)

function TianjuecontractlistViewPresentor:ctor()
	TianjuecontractlistViewPresentor.super.ctor(self)
end

function TianjuecontractlistViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TianjuecontractlistViewPresentor:dependWhatResources()
	return {
		"ui/views/contract/tianjuecontractlistview.prefab"
	}
end

function TianjuecontractlistViewPresentor:buildViews()
	return {
		TianjuecontractlistView.New()
	}
end

return TianjuecontractlistViewPresentor
