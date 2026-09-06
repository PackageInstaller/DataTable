-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_camera.lua

module("logicconfig.config.t_camera", package.seeall)

local title = {
	focusYOffset = 6,
	yaw = 5,
	cameraDist = 3,
	id = 1,
	pitch = 4,
	fov = 2,
	focusZOffset = 7
}
local dataList = {
	{
		1,
		45,
		15,
		90,
		0,
		1.5,
		-17985
	},
	{
		2,
		15,
		0,
		20,
		90,
		87.5,
		0
	},
	{
		3,
		45,
		8.5,
		40,
		0,
		2,
		0
	},
	{
		4,
		15,
		10,
		15,
		90,
		64,
		-243
	},
	{
		5,
		15,
		-20,
		15,
		90,
		30,
		-100
	}
}
local t_camera = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5]
}

t_camera.dataList = dataList

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

return t_camera
