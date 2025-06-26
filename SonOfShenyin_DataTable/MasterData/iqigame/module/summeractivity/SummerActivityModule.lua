-- chunkname: @IQIGame\\Module\\SummerActivity\\SummerActivityModule.lua

SummerActivityModule = {}

local this = SummerActivityModule

function this.GetStageCfgArray(type)
	local array = {}

	for _, v in pairs(CfgGeneralDupChapterTable) do
		if v.Type == type then
			table.insert(array, v)
		end
	end

	table.sort(array, function(a, b)
		return a.Id < b.Id
	end)

	return array
end

function this.GetStageIs(id)
	local cfgWorldMapItem = CfgUtil.GetCfgWorldMapItemDataWithID(id)
	local cfgGeneralDupChapter = CfgUtil.GetCfgGeneralDupChapterDataWithID(cfgWorldMapItem.ChapterId)

	return cfgGeneralDupChapter.Index
end

function this.EnterMingleDup(passId, fightCount, units, agentSkill)
	net_generalDup.enterMingleDup(passId, fightCount, units, agentSkill)
end
