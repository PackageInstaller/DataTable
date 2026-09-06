-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miraclefindtreasure/view/MiraclefindtreasureautoViewPresentor.lua

module("logic.extensions.miraclefindtreasure.view.MiraclefindtreasureautoViewPresentor", package.seeall)

local MiraclefindtreasureautoViewPresentor = class("MiraclefindtreasureautoViewPresentor", ViewPresentor)

function MiraclefindtreasureautoViewPresentor:ctor()
	MiraclefindtreasureautoViewPresentor.super.ctor(self)
end

function MiraclefindtreasureautoViewPresentor:attachToWhichRoot()
	return ViewRootType.Notify
end

function MiraclefindtreasureautoViewPresentor:dependWhatResources()
	return {
		"ui/views/miraclefindtreasure/miraclefindtreasureautoview.prefab"
	}
end

function MiraclefindtreasureautoViewPresentor:buildViews()
	return {
		MiraclefindtreasureautoView.New()
	}
end

return MiraclefindtreasureautoViewPresentor
