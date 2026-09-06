-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origindarkmoyanclg/view/OrigindarkmoyanclgstageViewPresentor.lua

module("logic.extensions.origindarkmoyanclg.view.OrigindarkmoyanclgstageViewPresentor", package.seeall)

local OrigindarkmoyanclgstageViewPresentor = class("OrigindarkmoyanclgstageViewPresentor", ViewPresentor)

function OrigindarkmoyanclgstageViewPresentor:ctor()
	OrigindarkmoyanclgstageViewPresentor.super.ctor(self)
end

function OrigindarkmoyanclgstageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OrigindarkmoyanclgstageViewPresentor:dependWhatResources()
	return {
		"ui/views/origindarkmoyanclg/origindarkmoyanclgstageview.prefab"
	}
end

function OrigindarkmoyanclgstageViewPresentor:buildViews()
	return {
		OrigindarkmoyanclgstageView.New()
	}
end

return OrigindarkmoyanclgstageViewPresentor
