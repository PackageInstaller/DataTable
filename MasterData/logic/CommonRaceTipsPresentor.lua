-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/instruction/view/CommonRaceTipsPresentor.lua

module("logic.extensions.common.instruction.view.CommonRaceTipsPresentor", package.seeall)

local CommonRaceTipsPresentor = class("CommonRaceTipsPresentor", ViewPresentor)

function CommonRaceTipsPresentor:ctor()
	CommonRaceTipsPresentor.super.ctor(self)
end

function CommonRaceTipsPresentor:attachToWhichRoot()
	return ViewRootType.Notify
end

function CommonRaceTipsPresentor:dependWhatResources()
	return {
		"ui/views/common/race_tips.prefab"
	}
end

function CommonRaceTipsPresentor:buildViews()
	return {
		CommonRaceTipsView.New()
	}
end

return CommonRaceTipsPresentor
