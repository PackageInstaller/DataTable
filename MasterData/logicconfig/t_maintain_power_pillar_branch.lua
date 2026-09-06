-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_maintain_power_pillar_branch.lua

module("logicconfig.config.t_maintain_power_pillar_branch", package.seeall)

local title = {
	eventId = 1
}
local dataList = {
	{
		9101
	},
	{
		9102
	},
	{
		9103
	},
	{
		9104
	},
	{
		9105
	}
}
local t_maintain_power_pillar_branch = {
	[9101] = dataList[1],
	[9102] = dataList[2],
	[9103] = dataList[3],
	[9104] = dataList[4],
	[9105] = dataList[5]
}

t_maintain_power_pillar_branch.dataList = dataList

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

return t_maintain_power_pillar_branch
