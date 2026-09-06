-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/noahchallenge/view/nuoya/NuoyaShenqiEnterBattleViewPresentor.lua

module("logic.extensions.noahchallenge.view.nuoya.NuoyaShenqiEnterBattleViewPresentor", package.seeall)

local NuoyaShenqiEnterBattleViewPresentor = class("NuoyaShenqiEnterBattleViewPresentor", ViewPresentor)

function NuoyaShenqiEnterBattleViewPresentor:ctor()
	NuoyaShenqiEnterBattleViewPresentor.super.ctor(self)
end

function NuoyaShenqiEnterBattleViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NuoyaShenqiEnterBattleViewPresentor:dependWhatResources()
	return {
		"ui/views/shenqi/nuoya/nuoyashenqintoview.prefab"
	}
end

function NuoyaShenqiEnterBattleViewPresentor:buildViews()
	return {
		NuoyaShenqiEnterBattleView.New()
	}
end

return NuoyaShenqiEnterBattleViewPresentor
