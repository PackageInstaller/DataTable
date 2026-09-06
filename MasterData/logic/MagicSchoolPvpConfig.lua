-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/magicschoolpvp/config/MagicSchoolPvpConfig.lua

module("logic.extensions.magicschoolpvp.config.MagicSchoolPvpConfig", package.seeall)

local MagicSchoolPvpConfig = class("MagicSchoolPvpConfig", BaseConfig)

function MagicSchoolPvpConfig:getNames()
	return {
		"magic_school_pvp_activity",
		"magic_school_pvp_common",
		"magic_school_pvp_creeps",
		"magic_school_pvp_rank_prize",
		"magic_school_pvp_boss",
		"magic_school_pvp_monster",
		"magic_school_pvp_chat"
	}
end

function MagicSchoolPvpConfig:handleConfig(name, content)
	if name == "magic_school_pvp_activity" then
		self._magic_school_pvp_activity = content
	elseif name == "magic_school_pvp_common" then
		self._magic_school_pvp_common = content
	elseif name == "magic_school_pvp_creeps" then
		self._magic_school_pvp_creeps = content
	elseif name == "magic_school_pvp_rank_prize" then
		self._magic_school_pvp_rank_prize = content

		self:_handleRankPrizeCfg(content.dataList)
	elseif name == "magic_school_pvp_boss" then
		self._magic_school_pvp_boss = content
	elseif name == "magic_school_pvp_monster" then
		self._magic_school_pvp_monster = content
	elseif name == "magic_school_pvp_chat" then
		self._magic_school_pvp_chat = content
	end
end

function MagicSchoolPvpConfig:getActivityData(activityId)
	return self:_safeGet(self._magic_school_pvp_activity, activityId)
end

function MagicSchoolPvpConfig:getCommonDataValue(key, isToNumber)
	local data = self:_safeGet(self._magic_school_pvp_common, key)
	local value = data and data.value

	if isToNumber then
		return checknumber(value)
	end

	return value
end

function MagicSchoolPvpConfig:getCreepsDatas(creepsMasterId)
	return self:_safeGet(self._magic_school_pvp_creeps, creepsMasterId)
end

function MagicSchoolPvpConfig:getCreepsData(creepsMasterId, creepsId)
	return self:_safeGet(self._magic_school_pvp_creeps, creepsMasterId, creepsId)
end

function MagicSchoolPvpConfig:getRankPrizeDatas(activityId)
	return self:_safeGet(self._magic_school_pvp_rank_prize, activityId)
end

function MagicSchoolPvpConfig:getRankPrizeData(activityId, rank)
	local dataList = self._rankPrizeDataLists[activityId]

	return MmUtil.binarySearchInArrayKey(dataList, "rankRange", rank)
end

function MagicSchoolPvpConfig:_handleRankPrizeCfg(dataList)
	self._rankPrizeDataLists = {}

	for _, data in ipairs(dataList) do
		self._rankPrizeDataLists[data.activityId] = self._rankPrizeDataLists[data.activityId] or {}

		table.insert(self._rankPrizeDataLists[data.activityId], data)
	end

	for k, v in pairs(self._rankPrizeDataLists) do
		table.sort(v, function(a, b)
			return a.index < b.index
		end)
	end
end

function MagicSchoolPvpConfig:getBossDatas(activityId)
	return self:_safeGet(self._magic_school_pvp_boss, activityId)
end

function MagicSchoolPvpConfig:getBossData(activityId, bossId)
	return self:_safeGet(self._magic_school_pvp_boss, activityId, bossId)
end

function MagicSchoolPvpConfig:getMonsterData(creepsMasterId)
	return self:_safeGet(self._magic_school_pvp_monster, creepsMasterId)
end

function MagicSchoolPvpConfig:getChatData(chatId)
	return self:_safeGet(self._magic_school_pvp_chat, chatId)
end

function MagicSchoolPvpConfig:getChatDataList()
	return self._magic_school_pvp_chat.dataList
end

function MagicSchoolPvpConfig:_safeGet(data, ...)
	local keys = {
		...
	}
	local current = data

	for i = 1, #keys do
		if current and type(current) == "table" then
			current = current[keys[i]]
		else
			current = nil

			break
		end
	end

	return current
end

MagicSchoolPvpConfig.instance = MagicSchoolPvpConfig.New()

return MagicSchoolPvpConfig
