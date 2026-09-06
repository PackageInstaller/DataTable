-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/martialcontest/view/MartialContestEquipViewPresentor.lua

module("logic.extensions.martialcontest.view.MartialContestEquipViewPresentor", package.seeall)

local MartialContestEquipViewPresentor = class("MartialContestEquipViewPresentor", ViewPresentor)

function MartialContestEquipViewPresentor:ctor()
	MartialContestEquipViewPresentor.super.ctor(self)
end

function MartialContestEquipViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MartialContestEquipViewPresentor:dependWhatResources()
	return {
		"ui/views/martialcontest/martialcontestequipview.prefab"
	}
end

function MartialContestEquipViewPresentor:buildViews()
	return {
		MartialContestEquipView.New()
	}
end

return MartialContestEquipViewPresentor
