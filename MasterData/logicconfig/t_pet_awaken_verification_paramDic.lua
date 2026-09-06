-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pet_awaken_verification_paramDic.lua

module("logicconfig.config.t_pet_awaken_verification_paramDic", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"xingjiangview",
		"115003#1"
	},
	{
		"endlessdragonview",
		"115004#1"
	},
	{
		"jisummoner",
		"115004#2"
	}
}
local t_pet_awaken_verification_paramDic = {
	xingjiangview = dataList[1],
	endlessdragonview = dataList[2],
	jisummoner = dataList[3]
}

t_pet_awaken_verification_paramDic.dataList = dataList

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

return t_pet_awaken_verification_paramDic
