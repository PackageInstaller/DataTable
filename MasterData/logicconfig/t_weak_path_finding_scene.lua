-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_weak_path_finding_scene.lua

module("logicconfig.config.t_weak_path_finding_scene", package.seeall)

local title = {
	sceneId = 2,
	scenePlanId = 1,
	landingPoint = 3
}
local dataList = {
	{
		1,
		1001,
		{
			-25,
			0
		}
	},
	{
		1,
		111,
		{
			30,
			-150
		}
	},
	{
		1,
		118,
		{
			30,
			-150
		}
	}
}
local t_weak_path_finding_scene = {
	{
		[1001] = dataList[1],
		[111] = dataList[2],
		[118] = dataList[3]
	}
}

t_weak_path_finding_scene.dataList = dataList

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

return t_weak_path_finding_scene
