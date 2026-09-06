-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/starbattle/view/StarBattleBossFmtExViewPresentor.lua

module("logic.extensions.starbattle.view.StarBattleBossFmtExViewPresentor", package.seeall)

local StarBattleBossFmtExViewPresentor = class("StarBattleBossFmtExViewPresentor", ViewPresentor)

function StarBattleBossFmtExViewPresentor:ctor()
	StarBattleBossFmtExViewPresentor.super.ctor(self)
end

function StarBattleBossFmtExViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function StarBattleBossFmtExViewPresentor:dependWhatResources()
	return {
		"ui/views/starbattle/starbattlebossfmtexview.prefab"
	}
end

function StarBattleBossFmtExViewPresentor:buildViews()
	return {
		StarBattleBossFmtExView.New()
	}
end

return StarBattleBossFmtExViewPresentor
