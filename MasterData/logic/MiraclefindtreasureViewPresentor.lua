-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miraclefindtreasure/view/MiraclefindtreasureViewPresentor.lua

module("logic.extensions.miraclefindtreasure.view.MiraclefindtreasureViewPresentor", package.seeall)

local MiraclefindtreasureViewPresentor = class("MiraclefindtreasureViewPresentor", ViewPresentor)

function MiraclefindtreasureViewPresentor:ctor()
	MiraclefindtreasureViewPresentor.super.ctor(self)
end

function MiraclefindtreasureViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function MiraclefindtreasureViewPresentor:dependWhatResources()
	return {
		"ui/views/miraclefindtreasure/miraclefindtreasureview.prefab"
	}
end

function MiraclefindtreasureViewPresentor:buildViews()
	return {
		MiraclefindtreasureView.New()
	}
end

return MiraclefindtreasureViewPresentor
