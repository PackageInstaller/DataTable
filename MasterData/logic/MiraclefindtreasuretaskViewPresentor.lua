-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miraclefindtreasure/view/MiraclefindtreasuretaskViewPresentor.lua

module("logic.extensions.miraclefindtreasure.view.MiraclefindtreasuretaskViewPresentor", package.seeall)

local MiraclefindtreasuretaskViewPresentor = class("MiraclefindtreasuretaskViewPresentor", ViewPresentor)

function MiraclefindtreasuretaskViewPresentor:ctor()
	MiraclefindtreasuretaskViewPresentor.super.ctor(self)
end

function MiraclefindtreasuretaskViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MiraclefindtreasuretaskViewPresentor:dependWhatResources()
	return {
		"ui/views/miraclefindtreasure/miraclefindtreasuretaskview.prefab"
	}
end

function MiraclefindtreasuretaskViewPresentor:buildViews()
	return {
		MiraclefindtreasuretaskView.New()
	}
end

return MiraclefindtreasuretaskViewPresentor
