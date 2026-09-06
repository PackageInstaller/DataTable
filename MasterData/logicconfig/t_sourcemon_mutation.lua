-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_sourcemon_mutation.lua

module("logicconfig.config.t_sourcemon_mutation", package.seeall)

local title = {
	mutateTypeId = 1,
	mutatedZdls = 3,
	propDesc = 5,
	mutateProps = 2,
	desc = 4
}
local dataList = {}
local t_sourcemon_mutation = {}

t_sourcemon_mutation.dataList = dataList

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

return t_sourcemon_mutation
