-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originchenclg/view/OriginchenclgextremeextViewPresentor.lua

module("logic.extensions.originchenclg.view.OriginchenclgextremeextViewPresentor", package.seeall)

local OriginchenclgextremeextViewPresentor = class("OriginchenclgextremeextViewPresentor", ViewPresentor)

function OriginchenclgextremeextViewPresentor:ctor()
	OriginchenclgextremeextViewPresentor.super.ctor(self)
end

function OriginchenclgextremeextViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginchenclgextremeextViewPresentor:dependWhatResources()
	return {
		"ui/views/originchenclg/originchenclgextremeextview.prefab"
	}
end

function OriginchenclgextremeextViewPresentor:buildViews()
	return {
		OriginchenclgextremeextView.New()
	}
end

return OriginchenclgextremeextViewPresentor
