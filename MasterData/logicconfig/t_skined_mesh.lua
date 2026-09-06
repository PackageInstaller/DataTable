-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_skined_mesh.lua

module("logicconfig.config.t_skined_mesh", package.seeall)

local title = {
	id = 1,
	gender = 5,
	cover = 6,
	type = 2,
	asset = 4,
	icon = 3
}
local dataList = {
	{
		20001,
		2,
		"",
		"70002_aoqinv_huanxiangtao_face",
		0
	},
	{
		20002,
		2,
		"",
		"99999_aoqinan_xiaoaoqi_face",
		1
	},
	{
		30001,
		3,
		"",
		"70002_aoqinv_huanxiangtao_hair",
		0
	},
	{
		30002,
		3,
		"",
		"99999_aoqinan_xiaoaoqi_hair",
		1
	},
	{
		40001,
		4,
		"",
		"70002_aoqinv_huanxiangtao_top",
		0
	},
	{
		40002,
		4,
		"",
		"99999_aoqinan_xiaoaoqi_top",
		1
	},
	{
		50002,
		5,
		"",
		"99999_aoqinan_xiaoaoqi_pants",
		1
	},
	{
		60001,
		6,
		"",
		"70002_aoqinv_huanxiangtao_shoes",
		0
	},
	{
		60002,
		6,
		"",
		"99999_aoqinan_xiaoaoqi_shoes",
		1
	},
	{
		70001,
		7,
		"",
		"70002_aoqinv_huanxiangtao_arm",
		0
	},
	{
		70002,
		7,
		"",
		"99999_aoqinan_xiaoaoqi_arm",
		1
	}
}
local t_skined_mesh = {
	[20001] = dataList[1],
	[20002] = dataList[2],
	[30001] = dataList[3],
	[30002] = dataList[4],
	[40001] = dataList[5],
	[40002] = dataList[6],
	[50002] = dataList[7],
	[60001] = dataList[8],
	[60002] = dataList[9],
	[70001] = dataList[10],
	[70002] = dataList[11]
}

t_skined_mesh.dataList = dataList

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

return t_skined_mesh
