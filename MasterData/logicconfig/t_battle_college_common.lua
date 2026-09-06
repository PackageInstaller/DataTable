-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_battle_college_common.lua

module("logicconfig.config.t_battle_college_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"GetTitleDesc",
		"战术教室更新啦！使用格兰特的精灵进行考验，完美通关光系阵容，即可获得【高阶训练师】称号！"
	}
}
local t_battle_college_common = {
	GetTitleDesc = dataList[1]
}

t_battle_college_common.dataList = dataList

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

return t_battle_college_common
