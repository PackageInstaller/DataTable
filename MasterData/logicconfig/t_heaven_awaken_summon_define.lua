-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_heaven_awaken_summon_define.lua

module("logicconfig.config.t_heaven_awaken_summon_define", package.seeall)

local title = {
	heavenAwakenSummonPetRaceId = 2,
	heavenAwakenMasterRaceId = 1
}
local dataList = {
	{
		16889,
		16890
	},
	{
		15032,
		15033
	}
}
local t_heaven_awaken_summon_define = {
	[16889] = {
		[16890] = dataList[1]
	},
	[15032] = {
		[15033] = dataList[2]
	}
}

t_heaven_awaken_summon_define.dataList = dataList

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

return t_heaven_awaken_summon_define
