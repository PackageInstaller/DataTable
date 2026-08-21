-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewundo/BattleUndoViewPresentor.lua

module("logic.extensions.battle.viewundo.BattleUndoViewPresentor", package.seeall)

local BattleUndoViewPresentor = class("BattleUndoViewPresentor", ViewPresentor)

function BattleUndoViewPresentor:dependWhatResources()
	return {
		BattleResourceName.UIUndo,
		BattleResourceName.UIUndoEffect,
		BattleResourceName.UIUndoEffectStart,
		BattleResourceName.UIUndoEffectEnd
	}
end

function BattleUndoViewPresentor:buildViews()
	local views = {}

	table.insert(views, BattleUndoView.New())
	table.insert(views, BattleUndoEffectView.New())

	return views
end

return BattleUndoViewPresentor
