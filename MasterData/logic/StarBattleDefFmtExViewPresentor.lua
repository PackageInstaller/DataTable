-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/starbattle/view/StarBattleDefFmtExViewPresentor.lua

module("logic.extensions.starbattle.view.StarBattleDefFmtExViewPresentor", package.seeall)

local StarBattleDefFmtExViewPresentor = class("StarBattleDefFmtExViewPresentor", ViewPresentor)

function StarBattleDefFmtExViewPresentor:ctor()
	StarBattleDefFmtExViewPresentor.super.ctor(self)
end

function StarBattleDefFmtExViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function StarBattleDefFmtExViewPresentor:dependWhatResources()
	return {
		"ui/views/starbattle/starbattledeffmtexview.prefab"
	}
end

function StarBattleDefFmtExViewPresentor:buildViews()
	return {
		StarBattleDefFmtExView.New()
	}
end

function StarBattleDefFmtExViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return StarBattleDefFmtExViewPresentor
