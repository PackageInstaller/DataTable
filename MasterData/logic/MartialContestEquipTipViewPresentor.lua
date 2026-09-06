-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/martialcontest/view/MartialContestEquipTipViewPresentor.lua

module("logic.extensions.martialcontest.view.MartialContestEquipTipViewPresentor", package.seeall)

local MartialContestEquipTipViewPresentor = class("MartialContestEquipTipViewPresentor", ViewPresentor)

function MartialContestEquipTipViewPresentor:ctor()
	MartialContestEquipTipViewPresentor.super.ctor(self)
end

function MartialContestEquipTipViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MartialContestEquipTipViewPresentor:dependWhatResources()
	return {
		"ui/views/martialcontest/martialcontestequiptipview.prefab"
	}
end

function MartialContestEquipTipViewPresentor:buildViews()
	return {
		MartialContestEquipTipView.New()
	}
end

return MartialContestEquipTipViewPresentor
