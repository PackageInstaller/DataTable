-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_script_killing_scene.lua

module("logicconfig.config.t_script_killing_scene", package.seeall)

local title = {
	sceneId = 2,
	activityId = 1,
	chapterId = 3
}
local dataList = {
	{
		365001,
		1,
		1
	},
	{
		365001,
		2,
		2
	},
	{
		365001,
		3,
		3
	},
	{
		365002,
		1,
		1
	},
	{
		365002,
		2,
		1
	},
	{
		365003,
		1,
		1
	},
	{
		365003,
		2,
		2
	},
	{
		365003,
		3,
		3
	}
}
local t_script_killing_scene = {
	[365001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	},
	[365002] = {
		dataList[4],
		dataList[5]
	},
	[365003] = {
		dataList[6],
		dataList[7],
		dataList[8]
	}
}

t_script_killing_scene.dataList = dataList

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

return t_script_killing_scene
