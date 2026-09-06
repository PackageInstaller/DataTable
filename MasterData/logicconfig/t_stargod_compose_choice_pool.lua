-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_stargod_compose_choice_pool.lua

module("logicconfig.config.t_stargod_compose_choice_pool", package.seeall)

local title = {
	equipmentId = 2,
	poolId = 1
}
local dataList = {
	{
		34011,
		401
	},
	{
		34011,
		402
	},
	{
		34011,
		403
	},
	{
		34011,
		404
	},
	{
		34011,
		405
	},
	{
		34011,
		406
	},
	{
		34011,
		407
	},
	{
		34011,
		408
	},
	{
		34011,
		409
	},
	{
		34021,
		410
	},
	{
		34031,
		601
	},
	{
		34031,
		602
	},
	{
		34031,
		603
	},
	{
		34031,
		604
	},
	{
		34031,
		605
	},
	{
		34031,
		606
	},
	{
		34031,
		607
	},
	{
		34031,
		608
	},
	{
		34031,
		609
	}
}
local t_stargod_compose_choice_pool = {
	[34011] = {
		[401] = dataList[1],
		[402] = dataList[2],
		[403] = dataList[3],
		[404] = dataList[4],
		[405] = dataList[5],
		[406] = dataList[6],
		[407] = dataList[7],
		[408] = dataList[8],
		[409] = dataList[9]
	},
	[34021] = {
		[410] = dataList[10]
	},
	[34031] = {
		[601] = dataList[11],
		[602] = dataList[12],
		[603] = dataList[13],
		[604] = dataList[14],
		[605] = dataList[15],
		[606] = dataList[16],
		[607] = dataList[17],
		[608] = dataList[18],
		[609] = dataList[19]
	}
}

t_stargod_compose_choice_pool.dataList = dataList

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

return t_stargod_compose_choice_pool
