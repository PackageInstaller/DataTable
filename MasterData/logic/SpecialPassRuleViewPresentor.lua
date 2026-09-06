-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mission/view/SpecialPassRuleViewPresentor.lua

module("logic.extensions.mission.view.SpecialPassRuleViewPresentor", package.seeall)

local SpecialPassRuleViewPresentor = class("SpecialPassRuleViewPresentor", ViewPresentor)

function SpecialPassRuleViewPresentor:ctor()
	SpecialPassRuleViewPresentor.super.ctor(self)
end

function SpecialPassRuleViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SpecialPassRuleViewPresentor:dependWhatResources()
	return {
		"ui/views/challenge/specialpassruleview.prefab"
	}
end

function SpecialPassRuleViewPresentor:getTempResources()
	local chapterId = self:getFirstParam()
	local cfg = MaterialChallengeConfig.instance:getChapter(chapterId)
	local paths = {}

	if not cfg then
		return paths
	end

	table.insert(paths, GameUrl.getCopyChapterBgUrl(cfg.popupPic))

	return paths
end

function SpecialPassRuleViewPresentor:buildViews()
	return {
		SpecialPassRuleView.New()
	}
end

return SpecialPassRuleViewPresentor
