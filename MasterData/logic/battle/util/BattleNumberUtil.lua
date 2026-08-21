-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/util/BattleNumberUtil.lua

module("logic.battle.util.BattleNumberUtil", package.seeall)

local BattleNumberUtil = {}

BattleNumberUtil.NONE = 0
BattleNumberUtil.SMALL = 1
BattleNumberUtil.BIG = 2

local kTempTable = {}
local kTempValue = 0

function BattleNumberUtil.convertNumber(num)
	num = math.abs(num)

	if num < 10 then
		kTempValue = num

		return string.char(kTempValue)
	end

	table.clear(kTempTable)

	while num >= 1 do
		kTempValue = num % 10

		table.insert(kTempTable, 1, kTempValue)

		num = num / 10
	end

	return string.char(unpack(kTempTable))
end

return BattleNumberUtil
