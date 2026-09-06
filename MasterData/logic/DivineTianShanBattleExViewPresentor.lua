-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinetianshanclg/view/DivineTianShanBattleExViewPresentor.lua

module("logic.extensions.divinetianshanclg.view.DivineTianShanBattleExViewPresentor", package.seeall)

local DivineTianShanBattleExViewPresentor = class("DivineTianShanBattleExViewPresentor", ViewPresentor)

function DivineTianShanBattleExViewPresentor:ctor()
	DivineTianShanBattleExViewPresentor.super.ctor(self)
end

function DivineTianShanBattleExViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineTianShanBattleExViewPresentor:dependWhatResources()
	return {
		"ui/views/divinetianshanclg/divinetianshanbattleexview.prefab"
	}
end

function DivineTianShanBattleExViewPresentor:buildViews()
	return {
		DivineTianShanBattleExView.New()
	}
end

return DivineTianShanBattleExViewPresentor
