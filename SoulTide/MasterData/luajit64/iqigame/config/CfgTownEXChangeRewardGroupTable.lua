-- chunkname: @IQIGame\\Config\\CfgTownEXChangeRewardGroupTable.lua

local CfgTownEXChangeRewardGroupTable = {
	[1002] = {
		Id = 1002
	},
	[1003] = {
		Id = 1003
	},
	[1004] = {
		Id = 1004
	},
	[1005] = {
		Id = 1005
	},
	[1006] = {
		Id = 1006
	},
	[1007] = {
		Id = 1007
	},
	[1008] = {
		Id = 1008
	},
	[1009] = {
		Id = 1009
	},
	[1010] = {
		Id = 1010
	},
	[1011] = {
		Id = 1011
	},
	[1012] = {
		Id = 1012
	},
	[1013] = {
		Id = 1013
	},
	[1014] = {
		Id = 1014
	},
	[1015] = {
		Id = 1015
	},
	[1016] = {
		Id = 1016
	},
	[2001] = {
		Id = 2001
	},
	[2002] = {
		Id = 2002
	},
	[2003] = {
		Id = 2003
	},
	[2004] = {
		Id = 2004
	},
	[2005] = {
		Id = 2005
	},
	[2006] = {
		Id = 2006
	},
	[2007] = {
		Id = 2007
	},
	[2008] = {
		Id = 2008
	},
	[2009] = {
		Id = 2009
	},
	[2010] = {
		Id = 2010
	},
	[2011] = {
		Id = 2011
	},
	[2012] = {
		Id = 2012
	},
	[2013] = {
		Id = 2013
	},
	[2014] = {
		Id = 2014
	},
	[2015] = {
		Id = 2015
	},
	[2016] = {
		Id = 2016
	},
	[2017] = {
		Id = 2017
	},
	[2018] = {
		Id = 2018
	},
	[2019] = {
		Id = 2019
	},
	[2020] = {
		Id = 2020
	},
	[2021] = {
		Id = 2021
	},
	[2022] = {
		Id = 2022
	},
	[2023] = {
		Id = 2023
	},
	[2024] = {
		Id = 2024
	},
	[2025] = {
		Id = 2025
	},
	[2026] = {
		Id = 2026
	},
	[2027] = {
		Id = 2027
	},
	[2028] = {
		Id = 2028
	},
	[2029] = {
		Id = 2029
	},
	[2030] = {
		Id = 2030
	}
}

setmetatable(CfgTownEXChangeRewardGroupTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgTownEXChangeRewardGroupTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Item = {}
	}
}

for i, data in pairs(CfgTownEXChangeRewardGroupTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgTownEXChangeRewardGroupTable
