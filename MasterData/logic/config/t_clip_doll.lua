-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_clip_doll.lua

module("logic.config.t_clip_doll", package.seeall)

local title = {
	speed = 4,
	rewardlst = 5,
	coinId = 3,
	dolls = 2,
	code = 1
}
local dataList = {
	{
		80001,
		"{1012001:5,1012003:4,1012002:1,1012004:1,1012005:3,1012006:4,1012007:3,1012008:4,1012009:3,1012011:2,1012012:1,1012013:1,1012014:1,1012015:1}",
		1100017,
		1,
		{
			2280015,
			2280016,
			2280017
		}
	}
}
local t_clip_doll = {}

t_clip_doll.dataList = dataList

local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			return rawget(t, index)
		else
			error(string.format("the field name [%s] is nonexist!", key))
		end
	end
}

for i, v in ipairs(dataList) do
	t_clip_doll[v[1]] = v

	setmetatable(v, mt)
end

return t_clip_doll
