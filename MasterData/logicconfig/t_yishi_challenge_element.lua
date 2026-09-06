-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_yishi_challenge_element.lua

module("logicconfig.config.t_yishi_challenge_element", package.seeall)

local title = {
	type = 2,
	name = 1
}
local dataList = {
	{
		"草",
		1
	},
	{
		"水",
		2
	},
	{
		"火",
		3
	},
	{
		"光",
		4
	},
	{
		"暗",
		5
	},
	{
		"空",
		6
	},
	{
		"创",
		7
	}
}
local t_yishi_challenge_element = {
	草 = dataList[1],
	水 = dataList[2],
	火 = dataList[3],
	光 = dataList[4],
	暗 = dataList[5],
	空 = dataList[6],
	创 = dataList[7]
}

t_yishi_challenge_element.dataList = dataList

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

return t_yishi_challenge_element
