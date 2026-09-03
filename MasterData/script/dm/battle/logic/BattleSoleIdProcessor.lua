-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/BattleSoleIdProcessor.lua

BattleSoleIdProcessor = class("BattleSoleIdProcessor")

function BattleSoleIdProcessor.class:genBattleSkillId(unitId, skillId)
	return string.format("%s#%s", unitId, skillId)
end

function BattleSoleIdProcessor.class:splitBattleSkillId(skillId)
	return unpack(string.split(skillId, "#"))
end

function BattleSoleIdProcessor.class:genUnitId(playerId, wave, index, isEnemy, heroId)
	heroId = heroId ~= nil and "#" .. heroId or ""
	playerId = playerId or ""

	if isEnemy then
		return string.format("e_%s_%s_%s%s", tostring(playerId), wave, index, heroId)
	else
		return string.format("f_%s_%s_%s%s", tostring(playerId), wave, index, heroId)
	end
end

function BattleSoleIdProcessor.class:splitBattleUnitId(unitId)
	if string.find(unitId, "#") then
		local parts = string.split(unitId, "#")
		local front, heroId = unpack(parts)
		local parts2 = string.split(front, "_")
		local pre, wave, index = unpack(parts2)

		return heroId, wave, index
	end

	return nil
end

function BattleSoleIdProcessor.class:genAIRegex(unitId, regex)
	return string.format("%s#%s", unitId, regex)
end
