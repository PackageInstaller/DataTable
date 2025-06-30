-- chunkname: @IQIGame\\Module\\Chapter\\ChapterModule.lua

ChapterModule = {}

local this = ChapterModule

function this.GetCfgChapterDataWithType(dupTagId)
	local resultTable = {}
	local cfgDupTag = CfgUtil.GetCfgDupTagDataWithID(dupTagId)
	local cfg = {}

	if cfgDupTag.DupType == Constant.ChapterPassType.TYPE_RESOURCES then
		cfg = CfgDailyDupChapterTable
	elseif cfgDupTag.DupType == Constant.ChapterPassType.TYPE_EQUIP then
		cfg = CfgEquipDupChapterTable
	elseif cfgDupTag.DupType == Constant.ChapterPassType.TYPE_BOSS then
		cfg = CfgBossChapterTable
	elseif cfgDupTag.DupType == Constant.ChapterPassType.TYPE_CLIMB_TOWER then
		cfg = CfgTowerChapterTable
	end

	for i, v in pairsCfg(cfg) do
		if #cfgDupTag.FilterIds > 0 then
			if table.indexOf(cfgDupTag.FilterIds, i) ~= -1 then
				table.insert(resultTable, v)
			end
		else
			table.insert(resultTable, v)
		end
	end

	table.sort(resultTable, function(a, b)
		return a.Index < b.Index
	end)

	return resultTable
end
