-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiaoxiaoleskin/config/ScratchLotteryConfig.lua

module("logic.extensions.xiaoxiaoleskin.config.ScratchLotteryConfig", package.seeall)

local ScratchLotteryConfig = class("ScratchLotteryConfig", BaseConfig)

function ScratchLotteryConfig:onInit()
	ScratchLotteryConfig.super.onInit(self)

	self._cofignameCfg = nil
end

function ScratchLotteryConfig:getNames()
	return {
		"scratch_lottery_activity",
		"scratch_lottery_cost",
		"scratch_lottery_base_prize",
		"scratch_lottery_big_prize_plan",
		"scratch_lottery_spirit",
		"scratch_lottery_cochannel_replacement"
	}
end

function ScratchLotteryConfig:handleConfig(name, content)
	if name == "scratch_lottery_activity" then
		self._cofignameCfg = content
	elseif name == "scratch_lottery_cost" then
		self._scratch_lottery_cost = content
	elseif name == "scratch_lottery_base_prize" then
		self._scratch_lottery_base_prize = content
	elseif name == "scratch_lottery_big_prize_plan" then
		self._scratch_lottery_big_prize_plan = content
	elseif name == "scratch_lottery_spirit" then
		self._scratch_lottery_spirit = content
	elseif name == "scratch_lottery_cochannel_replacement" then
		self._scratch_lottery_cochannel_replacement = content
	end
end

function ScratchLotteryConfig:getCfgById(id)
	return self._cofignameCfg[id]
end

function ScratchLotteryConfig:getPrizeById(actId, id)
	if self._scratch_lottery_base_prize[actId] then
		return self._scratch_lottery_base_prize[actId][id].prize
	end

	return ""
end

function ScratchLotteryConfig:getCostCfgs(actId)
	return self._scratch_lottery_cost[actId]
end

function ScratchLotteryConfig:getCostByTimes(actId, time)
	if self._scratch_lottery_cost[actId] then
		if time then
			return self._scratch_lottery_cost[actId][time]
		end

		return self._scratch_lottery_cost[actId]
	end

	return {}
end

function ScratchLotteryConfig:getActivityDescById(id)
	local cfg = self:getCfgById(id)

	if cfg then
		return cfg.desc
	end

	return ""
end

function ScratchLotteryConfig:getActivityDesc1ById(id)
	local cfg = self:getCfgById(id)

	if cfg then
		return cfg.desc1
	end

	return ""
end

function ScratchLotteryConfig:getBigPrizeCfgById(id)
	return self._scratch_lottery_big_prize_plan[id]
end

function ScratchLotteryConfig:getShowPetSkinId(id)
	local cfg = self:getCfgById(id)

	if cfg then
		local replaceCfgs = self._scratch_lottery_cochannel_replacement[id]

		if replaceCfgs then
			for k, v in pairs(replaceCfgs) do
				if v.cochannelId then
					local cochannelId = checknumber(LoginModel.instance:getCoChannelId())

					for _, v2 in pairs(v.cochannelId) do
						if cochannelId == v2 then
							return v.display
						end
					end
				end
			end
		end

		return cfg.display
	end

	return {}
end

function ScratchLotteryConfig:getPetPos(id)
	if self._scratch_lottery_spirit[id] then
		return self._scratch_lottery_spirit[id].pos
	end

	return {
		0,
		0,
		0
	}
end

function ScratchLotteryConfig:getPetBgImg(id)
	if self._scratch_lottery_spirit[id] then
		return self._scratch_lottery_spirit[id].bgImg
	end

	return ""
end

ScratchLotteryConfig.instance = ScratchLotteryConfig.New()

return ScratchLotteryConfig
