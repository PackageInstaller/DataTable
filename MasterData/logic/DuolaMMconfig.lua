-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/duolamengmeng/config/DuolaMMconfig.lua

module(..., package.seeall)

local DuolaMMconfig = class("DuolaMMconfig", BaseConfig)

function DuolaMMconfig:onInit()
	return
end

function DuolaMMconfig:getNames()
	return {
		"duo_la_mm_common",
		"duo_la_mm_drop_plan",
		"duo_la_mm_piece",
		"duo_la_mm_game_buy_times",
		"duo_la_mm_game_plan"
	}
end

function DuolaMMconfig:handleConfig(name, content)
	if name == "duo_la_mm_common" then
		self._commonCfg = content
	elseif name == "duo_la_mm_drop_plan" then
		self._dropPlan = content
	elseif name == "duo_la_mm_piece" then
		self._piece = content
	elseif name == "duo_la_mm_game_buy_times" then
		self._buyTime = content
	elseif name == "duo_la_mm_game_plan" then
		self._gamePlan = content
	end
end

function DuolaMMconfig:getCommonCfg(key)
	local res = self._commonCfg[key]

	if res then
		return res.value
	else
		return nil
	end
end

function DuolaMMconfig:getBuyTimesCfg(planId, type)
	return self._buyTime[planId][type]
end

function DuolaMMconfig:getGameCfg(gameId)
	return self._gamePlan[gameId]
end

function DuolaMMconfig:getDropPlanCfg()
	return self._dropPlan
end

function DuolaMMconfig:getPieceCfgById(id)
	return self._piece[id]
end

function DuolaMMconfig:getPieceCfg()
	return self._piece.dataList
end

DuolaMMconfig.instance = DuolaMMconfig.New()

return DuolaMMconfig
