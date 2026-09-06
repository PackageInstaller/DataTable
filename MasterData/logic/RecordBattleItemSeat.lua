-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formation/view/RecordBattleItemSeat.lua

module(..., package.seeall)

local LuaComponentContainer = Framework.LuaComponentContainer
local RecordBattleItemSeat = class("RecordBattleItemSeat", ItemSeat)

function RecordBattleItemSeat.AddOnce(go)
	local component = RecordBattleItemSeat.Get(go)

	component = component or LuaComponentContainer.Add(go, RecordBattleItemSeat)

	return component
end

function RecordBattleItemSeat.Get(go)
	return (LuaComponentContainer.Get(go, RecordBattleItemSeat))
end

function RecordBattleItemSeat.Remove(go)
	local LuaComponentContainer = Framework.LuaComponentContainer

	LuaComponentContainer.Remove(go, RecordBattleItemSeat)
end

function RecordBattleItemSeat:_getPet(petId)
	return BattleRecordFmtModel.instance:getPet(petId)
end

function RecordBattleItemSeat:_getCurFormId()
	return BattleRecordFmtModel.instance:getCurFormationId()
end

return RecordBattleItemSeat
