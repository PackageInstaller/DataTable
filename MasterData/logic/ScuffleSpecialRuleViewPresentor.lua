-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scuffle/view/ScuffleSpecialRuleViewPresentor.lua

module("logic.extensions.scuffle.view.ScuffleSpecialRuleViewPresentor", package.seeall)

local ScuffleSpecialRuleViewPresentor = class("ScuffleSpecialRuleViewPresentor", ViewPresentor)

ScuffleSpecialRuleViewPresentor.IconPath = {
	"ui/bigbg/copychapter/board_dld_01.png",
	"ui/bigbg/copychapter/board_dld_02.png"
}

function ScuffleSpecialRuleViewPresentor:ctor()
	ScuffleSpecialRuleViewPresentor.super.ctor(self)
end

function ScuffleSpecialRuleViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ScuffleSpecialRuleViewPresentor:dependWhatResources()
	return {
		"ui/views/scuffle/scufflespecialruleview.prefab"
	}
end

function ScuffleSpecialRuleViewPresentor:buildViews()
	return {
		ScuffleSpecialRuleView.New()
	}
end

function ScuffleSpecialRuleViewPresentor:getTempResources()
	local resultPath = {}

	table.insert(resultPath, ScuffleSpecialRuleViewPresentor.IconPath[1])
	table.insert(resultPath, ScuffleSpecialRuleViewPresentor.IconPath[2])

	return resultPath
end

return ScuffleSpecialRuleViewPresentor
