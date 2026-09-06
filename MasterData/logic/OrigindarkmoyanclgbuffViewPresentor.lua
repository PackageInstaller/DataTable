-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origindarkmoyanclg/view/OrigindarkmoyanclgbuffViewPresentor.lua

module("logic.extensions.origindarkmoyanclg.view.OrigindarkmoyanclgbuffViewPresentor", package.seeall)

local OrigindarkmoyanclgbuffViewPresentor = class("OrigindarkmoyanclgbuffViewPresentor", ViewPresentor)

function OrigindarkmoyanclgbuffViewPresentor:ctor()
	OrigindarkmoyanclgbuffViewPresentor.super.ctor(self)
end

function OrigindarkmoyanclgbuffViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function OrigindarkmoyanclgbuffViewPresentor:dependWhatResources()
	return {
		"ui/views/origindarkmoyanclg/origindarkmoyanclgbuffview.prefab"
	}
end

function OrigindarkmoyanclgbuffViewPresentor:buildViews()
	return {
		OrigindarkmoyanclgbuffView.New()
	}
end

return OrigindarkmoyanclgbuffViewPresentor
