-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/richmanxplan/view/RmxplanziyuaneventViewPresentor.lua

module("logic.extensions.richmanxplan.view.RmxplanziyuaneventViewPresentor", package.seeall)

local RmxplanziyuaneventViewPresentor = class("RmxplanziyuaneventViewPresentor", ViewPresentor)

function RmxplanziyuaneventViewPresentor:ctor()
	RmxplanziyuaneventViewPresentor.super.ctor(self)
end

function RmxplanziyuaneventViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function RmxplanziyuaneventViewPresentor:dependWhatResources()
	return {
		"ui/views/richmanxplan/rmxplanziyuaneventview.prefab"
	}
end

function RmxplanziyuaneventViewPresentor:buildViews()
	return {
		RmxplanziyuaneventView.New()
	}
end

return RmxplanziyuaneventViewPresentor
