-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_md_spine_spine_params.lua

module("logicconfig.config.t_md_spine_spine_params", package.seeall)

local title = {
	spineParamDicId = 3,
	min = 5,
	targetName = 4,
	spineParamId = 2,
	skinPlanId = 1,
	max = 6
}
local dataList = {}
local t_md_spine_spine_params = {}

t_md_spine_spine_params.dataList = dataList

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

return t_md_spine_spine_params
