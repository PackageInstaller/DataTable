-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_oracle_define.lua

module("logicconfig.config.t_oracle_define", package.seeall)

local title = {
	oraclePetRaceId = 2,
	oracleMasterRaceId = 1
}
local dataList = {
	{
		16888,
		16889
	},
	{
		14023,
		15024
	},
	{
		14023,
		15014
	},
	{
		14023,
		17011
	},
	{
		14023,
		17009
	},
	{
		14023,
		15019
	},
	{
		14023,
		16018
	},
	{
		14023,
		16023
	},
	{
		14023,
		11023
	},
	{
		14023,
		14030
	},
	{
		14023,
		16028
	},
	{
		14023,
		12026
	},
	{
		14023,
		11028
	},
	{
		14023,
		16039
	},
	{
		14023,
		12037
	},
	{
		14023,
		14036
	},
	{
		14023,
		17024
	},
	{
		14023,
		15041
	},
	{
		14023,
		16044
	},
	{
		14023,
		17026
	},
	{
		14023,
		15049
	},
	{
		14038,
		15024
	},
	{
		14038,
		15014
	},
	{
		14038,
		17011
	},
	{
		14038,
		17009
	},
	{
		14038,
		15019
	},
	{
		14038,
		16018
	},
	{
		14038,
		16023
	},
	{
		14038,
		11023
	},
	{
		14038,
		14030
	},
	{
		14038,
		16028
	},
	{
		14038,
		12026
	},
	{
		14038,
		11028
	},
	{
		14038,
		16039
	},
	{
		14038,
		12037
	},
	{
		14038,
		14036
	},
	{
		14038,
		17024
	},
	{
		14038,
		15041
	},
	{
		14038,
		16044
	},
	{
		14038,
		17026
	},
	{
		14038,
		15049
	}
}
local t_oracle_define = {
	[16888] = {
		[16889] = dataList[1]
	},
	[14023] = {
		[15024] = dataList[2],
		[15014] = dataList[3],
		[17011] = dataList[4],
		[17009] = dataList[5],
		[15019] = dataList[6],
		[16018] = dataList[7],
		[16023] = dataList[8],
		[11023] = dataList[9],
		[14030] = dataList[10],
		[16028] = dataList[11],
		[12026] = dataList[12],
		[11028] = dataList[13],
		[16039] = dataList[14],
		[12037] = dataList[15],
		[14036] = dataList[16],
		[17024] = dataList[17],
		[15041] = dataList[18],
		[16044] = dataList[19],
		[17026] = dataList[20],
		[15049] = dataList[21]
	},
	[14038] = {
		[15024] = dataList[22],
		[15014] = dataList[23],
		[17011] = dataList[24],
		[17009] = dataList[25],
		[15019] = dataList[26],
		[16018] = dataList[27],
		[16023] = dataList[28],
		[11023] = dataList[29],
		[14030] = dataList[30],
		[16028] = dataList[31],
		[12026] = dataList[32],
		[11028] = dataList[33],
		[16039] = dataList[34],
		[12037] = dataList[35],
		[14036] = dataList[36],
		[17024] = dataList[37],
		[15041] = dataList[38],
		[16044] = dataList[39],
		[17026] = dataList[40],
		[15049] = dataList[41]
	}
}

t_oracle_define.dataList = dataList

local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			return rawget(t, index)
		end
	end
}

for i, v in ipairs(dataList) do
	setmetatable(v, mt)
end

return t_oracle_define
