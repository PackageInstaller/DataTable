-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_zoo_scene_config.lua

module("logicconfig.config.t_zoo_scene_config", package.seeall)

local title = {
	assetPath = 2,
	birthPoint = 3,
	sceneId = 1
}
local dataList = {
	{
		1,
		"scene/configs/mengchongyuan_01/mengchongyuan_01.txt",
		{
			58,
			32
		}
	}
}
local t_zoo_scene_config = {
	dataList[1]
}

t_zoo_scene_config.dataList = dataList

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

return t_zoo_scene_config
