-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/doushouqi/view/DoushouqimatchViewPresentor.lua

module("logic.extensions.doushouqi.view.DoushouqimatchViewPresentor", package.seeall)

local DoushouqimatchViewPresentor = class("DoushouqimatchViewPresentor", ViewPresentor)

function DoushouqimatchViewPresentor:ctor()
	DoushouqimatchViewPresentor.super.ctor(self)
end

function DoushouqimatchViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function DoushouqimatchViewPresentor:dependWhatResources()
	return {
		"ui/views/doushouqi/doushouqimatchview.prefab"
	}
end

function DoushouqimatchViewPresentor:buildViews()
	return {
		DoushouqimatchView.New()
	}
end

return DoushouqimatchViewPresentor
