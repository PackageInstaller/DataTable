-- chunkname: @modules/logic/versionactivity2_6/dicehero/config/DiceHeroConfig.lua

module("modules.logic.versionactivity2_6.dicehero.config.DiceHeroConfig", package.seeall)

local DiceHeroConfig = class("DiceHeroConfig", BaseConfig)

function DiceHeroConfig:reqConfigNames()
	return {
		"dice",
		"dice_buff",
		"dice_card",
		"dice_character",
		"dice_enemy",
		"dice_level",
		"dice_pattern",
		"dice_relic",
		"dice_point",
		"dice_suit",
		"dice_dialogue",
		"dice_task"
	}
end

function DiceHeroConfig:getTaskList()
	local list = {}

	for i, v in ipairs(lua_dice_task.configList) do
		if v.isOnline == 1 then
			table.insert(list, v)
		end
	end

	return list
end

function DiceHeroConfig:getLevelCo(chapterId, roomId)
	for i, v in ipairs(lua_dice_level.configList) do
		if v.chapter == chapterId and v.room == roomId then
			return v
		end
	end
end

function DiceHeroConfig:getLevelCos(chapterId)
	if not self._levelCos then
		self._levelCos = {}

		for i, v in ipairs(lua_dice_level.configList) do
			self._levelCos[v.chapter] = self._levelCos[v.chapter] or {}
			self._levelCos[v.chapter][v.room] = v
		end
	end

	return self._levelCos[chapterId] or {}
end

function DiceHeroConfig:getDiceSuitDict(suitId)
	if not self._suitDict then
		self._suitDict = {}

		for _, suitCo in ipairs(lua_dice_suit.configList) do
			local dict = {}

			for _, suit in ipairs(string.splitToNumber(suitCo.suit, "#") or {}) do
				dict[suit] = true
			end

			self._suitDict[suitCo.id] = dict
		end

		local any = {}

		GameUtil.setDefaultValue(any, true)

		self._suitDict[0] = any
	end

	return self._suitDict[suitId]
end

function DiceHeroConfig:getDicePointDict(pointId)
	if not self._pointDict then
		self._pointDict = {}

		for _, pointCo in ipairs(lua_dice_point.configList) do
			local dict = {}

			for _, point in ipairs(string.splitToNumber(pointCo.pointList, "#") or {}) do
				dict[point] = true
			end

			self._pointDict[pointCo.id] = dict
		end

		local any = {}

		GameUtil.setDefaultValue(any, true)

		self._pointDict[0] = any
	end

	return self._pointDict[pointId]
end

DiceHeroConfig.instance = DiceHeroConfig.New()

return DiceHeroConfig
