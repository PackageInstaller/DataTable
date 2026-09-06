-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originchenclg/view/OriginchenclgextremestageresultViewPresentor.lua

module("logic.extensions.originchenclg.view.OriginchenclgextremestageresultViewPresentor", package.seeall)

local OriginchenclgextremestageresultViewPresentor = class("OriginchenclgextremestageresultViewPresentor", ViewPresentor)

function OriginchenclgextremestageresultViewPresentor:ctor()
	OriginchenclgextremestageresultViewPresentor.super.ctor(self)
end

function OriginchenclgextremestageresultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginchenclgextremestageresultViewPresentor:dependWhatResources()
	return {
		"ui/views/originchenclg/originchenclgextremestageresultview.prefab"
	}
end

function OriginchenclgextremestageresultViewPresentor:buildViews()
	return {
		OriginchenclgextremestageresultView.New()
	}
end

return OriginchenclgextremestageresultViewPresentor
