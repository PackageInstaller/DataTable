-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_bullet_screen.lua

module("logicconfig.config.t_bullet_screen", package.seeall)

local title = {
	key = 2,
	time = 5,
	subKey = 3,
	id = 1,
	content = 4
}
local dataList = {
	{
		1,
		"1",
		"1",
		"你好啊~",
		2
	},
	{
		2,
		"1",
		"1",
		"我很好~",
		4
	},
	{
		3,
		"1",
		"1",
		"( ＾∀＾）／欢迎＼( ＾∀＾）",
		0.5
	},
	{
		4,
		"1",
		"1",
		"(｀д′) (￣^￣) 哼！ <(｀^′)>",
		0.8
	},
	{
		5,
		"1",
		"1",
		"o(*￣︶￣*)o",
		2
	},
	{
		6,
		"1",
		"1",
		"我很好~",
		3
	},
	{
		7,
		"1",
		"1",
		"｡:.ﾟヽ(｡◕‿◕｡)ﾉﾟ.:｡+ﾟ",
		6
	},
	{
		8,
		"1",
		"1",
		"(。┰ω┰。",
		7
	}
}
local t_bullet_screen = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8]
}

t_bullet_screen.dataList = dataList

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

return t_bullet_screen
