-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originchenclg/view/OriginchenclgmainViewPresentor.lua

module("logic.extensions.originchenclg.view.OriginchenclgmainViewPresentor", package.seeall)

local OriginchenclgmainViewPresentor = class("OriginchenclgmainViewPresentor", ViewPresentor)

function OriginchenclgmainViewPresentor:ctor()
	OriginchenclgmainViewPresentor.super.ctor(self)
end

function OriginchenclgmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginchenclgmainViewPresentor:dependWhatResources()
	return {
		"ui/views/originchenclg/originchenclgmainview.prefab"
	}
end

function OriginchenclgmainViewPresentor:buildViews()
	return {
		OriginchenclgmainView.New()
	}
end

return OriginchenclgmainViewPresentor
