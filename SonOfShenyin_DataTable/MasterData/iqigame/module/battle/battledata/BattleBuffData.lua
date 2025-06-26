-- chunkname: @IQIGame\\Module\\Battle\\BattleData\\BattleBuffData.lua

local BattleBuffData = {
	stack = 0,
	leftCount = 0,
	cid = 0
}

function BattleBuffData.New(cid, stack, leftCount, ext)
	local obj = Clone(BattleBuffData)

	obj:__Init(cid, stack, leftCount, ext)

	return obj
end

function BattleBuffData:__Init(cid, stack, leftCount, ext)
	self.cid = cid
	self.stack = stack
	self.leftCount = leftCount

	self:__UpdateExtValue(ext)
end

function BattleBuffData:Update(stack, leftCount, ext)
	self.stack = stack
	self.leftCount = leftCount

	self:__UpdateExtValue(ext)
end

function BattleBuffData:__UpdateExtValue(extStr)
	self.extArray = string.split(extStr, ",")
end

function BattleBuffData:GetTipsText()
	local cfgData = CfgBuffTable[self.cid]
	local tipText = UIGlobalApi.GetDescribeMatchTable(cfgData.Describe, function(_index, _formatType)
		return UIGlobalApi.AnalysisDescribeArgsWithWildcard(_formatType, self.extArray[_index])
	end)

	return tipText
end

return BattleBuffData
