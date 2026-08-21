-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battlerecord/view/BattleRecordViewPresentor.lua

module("logic.extensions.battlerecord.view.BattleRecordViewPresentor", package.seeall)

local BattleRecordViewPresentor = class("BattleRecordViewPresentor", ViewPresentor)

function BattleRecordViewPresentor:dependWhatResources()
	return {
		ResName.Battlerecord_battle_record
	}
end

function BattleRecordViewPresentor:attachToWhichRoot()
	return ViewRootType.Top
end

function BattleRecordViewPresentor:buildViews()
	local views = {}

	table.insert(views, BattleRecordView.New())

	return views
end

return BattleRecordViewPresentor
