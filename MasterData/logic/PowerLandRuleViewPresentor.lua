-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/powerland/view/PowerLandRuleViewPresentor.lua

module("logic.extensions.powerland.view.PowerLandRuleViewPresentor", package.seeall)

local PowerLandRuleViewPresentor = class("PowerLandRuleViewPresentor", ViewPresentor)

PowerLandRuleViewPresentor.IconPath = {
	"ui/bigbg/copychapter/board_ycllmj_01.png",
	"ui/bigbg/copychapter/board_ycllmj_02.png",
	"ui/bigbg/copychapter/board_ycllmj_03.png",
	"ui/bigbg/copychapter/board_ycllmj_10.png"
}

function PowerLandRuleViewPresentor:ctor()
	PowerLandRuleViewPresentor.super.ctor(self)
end

function PowerLandRuleViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PowerLandRuleViewPresentor:dependWhatResources()
	return {
		"ui/views/powerland/powerlandruleview.prefab"
	}
end

function PowerLandRuleViewPresentor:buildViews()
	return {
		PowerLandRuleView.New()
	}
end

function PowerLandRuleViewPresentor:getTempResources()
	local resultPath = {}

	table.insert(resultPath, PowerLandRuleViewPresentor.IconPath[1])
	table.insert(resultPath, PowerLandRuleViewPresentor.IconPath[2])

	return resultPath
end

return PowerLandRuleViewPresentor
