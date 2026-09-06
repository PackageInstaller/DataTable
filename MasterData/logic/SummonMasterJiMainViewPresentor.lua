-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summonmasterji/view/SummonMasterJiMainViewPresentor.lua

module("logic.extensions.summonmasterji.view.SummonMasterJiMainViewPresentor", package.seeall)

local SummonMasterJiMainViewPresentor = class("SummonMasterJiMainViewPresentor", ViewPresentor)

function SummonMasterJiMainViewPresentor:ctor()
	SummonMasterJiMainViewPresentor.super.ctor(self)
end

function SummonMasterJiMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SummonMasterJiMainViewPresentor:dependWhatResources()
	return {
		"ui/views/summonmasterji/summonmasterjimainview.prefab"
	}
end

function SummonMasterJiMainViewPresentor:buildViews()
	return {
		SummonMasterJiMainView.New()
	}
end

return SummonMasterJiMainViewPresentor
