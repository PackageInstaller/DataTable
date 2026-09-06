-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originchenclg/view/OriginchenclgextremestageViewPresentor.lua

module("logic.extensions.originchenclg.view.OriginchenclgextremestageViewPresentor", package.seeall)

local OriginchenclgextremestageViewPresentor = class("OriginchenclgextremestageViewPresentor", ViewPresentor)

function OriginchenclgextremestageViewPresentor:ctor()
	OriginchenclgextremestageViewPresentor.super.ctor(self)
end

function OriginchenclgextremestageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginchenclgextremestageViewPresentor:dependWhatResources()
	return {
		"ui/views/originchenclg/originchenclgextremestageview.prefab"
	}
end

function OriginchenclgextremestageViewPresentor:buildViews()
	return {
		OriginchenclgextremestageView.New()
	}
end

return OriginchenclgextremestageViewPresentor
