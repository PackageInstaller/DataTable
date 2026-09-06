-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miraclefindtreasure/view/MiraclefindtreasuredigViewPresentor.lua

module("logic.extensions.miraclefindtreasure.view.MiraclefindtreasuredigViewPresentor", package.seeall)

local MiraclefindtreasuredigViewPresentor = class("MiraclefindtreasuredigViewPresentor", ViewPresentor)

function MiraclefindtreasuredigViewPresentor:ctor()
	MiraclefindtreasuredigViewPresentor.super.ctor(self)
end

function MiraclefindtreasuredigViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MiraclefindtreasuredigViewPresentor:dependWhatResources()
	return {
		"ui/views/miraclefindtreasure/miraclefindtreasuredigview.prefab"
	}
end

function MiraclefindtreasuredigViewPresentor:buildViews()
	return {
		MiraclefindtreasuredigView.New()
	}
end

return MiraclefindtreasuredigViewPresentor
