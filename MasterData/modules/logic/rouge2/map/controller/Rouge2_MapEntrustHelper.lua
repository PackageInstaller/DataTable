-- chunkname: @modules/logic/rouge2/map/controller/Rouge2_MapEntrustHelper.lua

module("modules.logic.rouge2.map.controller.Rouge2_MapEntrustHelper", package.seeall)

local Rouge2_MapEntrustHelper = class("Rouge2_MapEntrustHelper")

function Rouge2_MapEntrustHelper.initEntrustDescHandle()
	if Rouge2_MapEntrustHelper.entrustTypeHandleDict ~= nil then
		return
	end

	Rouge2_MapEntrustHelper.entrustTypeHandleDict = {
		[Rouge2_MapEnum.EntrustEventType.MakeMoney] = Rouge2_MapEntrustHelper.makeMoneyHandle,
		[Rouge2_MapEnum.EntrustEventType.CostMoney] = Rouge2_MapEntrustHelper.costMoneyHandle,
		[Rouge2_MapEnum.EntrustEventType.Event] = Rouge2_MapEntrustHelper.eventHandle,
		[Rouge2_MapEnum.EntrustEventType.PassLayer] = Rouge2_MapEntrustHelper.passLayerHandle,
		[Rouge2_MapEnum.EntrustEventType.GetRelics] = Rouge2_MapEntrustHelper.getRelicsHandle,
		[Rouge2_MapEnum.EntrustEventType.GetRelicsNum] = Rouge2_MapEntrustHelper.getRelicsNumHandle,
		[Rouge2_MapEnum.EntrustEventType.GetRareRelics] = Rouge2_MapEntrustHelper.getRareRelicsHandle,
		[Rouge2_MapEnum.EntrustEventType.GetRareBuff] = Rouge2_MapEntrustHelper.getRareBuffHandle,
		[Rouge2_MapEnum.EntrustEventType.GetBuffNum] = Rouge2_MapEntrustHelper.getBuffNumHandle,
		[Rouge2_MapEnum.EntrustEventType.KillEnemy] = Rouge2_MapEntrustHelper.killEnemyHandle,
		[Rouge2_MapEnum.EntrustEventType.GetAttribute] = Rouge2_MapEntrustHelper.getAttributeHandle,
		[Rouge2_MapEnum.EntrustEventType.CheckSuccNum] = Rouge2_MapEntrustHelper.checkSuccNumHandle,
		[Rouge2_MapEnum.EntrustEventType.StealStore] = Rouge2_MapEntrustHelper.stealStoreHandle,
		[Rouge2_MapEnum.EntrustEventType.MakeRevivalCoin] = Rouge2_MapEntrustHelper.makeRevivalCoinHandle,
		[Rouge2_MapEnum.EntrustEventType.NotUpdateCount] = Rouge2_MapEntrustHelper.notUpdateCountHandle
	}
end

function Rouge2_MapEntrustHelper.getEntrustDesc(entrustMo)
	Rouge2_MapEntrustHelper.initEntrustDescHandle()

	local entrustId = entrustMo and entrustMo:getEntrustId()
	local entrustCo = lua_rouge2_entrust.configDict[entrustId]
	local entrustType = entrustCo and entrustCo.type
	local entrustDescCo = lua_rouge2_entrust_desc.configDict[entrustType]

	if not entrustCo or not entrustDescCo then
		logError(string.format("肉鸽委托配置不存在 entrustId = %s, entrustType = %s", entrustId, entrustType))

		return
	end

	local func = Rouge2_MapEntrustHelper.entrustTypeHandleDict[entrustType]

	if not func then
		logError("肉鸽缺少委托显示回调方法 entrustId = %s, entrustType = %s", entrustId, entrustType)

		return
	end

	local finish = entrustMo:isFinish()
	local progress = entrustMo:getProgress()

	return func(entrustCo, entrustDescCo, progress, finish)
end

function Rouge2_MapEntrustHelper.makeMoneyHandle(entrustCo, entrustDescCo, progress, finish)
	local cost = tonumber(entrustCo.param)
	local desc = Rouge2_MapEntrustHelper.getDesc(entrustDescCo, finish)

	return GameUtil.getSubPlaceholderLuaLangTwoParam(desc, cost, progress)
end

function Rouge2_MapEntrustHelper.costMoneyHandle(entrustCo, entrustDescCo, progress, finish)
	local cost = tonumber(entrustCo.param)
	local desc = Rouge2_MapEntrustHelper.getDesc(entrustDescCo, finish)

	return GameUtil.getSubPlaceholderLuaLangTwoParam(desc, cost, progress)
end

function Rouge2_MapEntrustHelper.eventHandle(entrustCo, entrustDescCo, progress, finish)
	local param = string.split(entrustCo.param, "|")
	local typeList = string.splitToNumber(param[1], "#")

	for i = 1, #typeList do
		typeList[i] = lua_rouge2_event_type.configDict[typeList[i]].name
	end

	local total = tonumber(param[2])
	local desc = Rouge2_MapEntrustHelper.getDesc(entrustDescCo, finish)

	return GameUtil.getSubPlaceholderLuaLangThreeParam(desc, total, table.concat(typeList, "/"), progress)
end

function Rouge2_MapEntrustHelper.passLayerHandle(entrustCo, entrustDescCo, progress, finish)
	return entrustDescCo.desc
end

function Rouge2_MapEntrustHelper.finishEventHandle(entrustCo, entrustDescCo, progress, finish)
	local desc = Rouge2_MapEntrustHelper.getDesc(entrustDescCo, finish)
	local eventId = tonumber(entrustCo.param)
	local eventCo = Rouge2_MapConfig.instance:getRougeEvent(eventId)

	return GameUtil.getSubPlaceholderLuaLangOneParam(desc, eventCo.name)
end

function Rouge2_MapEntrustHelper.getRelicsHandle(entrustCo, entrustDescCo, progress, finish)
	if finish then
		if not entrustCo.resultDesc then
			local desc = entrustCo.desc

			return GameUtil.getSubPlaceholderLuaLangOneParam(desc, progress)
		end
	end
end

function Rouge2_MapEntrustHelper.getRelicsNumHandle(entrustCo, entrustDescCo, progress, finish)
	local count = tonumber(entrustCo.param)
	local desc = Rouge2_MapEntrustHelper.getDesc(entrustDescCo, finish)

	return GameUtil.getSubPlaceholderLuaLangTwoParam(desc, count, progress)
end

function Rouge2_MapEntrustHelper.getRareRelicsHandle(entrustCo, entrustDescCo, progress, finish)
	local paramList = string.splitToNumber(entrustCo.param, "|")

	if paramList then
		if not paramList[1] then
			local count = 0

			if paramList then
				if not paramList[2] then
					local rareId = 0
					local rareName = Rouge2_CollectionConfig.instance:getRareName(rareId)
					local desc = Rouge2_MapEntrustHelper.getDesc(entrustDescCo, finish)

					return GameUtil.getSubPlaceholderLuaLangThreeParam(desc, count, rareName, progress)
				end
			end
		end
	end
end

function Rouge2_MapEntrustHelper.getRareBuffHandle(entrustCo, entrustDescCo, progress, finish)
	local paramList = string.splitToNumber(entrustCo.param, "|")

	if paramList then
		if not paramList[1] then
			local count = 0

			if paramList then
				if not paramList[2] then
					local rareId = 0
					local rareName = Rouge2_CollectionConfig.instance:getRareName(rareId)
					local desc = Rouge2_MapEntrustHelper.getDesc(entrustDescCo, finish)

					return GameUtil.getSubPlaceholderLuaLangThreeParam(desc, count, rareName, progress)
				end
			end
		end
	end
end

function Rouge2_MapEntrustHelper.getBuffNumHandle(entrustCo, entrustDescCo, progress, finish)
	local count = tonumber(entrustCo.param)
	local desc = Rouge2_MapEntrustHelper.getDesc(entrustDescCo, finish)

	return GameUtil.getSubPlaceholderLuaLangTwoParam(desc, count, progress)
end

function Rouge2_MapEntrustHelper.killEnemyHandle(entrustCo, entrustDescCo, progress, finish)
	local count = tonumber(entrustCo.param)
	local desc = Rouge2_MapEntrustHelper.getDesc(entrustDescCo, finish)

	return GameUtil.getSubPlaceholderLuaLangTwoParam(desc, count, progress)
end

function Rouge2_MapEntrustHelper.getAttributeHandle(entrustCo, entrustDescCo, progress, finish)
	local paramList = string.splitToNumber(entrustCo.param, "|")

	if paramList then
		if not paramList[1] then
			local count = 0

			if paramList then
				if not paramList[2] then
					local attributeId = 0
					local attributeCo = Rouge2_AttributeConfig.instance:getAttributeConfig(attributeId)
					local attributeName = attributeCo and attributeCo.name
					local desc = Rouge2_MapEntrustHelper.getDesc(entrustDescCo, finish)

					return GameUtil.getSubPlaceholderLuaLangThreeParam(desc, count, attributeName, progress)
				end
			end
		end
	end
end

function Rouge2_MapEntrustHelper.checkSuccNumHandle(entrustCo, entrustDescCo, progress, finish)
	local count = tonumber(entrustCo.param)
	local desc = Rouge2_MapEntrustHelper.getDesc(entrustDescCo, finish)

	return GameUtil.getSubPlaceholderLuaLangTwoParam(desc, count, progress)
end

function Rouge2_MapEntrustHelper.stealStoreHandle(entrustCo, entrustDescCo, progress, finish)
	local count = tonumber(entrustCo.param)
	local desc = Rouge2_MapEntrustHelper.getDesc(entrustDescCo, finish)

	return GameUtil.getSubPlaceholderLuaLangTwoParam(desc, count, progress)
end

function Rouge2_MapEntrustHelper.makeRevivalCoinHandle(entrustCo, entrustDescCo, progress, finish)
	local count = tonumber(entrustCo.param)
	local desc = Rouge2_MapEntrustHelper.getDesc(entrustDescCo, finish)

	return GameUtil.getSubPlaceholderLuaLangTwoParam(desc, count, progress)
end

function Rouge2_MapEntrustHelper.costReviveCoinHandle(entrustCo, entrustDescCo, progress, finish)
	local count = tonumber(entrustCo.param)
	local desc = Rouge2_MapEntrustHelper.getDesc(entrustDescCo, finish)

	return GameUtil.getSubPlaceholderLuaLangTwoParam(desc, count, progress)
end

function Rouge2_MapEntrustHelper.notUpdateCountHandle(entrustCo, entrustDescCo, progress, finish)
	if finish then
		if not entrustCo.resultDesc then
			local desc = entrustCo.desc

			return GameUtil.getSubPlaceholderLuaLangOneParam(desc, progress)
		end
	end
end

function Rouge2_MapEntrustHelper.getDesc(co, finish)
	return (finish or nil) and (co.finishDesc or co.desc)
end

return Rouge2_MapEntrustHelper
