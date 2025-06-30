-- chunkname: @IQIGame\\Config\\CfgAmusementParkAnswerControlTable.lua

local CfgAmusementParkAnswerControlTable = {
	{
		Group = 1,
		CoolDownTime = 30,
		Id = 1,
		Reward = {
			2,
			10
		},
		QuestionBank = {
			1,
			2,
			3,
			4,
			5,
			6,
			7,
			8,
			9,
			10,
			11,
			12,
			13,
			14,
			15,
			16,
			17,
			18,
			19,
			20,
			21,
			22,
			23,
			24,
			25,
			26,
			27,
			28,
			29,
			30,
			31,
			32,
			33,
			34,
			35,
			36,
			37,
			38,
			39,
			40,
			41,
			42,
			43,
			44,
			45,
			46,
			47,
			48,
			49,
			50,
			51,
			52,
			53,
			54,
			55,
			56,
			57,
			58,
			59,
			60
		}
	}
}

setmetatable(CfgAmusementParkAnswerControlTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgAmusementParkAnswerControlTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Group = 0,
		CoolDownTime = 0,
		QuestionBank = {},
		Reward = {}
	}
}

for i, data in pairs(CfgAmusementParkAnswerControlTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgAmusementParkAnswerControlTable
