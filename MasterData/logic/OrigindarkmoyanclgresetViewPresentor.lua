-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origindarkmoyanclg/view/OrigindarkmoyanclgresetViewPresentor.lua

module("logic.extensions.origindarkmoyanclg.view.OrigindarkmoyanclgresetViewPresentor", package.seeall)

local OrigindarkmoyanclgresetViewPresentor = class("OrigindarkmoyanclgresetViewPresentor", ViewPresentor)

function OrigindarkmoyanclgresetViewPresentor:ctor()
	OrigindarkmoyanclgresetViewPresentor.super.ctor(self)
end

function OrigindarkmoyanclgresetViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function OrigindarkmoyanclgresetViewPresentor:dependWhatResources()
	return {
		"ui/views/origindarkmoyanclg/origindarkmoyanclgresetview.prefab"
	}
end

function OrigindarkmoyanclgresetViewPresentor:buildViews()
	return {
		OrigindarkmoyanclgresetView.New()
	}
end

return OrigindarkmoyanclgresetViewPresentor
