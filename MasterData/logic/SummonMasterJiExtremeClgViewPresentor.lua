-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summonmasterji/view/SummonMasterJiExtremeClgViewPresentor.lua

module("logic.extensions.summonmasterji.view.SummonMasterJiExtremeClgViewPresentor", package.seeall)

local SummonMasterJiExtremeClgViewPresentor = class("SummonMasterJiExtremeClgViewPresentor", ViewPresentor)

function SummonMasterJiExtremeClgViewPresentor:ctor()
	SummonMasterJiExtremeClgViewPresentor.super.ctor(self)
end

function SummonMasterJiExtremeClgViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SummonMasterJiExtremeClgViewPresentor:dependWhatResources()
	return {
		"ui/views/summonmasterji/summonmasterjiextremeclgview.prefab"
	}
end

function SummonMasterJiExtremeClgViewPresentor:buildViews()
	return {
		SummonMasterJiExtremeClgView.New()
	}
end

return SummonMasterJiExtremeClgViewPresentor
