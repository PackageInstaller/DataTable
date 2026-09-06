-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summonmasterji/view/SummonMasterJiExtremeViewPresentor.lua

module("logic.extensions.summonmasterji.view.SummonMasterJiExtremeViewPresentor", package.seeall)

local SummonMasterJiExtremeViewPresentor = class("SummonMasterJiExtremeViewPresentor", ViewPresentor)

function SummonMasterJiExtremeViewPresentor:ctor()
	SummonMasterJiExtremeViewPresentor.super.ctor(self)
end

function SummonMasterJiExtremeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SummonMasterJiExtremeViewPresentor:dependWhatResources()
	return {
		"ui/views/summonmasterji/summonmasterjiextremeview.prefab"
	}
end

function SummonMasterJiExtremeViewPresentor:buildViews()
	return {
		SummonMasterJiExtremeView.New()
	}
end

return SummonMasterJiExtremeViewPresentor
