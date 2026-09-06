-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origindarkmoyanclg/view/OrigindarkmoyanclgmainViewPresentor.lua

module("logic.extensions.origindarkmoyanclg.view.OrigindarkmoyanclgmainViewPresentor", package.seeall)

local OrigindarkmoyanclgmainViewPresentor = class("OrigindarkmoyanclgmainViewPresentor", ViewPresentor)

function OrigindarkmoyanclgmainViewPresentor:ctor()
	OrigindarkmoyanclgmainViewPresentor.super.ctor(self)
end

function OrigindarkmoyanclgmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OrigindarkmoyanclgmainViewPresentor:dependWhatResources()
	return {
		"ui/views/origindarkmoyanclg/origindarkmoyanclgmainview.prefab"
	}
end

function OrigindarkmoyanclgmainViewPresentor:buildViews()
	return {
		OrigindarkmoyanclgmainView.New()
	}
end

return OrigindarkmoyanclgmainViewPresentor
