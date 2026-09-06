-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godstatueswar/view/GodStatuesWarNestBattleResultViewPresentor.lua

module("logic.extensions.godstatueswar.view.GodStatuesWarNestBattleResultViewPresentor", package.seeall)

local GodStatuesWarNestBattleResultViewPresentor = class("GodStatuesWarNestBattleResultViewPresentor", ViewPresentor)

function GodStatuesWarNestBattleResultViewPresentor:ctor()
	GodStatuesWarNestBattleResultViewPresentor.super.ctor(self)
end

function GodStatuesWarNestBattleResultViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function GodStatuesWarNestBattleResultViewPresentor:dependWhatResources()
	return {
		"ui/views/godstatueswar/godstatueswarnestbattleresultview.prefab"
	}
end

function GodStatuesWarNestBattleResultViewPresentor:buildViews()
	return {
		GodStatuesWarNestBattleResultView.New()
	}
end

return GodStatuesWarNestBattleResultViewPresentor
