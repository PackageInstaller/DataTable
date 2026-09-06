-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_btl_source_skill_effect.lua

module("logicconfig.config.t_btl_source_skill_effect", package.seeall)

local title = {
	sourceSkillId = 1,
	name = 2,
	effectBuffId = 3,
	raceId = 4
}
local dataList = {
	{
		51688801,
		"本源技1",
		11009632,
		{
			16888
		}
	},
	{
		618021,
		"斐希司本源技",
		18021604,
		{
			18021
		}
	}
}
local t_btl_source_skill_effect = {
	[51688801] = dataList[1],
	[618021] = dataList[2]
}

t_btl_source_skill_effect.dataList = dataList

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

return t_btl_source_skill_effect
