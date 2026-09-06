-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originchenclg/view/OriginchenclgextremestagereplayresultViewPresentor.lua

module("logic.extensions.originchenclg.view.OriginchenclgextremestagereplayresultViewPresentor", package.seeall)

local OriginchenclgextremestagereplayresultViewPresentor = class("OriginchenclgextremestagereplayresultViewPresentor", ViewPresentor)

function OriginchenclgextremestagereplayresultViewPresentor:ctor()
	OriginchenclgextremestagereplayresultViewPresentor.super.ctor(self)
end

function OriginchenclgextremestagereplayresultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginchenclgextremestagereplayresultViewPresentor:dependWhatResources()
	return {
		"ui/views/originchenclg/originchenclgextremestageresultview.prefab"
	}
end

function OriginchenclgextremestagereplayresultViewPresentor:buildViews()
	return {
		OriginchenclgextremestagereplayresultView.New()
	}
end

return OriginchenclgextremestagereplayresultViewPresentor
