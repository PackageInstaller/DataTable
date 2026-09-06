-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newhandwelfare/config/NewhandwelfareConfig.lua

module("logic.extensions.newhandwelfare.config.NewhandwelfareConfig", package.seeall)

local NewhandwelfareConfig = class("NewhandwelfareConfig", BaseConfig)

function NewhandwelfareConfig:onInit()
	return
end

function NewhandwelfareConfig:getNames()
	return {
		"new_hand_welfare_params",
		"new_hand_welfare_sign_in_prize",
		"new_hand_welfare_online_prize",
		"new_hand_welfare_zdl_prize",
		"new_hand_welfare_golden_diamond",
		"new_hand_welfare_period",
		"new_hand_welfare_sign_in_res",
		"new_hand_welfare_jump_res",
		"new_hand_welfare_bond_prize",
		"new_hand_welfare_bond_team",
		"new_hand_welfare_privilege_view",
		"new_hand_welfare_bond_team_desc"
	}
end

function NewhandwelfareConfig:handleConfig(name, content)
	if name == "new_hand_welfare_params" then
		self._new_hand_welfare_params = content
	elseif name == "new_hand_welfare_sign_in_prize" then
		self._new_hand_welfare_sign_in_prize = content
	elseif name == "new_hand_welfare_online_prize" then
		self._new_hand_welfare_online_prize = content
	elseif name == "new_hand_welfare_zdl_prize" then
		self._new_hand_welfare_zdl_prize = content
	elseif name == "new_hand_welfare_golden_diamond" then
		self._new_hand_welfare_golden_diamond = content
	elseif name == "new_hand_welfare_period" then
		self._new_hand_welfare_period = content
	elseif name == "new_hand_welfare_sign_in_res" then
		self._new_hand_welfare_sign_in_res = content
	elseif name == "new_hand_welfare_jump_res" then
		self._new_hand_welfare_jump_res = content
	elseif name == "new_hand_welfare_bond_prize" then
		self._new_hand_welfare_bond_prize = content
	elseif name == "new_hand_welfare_bond_team" then
		self._new_hand_welfare_bond_team = content
	elseif name == "new_hand_welfare_bond_team_desc" then
		self._new_hand_welfare_bond_team_desc = content
	elseif name == "new_hand_welfare_privilege_view" then
		self._new_hand_welfare_privilege_view = content
	end
end

function NewhandwelfareConfig:getPeriodCfg(periodId)
	return self._new_hand_welfare_period[periodId]
end

function NewhandwelfareConfig:getCommonValue(key, need2number)
	if need2number then
		return checknumber(self._new_hand_welfare_params[key].value)
	else
		return self._new_hand_welfare_params[key].value
	end
end

function NewhandwelfareConfig:getNewHandActiveTime()
	if self._newhand_active_time then
		return self._newhand_active_time
	end

	local timeString = self:getCommonValue("ACTIVE_DATE")

	self._newhand_active_time = GameUtil.string2time(timeString)

	return self._newhand_active_time
end

function NewhandwelfareConfig:getOnlineRewardCfgs(periodId)
	return self._new_hand_welfare_online_prize[periodId]
end

function NewhandwelfareConfig:getOnlineRewardCfg(periodId, days)
	local result
	local cfgs = self._new_hand_welfare_online_prize[periodId]

	if cfgs then
		local maxDay = -1

		for day, cfg in pairs(cfgs) do
			if maxDay < day and day <= days then
				maxDay = day
				result = cfg
			end
		end
	end

	return result
end

function NewhandwelfareConfig:getOnlineRewardData(periodId, days, prizeId)
	local cfg = self:getOnlineRewardCfg(periodId, days)

	return cfg and cfg[prizeId]
end

function NewhandwelfareConfig:getZdlRewardCfgs(periodId)
	return self._new_hand_welfare_zdl_prize[periodId]
end

function NewhandwelfareConfig:getZdlRewardCfg(periodId, prizeId)
	return self._new_hand_welfare_zdl_prize[periodId][prizeId]
end

function NewhandwelfareConfig:getSignInRewardCfgs(periodId)
	return self._new_hand_welfare_sign_in_prize[periodId]
end

function NewhandwelfareConfig:getSignInRewardCfg(periodId, day)
	return self._new_hand_welfare_sign_in_prize[periodId][day]
end

function NewhandwelfareConfig:getGoldenDiamondCfg(itemId)
	return self._new_hand_welfare_golden_diamond[itemId]
end

function NewhandwelfareConfig:getSignInResPath(periodId, key)
	local base = self._new_hand_welfare_sign_in_res[periodId]

	if not base then
		return nil
	end

	local res = base[key]

	if not res then
		return nil
	end

	return GameUrl.getBigbgPngUrl(res.value)
end

function NewhandwelfareConfig:getJumpViewResName(periodId, index)
	local base = self._new_hand_welfare_jump_res[periodId]

	if not base then
		return nil
	end

	return base[index].name
end

function NewhandwelfareConfig:getBondPrizeCfg(periodId, bondTeamId, type)
	local cfg = {}
	local dataList = self._new_hand_welfare_bond_prize[periodId]

	if dataList then
		for _, data in ipairs(dataList) do
			if data.bondTeamId == bondTeamId and data.type == type then
				table.insert(cfg, data)
			end
		end

		table.sort(cfg, function(a, b)
			return a.prizeId < b.prizeId
		end)
	end

	return cfg
end

function NewhandwelfareConfig:getBondPrizeData(periodId, prizeId)
	if self._new_hand_welfare_bond_prize[periodId] then
		return self._new_hand_welfare_bond_prize[periodId][prizeId]
	end
end

function NewhandwelfareConfig:getBondTeamIdsInPeriod(periodId)
	local maps = {}
	local dataList = self._new_hand_welfare_bond_prize[periodId]

	if dataList then
		for _, data in ipairs(dataList) do
			maps[data.bondTeamId] = data.bondTeamId
		end
	end

	local list = TableUtil.toList(maps)

	table.sort(list, function(a, b)
		return a < b
	end)

	return list
end

function NewhandwelfareConfig:getBondTeamData(bondTeamId)
	return self._new_hand_welfare_bond_team[bondTeamId]
end

function NewhandwelfareConfig:getBondTeamDescCfg(bondTeamId)
	return self._new_hand_welfare_bond_team_desc[bondTeamId]
end

function NewhandwelfareConfig:getBondTeamDescData(bondTeamId, raceId)
	if self._new_hand_welfare_bond_team_desc[bondTeamId] then
		return self._new_hand_welfare_bond_team_desc[bondTeamId][raceId]
	end
end

function NewhandwelfareConfig:getPrivilegeViewCfgs()
	return self._new_hand_welfare_privilege_view.dataList
end

function NewhandwelfareConfig:getPrivilegeViewCfg(id)
	return self._new_hand_welfare_privilege_view[id]
end

NewhandwelfareConfig.instance = NewhandwelfareConfig.New()

return NewhandwelfareConfig
