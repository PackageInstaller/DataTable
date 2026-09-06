-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/doubleeleven/view/RebatemallbuyViewPresentor.lua

module("logic.extensions.doubleeleven.view.RebatemallbuyViewPresentor", package.seeall)

local RebatemallbuyViewPresentor = class("RebatemallbuyViewPresentor", ViewPresentor)

function RebatemallbuyViewPresentor:ctor()
	RebatemallbuyViewPresentor.super.ctor(self)
end

function RebatemallbuyViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function RebatemallbuyViewPresentor:dependWhatResources()
	return {
		"ui/views/doubleeleven/rebatemallbuyview.prefab"
	}
end

function RebatemallbuyViewPresentor:buildViews()
	return {
		RebatemallbuyView.New()
	}
end

return RebatemallbuyViewPresentor
