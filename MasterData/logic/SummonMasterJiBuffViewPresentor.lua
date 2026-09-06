-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summonmasterji/view/SummonMasterJiBuffViewPresentor.lua

module("logic.extensions.summonmasterji.view.SummonMasterJiBuffViewPresentor", package.seeall)

local SummonMasterJiBuffViewPresentor = class("SummonMasterJiBuffViewPresentor", ViewPresentor)

function SummonMasterJiBuffViewPresentor:ctor()
	SummonMasterJiBuffViewPresentor.super.ctor(self)
end

function SummonMasterJiBuffViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SummonMasterJiBuffViewPresentor:dependWhatResources()
	return {
		"ui/views/summonmasterji/summonmasterjibuffview.prefab"
	}
end

function SummonMasterJiBuffViewPresentor:buildViews()
	return {
		SummonMasterJiBuffView.New()
	}
end

return SummonMasterJiBuffViewPresentor
