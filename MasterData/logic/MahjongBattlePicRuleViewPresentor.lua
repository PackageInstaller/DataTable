-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mahjongbattle/view/MahjongBattlePicRuleViewPresentor.lua

module("logic.extensions.mahjongbattle.view.MahjongBattlePicRuleViewPresentor", package.seeall)

local MahjongBattlePicRuleViewPresentor = class("MahjongBattlePicRuleViewPresentor", ViewPresentor)

function MahjongBattlePicRuleViewPresentor:ctor()
	MahjongBattlePicRuleViewPresentor.super.ctor(self)
end

function MahjongBattlePicRuleViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MahjongBattlePicRuleViewPresentor:dependWhatResources()
	return {
		"ui/views/mahjongbattle/mahjongbattlepicruleview.prefab"
	}
end

function MahjongBattlePicRuleViewPresentor:buildViews()
	return {
		MahjongBattlePicRuleView.New()
	}
end

return MahjongBattlePicRuleViewPresentor
