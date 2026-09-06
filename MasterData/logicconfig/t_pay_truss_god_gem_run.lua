-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pay_truss_god_gem_run.lua

module("logicconfig.config.t_pay_truss_god_gem_run", package.seeall)

local title = {
	viewName = 2,
	activityId = 1,
	firstRedId = 3
}
local dataList = {
	{
		120001,
		"fashionshowskinsalegodgemview",
		"-194"
	},
	{
		120002,
		"fashionshowskinsalegodgemview",
		""
	},
	{
		120003,
		"fashionshowskinsalegodgemview",
		"o8"
	},
	{
		120004,
		"fashionshowskinsalegodgemview",
		""
	},
	{
		120006,
		"fashionshowskinsalegodgemview",
		""
	},
	{
		120007,
		"fashionshowskinsalegodgemview",
		""
	},
	{
		120008,
		"fashionshowskinsalegodgemview",
		""
	},
	{
		120009,
		"fashionshowskinsalegodgemview",
		""
	},
	{
		120010,
		"fashionshowskinsalegodgemview",
		""
	},
	{
		120011,
		"fashionshowskinsalegodgemview",
		""
	},
	{
		120012,
		"fashionshowskinsalegodgemview",
		""
	},
	{
		120013,
		"fashionshowskinsalegodgemview",
		""
	},
	{
		120014,
		"fashionshowskinsalegodgemview",
		"-194"
	},
	{
		120015,
		"fashionshowskinsalegodgemview",
		"-194"
	},
	{
		120017,
		"fashionshowskinsalegodgemview",
		"-194"
	},
	{
		120018,
		"fashionshowskinsalegodgemview",
		"-194"
	},
	{
		120019,
		"fashionshowskinsalegodgemview",
		"-194"
	},
	{
		120020,
		"fashionshowskinsalegodgemview",
		"-194"
	},
	{
		120021,
		"fashionshowskinsalegodgemview",
		"-194"
	},
	{
		120022,
		"giftpacksalegodgemview",
		"-194"
	},
	{
		120023,
		"fashionshowskinsalegodgemview",
		"-194"
	}
}
local t_pay_truss_god_gem_run = {
	[120001] = dataList[1],
	[120002] = dataList[2],
	[120003] = dataList[3],
	[120004] = dataList[4],
	[120006] = dataList[5],
	[120007] = dataList[6],
	[120008] = dataList[7],
	[120009] = dataList[8],
	[120010] = dataList[9],
	[120011] = dataList[10],
	[120012] = dataList[11],
	[120013] = dataList[12],
	[120014] = dataList[13],
	[120015] = dataList[14],
	[120017] = dataList[15],
	[120018] = dataList[16],
	[120019] = dataList[17],
	[120020] = dataList[18],
	[120021] = dataList[19],
	[120022] = dataList[20],
	[120023] = dataList[21]
}

t_pay_truss_god_gem_run.dataList = dataList

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

return t_pay_truss_god_gem_run
