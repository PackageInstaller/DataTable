-- chunkname: @modules/logic/summon/helper/SummonPoolSortHelper.lua

module("modules.logic.summon.helper.SummonPoolSortHelper", package.seeall)

local SummonPoolSortHelper = class("SummonPoolSortHelper")
local __G__TRACKBACK__ = __G__TRACKBACK__
local xpcall = xpcall

function SummonPoolSortHelper.getPoolPriority(co)
	if not co then
		return 0
	end

	SummonPoolSortHelper._conditionFuncDic = SummonPoolSortHelper._conditionFuncDic or {
		SummonPoolSortHelper._pcriorityCond1,
		SummonPoolSortHelper._pcriorityCond2,
		SummonPoolSortHelper._pcriorityCond3,
		SummonPoolSortHelper._pcriorityCond4,
		SummonPoolSortHelper._pcriorityCond5,
		SummonPoolSortHelper._pcriorityCond6
	}

	local func = SummonPoolSortHelper._conditionFuncDic[co.priorityType]

	if func then
		local isOk, result = xpcall(func, __G__TRACKBACK__, co)

		if isOk and result then
			return co.specialPriority
		end

		if not isOk then
			logError(string.format("卡池优先排序条件错误，id:%s priorityType:%s", co.id, co.priorityType))
		end
	end

	return co.priority
end

function SummonPoolSortHelper._pcriorityCond1(co)
	return SummonPoolSortHelper._checkRRSHerosMaxByStr(co.upWeight, true)
end

function SummonPoolSortHelper._pcriorityCond2(co)
	return SummonPoolSortHelper._checkRRSHerosMaxByStr(co.param)
end

function SummonPoolSortHelper._pcriorityCond3(co)
	return SummonPoolSortHelper._checkRRSHerosMaxByStr(co.param2)
end

function SummonPoolSortHelper._pcriorityCond4(co)
	local rare2Cfg = SummonConfig.instance:getSummon(co.id)
	local summonCfg = rare2Cfg and rare2Cfg[EffectivenessConfig.HeroRareRareEnum.SSR]

	if summonCfg then
		return SummonPoolSortHelper._checkRRSHerosMaxByStr(summonCfg.summonId)
	end

	return false
end

function SummonPoolSortHelper._pcriorityCond5(co)
	local poolMO = SummonMainModel.instance:getPoolServerMO(co.id)

	if not poolMO then
		return false
	end

	local customPickMO = poolMO.customPickMO

	if customPickMO and SummonPoolSortHelper._checkAllHerosMaxIds(customPickMO.pickHeroIds) then
		return true
	end

	return false
end

function SummonPoolSortHelper._pcriorityCond6(co)
	if SummonMainModel.getADPageTabIndex(co) == SummonEnum.TabContentIndex.CharNewbie then
		if SummonMainModel.instance:isNewbiePoolGetReward() then
			return true
		end

		return false
	end

	return false
end

function SummonPoolSortHelper._checkRRSHerosMaxByStr(str, isSplitStr2)
	if not string.nilorempty(str) then
		local heroIds

		if isSplitStr2 == true then
			local nums = GameUtil.splitString2(str, true)

			if nums and #nums > 0 then
				heroIds = {}

				for i = 1, #nums do
					tabletool.addValues(heroIds, nums[i])
				end
			end
		else
			heroIds = string.splitToNumber(str, "#")
		end

		if heroIds and #heroIds > 0 then
			local tHeroConfig = HeroConfig.instance
			local targetRare = EffectivenessConfig.HeroRareRareEnum.SSR

			for i = #heroIds, 1, -1 do
				local cfg = tHeroConfig:getHeroCO(heroIds[i])

				if not cfg or targetRare and cfg.rare ~= targetRare then
					table.remove(heroIds, i)
				end
			end

			return SummonPoolSortHelper._checkAllHerosMaxIds(heroIds)
		end
	end

	return false
end

function SummonPoolSortHelper._checkAllHerosMaxIds(heroIds)
	if heroIds and #heroIds > 0 then
		local tSummonModel = SummonModel.instance

		for i = 1, #heroIds do
			if not tSummonModel:isFullExSkillHeroById(heroIds[i]) then
				return false
			end
		end

		return true
	end

	return false
end

return SummonPoolSortHelper
