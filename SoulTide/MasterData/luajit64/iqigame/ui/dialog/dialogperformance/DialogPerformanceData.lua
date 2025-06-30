-- chunkname: @IQIGame\\UI\\Dialog\\DialogPerformance\\DialogPerformanceData.lua

local m = {
	Completed = false,
	Type = 0,
	CID = 0
}

function m.New(gameObject, cfgPerformanceData)
	local obj = Clone(m)

	obj.gameObject = gameObject
	obj.CID = cfgPerformanceData.Id
	obj.CfgData = cfgPerformanceData
	obj.Type = cfgPerformanceData.PerformanceType
	obj.Completed = false

	return obj
end

return m
