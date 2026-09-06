-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/stargod/controller/StarGodBagCtrl.lua

module("logic.extensions.stargod.controller.StarGodBagCtrl", package.seeall)

local StarGodBagCtrl = class("StarGodBagCtrl", BaseController)

function StarGodBagCtrl:onInit()
	return
end

function StarGodBagCtrl:oneKeyFusion(isRed)
	StarGodAgent.instance:sendAutoStarGodFusionReq(isRed)
end

function StarGodBagCtrl:collectStarGod(starGodId, isCollect)
	StarGodAgent.instance:sendCollectStarGodOrNotReq(starGodId, isCollect)
end

function StarGodBagCtrl:setAutoCombineState(isRed, state)
	StarGodAgent.instance:sendSaveAutoFusionStateReq(isRed, state)
end

function StarGodBagCtrl:freeStarGodFusion(masterStarGodId, slaveIds)
	StarGodAgent.instance:sendFreeStarGodFusionReq(masterStarGodId, slaveIds)
end

function StarGodBagCtrl:replacePetStarGod(petId, starGodId, slotId)
	StarGodAgent.instance:sendFreeStarGodLickUpPetStarGodReq(petId, starGodId, slotId)
end

function StarGodBagCtrl:petStarGodFusion(petId, slotId, starGodIds)
	StarGodAgent.instance:sendPetStarGodLickUpFreeStarGodReq(petId, slotId, starGodIds)
end

function StarGodBagCtrl:equipStarGod(petId, starGodId, slotId)
	StarGodAgent:sendEquipStarGodReq(petId, starGodId, slotId)
end

function StarGodBagCtrl:doEquipLogic(idx)
	local defineId, level, exp = StarGodModel.instance:getPetStarGod(idx)
	local selectId = StarGodModel.instance:getEquipingStarGod()

	if defineId > 0 then
		local sCfg = StarGodConfig.instance:getCfgByDefineId(defineId)
		local info = StarGodModel.instance:getUsualInfos(selectId)

		TipsFacade.instance:openPopupWindow(lang("tip"), langPara("stargod_replace", info.name .. " Lv" .. info.level, sCfg.name .. " Lv" .. level) .. "\n\n" .. langPara("stargod_swallow", info.name .. " Lv" .. info.level, sCfg.name .. " Lv" .. level, exp + sCfg.baseExp), function()
			StarGodBagCtrl.instance:replacePetStarGod(StarGodModel.instance:getPetId(), selectId, idx - 1)
		end)
	else
		StarGodBagCtrl.instance:equipStarGod(StarGodModel.instance:getPetId(), StarGodModel.instance:getEquipingStarGod(), idx - 1)
	end
end

function StarGodBagCtrl:calcLevelExpByFusion(level, oriExp, defineId, slaveIds)
	local maxLevel = self:GetMaxLevel()
	local exp = oriExp + self:_calcTotalExp(slaveIds)

	for i = level, maxLevel do
		local lvCfg = StarGodConfig.instance:getLevelConfig(defineId, i)

		if lvCfg ~= nil and exp >= lvCfg.exp then
			level = i
		end
	end

	return level, exp
end

function StarGodBagCtrl:willMaxLevel(level, oriExp, defineId, slaveIds)
	return self:calcLevelExpByFusion(level, oriExp, defineId, slaveIds) >= self:GetMaxLevel()
end

function StarGodBagCtrl:GetMaxLevel()
	return 6
end

function StarGodBagCtrl:_getExpAndLvExp(defineId, exp)
	local maxLevel = self:GetMaxLevel()
	local curExp = 0
	local preExp = 0
	local levelExp = 0
	local lvCfg
	local level = 1

	for i = 1, maxLevel do
		lvCfg = StarGodConfig.instance:getLevelConfig(defineId, i)

		if lvCfg ~= nil and exp >= lvCfg.exp then
			level = i
			preExp = lvCfg.exp
		end
	end

	if lvCfg ~= nil then
		if level == maxLevel then
			levelExp = preExp - StarGodConfig.instance:getLevelConfig(defineId, level - 1).exp
			curExp = levelExp
		else
			levelExp = StarGodConfig.instance:getLevelConfig(defineId, level + 1).exp - preExp
			curExp = exp - preExp
		end
	end

	return curExp, levelExp
end

function StarGodBagCtrl:_calcTotalExp(ids)
	local exp = 0

	for i, v in ipairs(ids) do
		exp = exp + self:_calcExp(v)
	end

	return exp
end

function StarGodBagCtrl:_calcExp(id)
	local info = StarGodModel.instance:getUsualInfos(id)

	return info.exp + info.baseExp
end

function StarGodBagCtrl:sortDataByQulityAndLevel(data)
	table.sort(data, function(x, y)
		if not x.defineId then
			return false
		end

		if not y.defineId then
			return true
		end

		local xCfg = StarGodConfig.instance:getCfgByDefineId(x.defineId)
		local yCfg = StarGodConfig.instance:getCfgByDefineId(y.defineId)

		if xCfg.quality == yCfg.quality then
			return x.levelId > y.levelId
		else
			return xCfg.quality > yCfg.quality
		end
	end)
end

function StarGodBagCtrl:sortDataByQulityAndLevelForStarUnit(data)
	table.sort(data, function(x, y)
		if not x.defineId then
			return false
		end

		if not y.defineId then
			return true
		end

		local xCfg = StarGodConfig.instance:getCfgByDefineId(x.defineId)
		local yCfg = StarGodConfig.instance:getCfgByDefineId(y.defineId)

		if xCfg.quality == yCfg.quality then
			if x.defineId == y.defineId then
				return x.levelId > y.levelId
			else
				return x.defineId > y.defineId
			end
		else
			return xCfg.quality > yCfg.quality
		end
	end)
end

function StarGodBagCtrl:sortDataByChoice(data, choice)
	if choice == 1 then
		table.sort(data, function(x, y)
			if not x.defineId then
				return false
			end

			if not y.defineId then
				return true
			end

			local xCfg = StarGodConfig.instance:getCfgByDefineId(x.defineId)
			local yCfg = StarGodConfig.instance:getCfgByDefineId(y.defineId)

			if xCfg.quality == yCfg.quality then
				return x.id > y.id
			end

			return xCfg.quality > yCfg.quality
		end)
	elseif choice == 2 then
		table.sort(data, function(x, y)
			if not x.defineId then
				return false
			end

			if not y.defineId then
				return true
			end

			local xCfg = StarGodConfig.instance:getCfgByDefineId(x.defineId)
			local yCfg = StarGodConfig.instance:getCfgByDefineId(y.defineId)

			if xCfg.quality == yCfg.quality then
				return x.id > y.id
			end

			return xCfg.quality < yCfg.quality
		end)
	elseif choice == 3 then
		table.sort(data, function(x, y)
			if not x.defineId then
				return false
			end

			if not y.defineId then
				return true
			end

			if x.levelId == y.levelId then
				return x.id > y.id
			end

			return x.levelId > y.levelId
		end)
	else
		table.sort(data, function(x, y)
			if not x.defineId then
				return false
			end

			if not y.defineId then
				return true
			end

			if x.levelId == y.levelId then
				return x.id > y.id
			end

			return x.levelId < y.levelId
		end)
	end
end

StarGodBagCtrl.instance = StarGodBagCtrl.New()

return StarGodBagCtrl
