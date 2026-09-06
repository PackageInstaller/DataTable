-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_feedback_reply.lua

module("logicconfig.config.t_feedback_reply", package.seeall)

local title = {
	id = 1,
	reply = 3,
	desc = 2
}
local dataList = {
	{
		1,
		82001309,
		82001294
	},
	{
		2,
		82001310,
		82001296
	}
}
local t_feedback_reply = {
	dataList[1],
	dataList[2]
}

t_feedback_reply.dataList = dataList

local multiLanguageCells = {
	reply = true,
	desc = true
}
local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			local value = rawget(t, index)

			if multiLanguageCells[key] then
				value = lang(value)
			end

			return value
		else
			printWarn(string.format("the field name [%s] is nonexist!", key))
		end
	end
}

for i, v in ipairs(dataList) do
	setmetatable(v, mt)
end

return t_feedback_reply
