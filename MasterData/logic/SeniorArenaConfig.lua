-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/seniorarena/config/SeniorArenaConfig.lua

module("logic.extensions.seniorarena.config.SeniorArenaConfig", package.seeall)

local SeniorArenaConfig = class("SeniorArenaConfig", BaseConfig)

function SeniorArenaConfig:onInit()
	SeniorArenaConfig.super.onInit(self)

	self._cofignameCfg = nil
end

function SeniorArenaConfig:getNames()
	return {
		"arena_3v3_common",
		"arena_3v3_season",
		"arena_3v3_zone",
		"arena_3v3_top_group",
		"arena_3v3_robot",
		"arena_3v3_robot_creeps",
		"arena_3v3_buy_challenge"
	}
end

function SeniorArenaConfig:handleConfig(name, content)
	if name == "arena_3v3_common" then
		self._commonCfg = content
	elseif name == "arena_3v3_season" then
		self._seasonCfg = content
	elseif name == "arena_3v3_zone" then
		self._zoneCfg = content
	elseif name == "arena_3v3_top_group" then
		self._rankCfg = content
	elseif name == "arena_3v3_robot" then
		self._robotCfg = content
	elseif name == "arena_3v3_robot_creeps" then
		self._robotCreepsCfg = content
	elseif name == "arena_3v3_buy_challenge" then
		self._buyPriceCfg = content
	end
end

function SeniorArenaConfig:getSeasonCfgList()
	return self._seasonCfg.dataList
end

function SeniorArenaConfig:getSeasonCfg(seasonId)
	return self._seasonCfg[seasonId]
end

function SeniorArenaConfig:getCommonValue(key, toNumber)
	local str = ""

	if self._commonCfg and self._commonCfg[key] then
		str = self._commonCfg[key].value
	end

	if toNumber == true then
		return checknumber(str)
	else
		return str
	end
end

function SeniorArenaConfig:getZoneCfgById(id)
	if self._zoneCfg then
		return self._zoneCfg[id]
	end
end

function SeniorArenaConfig:getTicketCfg()
	local ticketId = self:getCommonValue("CHALLENGE_USE", true)

	print("ticketId = " .. ticketId)

	return ItemConfig.instance:getCfgById(ticketId)
end

function SeniorArenaConfig:getRankCfgByRank(rank)
	if self._rankCfg then
		local cfgList = self._rankCfg.dataList

		for k, v in ipairs(cfgList) do
			if rank == v.rank then
				return v
			elseif k > 1 and rank < v.rank then
				return v
			end
		end
	end
end

function SeniorArenaConfig:getRankCfgList()
	if self._rankCfg then
		return self._rankCfg.dataList or {}
	else
		return {}
	end
end

function SeniorArenaConfig:getMaxBuyTicketTime()
	local max = 0

	if self._buyPriceCfg then
		for k, v in ipairs(self._buyPriceCfg.dataList) do
			if max < v.times then
				max = v.times
			end
		end
	end

	return max
end

function SeniorArenaConfig:getBuyTicketMat(times)
	if self._buyPriceCfg then
		return (self._buyPriceCfg or nil) and (self._buyPriceCfg.cost or nil)
	end
end

function SeniorArenaConfig:getBuyTicketPrice(times)
	if self._buyPriceCfg and self._buyPriceCfg[times] then
		local cost = self._buyPriceCfg[times].cost

		print("cost = " .. cost)

		local array = string.split(cost, ":")
		local matId = checknumber(array[2])
		local matNum = checknumber(array[3])

		return matNum * GoodsConfig.instance:getCfgPrice(matId)
	end
end

function SeniorArenaConfig:getCostMatsWithBuyTimes(startTimes, endTimes)
	local matArray = {}
	local cfg = self._buyPriceCfg

	if cfg then
		for i, v in ipairs(cfg) do
			if startTimes <= v.times and endTimes >= v.times then
				local matStr = v.cost
				local matType, matId, matNum = MaterialMgr.getMatParams(matStr)
				local matKey = string.format("%s:%s", matType, matId)

				matArray[matKey] = (matArray[matKey] or 0) + matNum
			end
		end
	end

	return matArray
end

SeniorArenaConfig.instance = SeniorArenaConfig.New()

return SeniorArenaConfig
