-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_saintknight_tian_serverbuff.lua

module("logicconfig.config.t_saintknight_tian_serverbuff", package.seeall)

local title = {
	selfBuff = 4,
	buffPlanId = 1,
	days = 3,
	id = 2,
	des = 5
}
local dataList = {
	{
		1,
		1,
		14,
		"5230:99#5231:99",
		"己阵全属性+<color=#20b376>200%</color>及生命上限+<color=#20b376>200%</color>"
	}
}
local t_saintknight_tian_serverbuff = {
	dataList[1]
}

t_saintknight_tian_serverbuff.dataList = dataList

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

return t_saintknight_tian_serverbuff
