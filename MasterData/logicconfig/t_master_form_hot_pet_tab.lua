-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_master_form_hot_pet_tab.lua

module("logicconfig.config.t_master_form_hot_pet_tab", package.seeall)

local title = {
	index = 2,
	name = 4,
	raceId = 3,
	hotPetPlanId = 1
}
local dataList = {
	{
		1,
		1,
		{
			11042,
			11041,
			13031,
			18031,
			13026,
			12046,
			15050,
			14049,
			14040,
			14044,
			16044,
			16042,
			16041,
			13029,
			13027,
			14046,
			18021,
			16043,
			17029,
			13024
		},
		"出场率前20精灵"
	}
}
local t_master_form_hot_pet_tab = {
	{
		dataList[1]
	}
}

t_master_form_hot_pet_tab.dataList = dataList

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

return t_master_form_hot_pet_tab
