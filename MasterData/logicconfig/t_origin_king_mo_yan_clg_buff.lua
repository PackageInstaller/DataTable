-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_king_mo_yan_clg_buff.lua

module("logicconfig.config.t_origin_king_mo_yan_clg_buff", package.seeall)

local title = {
	formCondition = 5,
	itemCount = 4,
	buffId = 3,
	type = 2,
	unitPos = 6,
	activityId = 1,
	desc = 7
}
local dataList = {
	{
		559001,
		1,
		1,
		1,
		0,
		{
			1
		},
		"心莲-1：附着精灵每次出手令敌阵攻击力最高的精灵获得30气势"
	},
	{
		559001,
		1,
		2,
		2,
		0,
		{
			2
		},
		"心莲-2：附着精灵每次出手令敌阵攻击力最高的精灵获得30气势"
	},
	{
		559001,
		1,
		3,
		3,
		0,
		{
			3
		},
		"心莲-3：附着精灵每次出手令敌阵攻击力最高的精灵获得30气势"
	},
	{
		559001,
		1,
		4,
		4,
		0,
		{
			4
		},
		"心莲-4：附着精灵每次出手令敌阵攻击力最高的精灵获得30气势"
	},
	{
		559001,
		1,
		5,
		5,
		0,
		{
			5
		},
		"心莲-5：附着精灵每次出手令敌阵攻击力最高的精灵获得30气势"
	},
	{
		559001,
		1,
		6,
		6,
		0,
		{
			6
		},
		"心莲-6：附着精灵每次出手令敌阵攻击力最高的精灵获得30气势"
	},
	{
		559001,
		2,
		1,
		1,
		37,
		nil,
		"炽火-1：至少上阵1位火属性精灵"
	},
	{
		559001,
		2,
		2,
		2,
		38,
		nil,
		"炽火-2：至少上阵2位火属性精灵"
	},
	{
		559001,
		2,
		3,
		3,
		39,
		nil,
		"炽火-3：至少上阵3位火属性精灵"
	},
	{
		559001,
		2,
		4,
		4,
		56,
		nil,
		"炽火-4：至少上阵4位火属性精灵"
	},
	{
		559001,
		2,
		5,
		5,
		221,
		nil,
		"炽火-5：至少上阵5位火属性精灵"
	},
	{
		559001,
		2,
		6,
		6,
		222,
		nil,
		"炽火-6：至少上阵6位火属性精灵"
	},
	{
		559001,
		3,
		1,
		1,
		0,
		{
			1
		},
		"炽莲-1：附着精灵每次出手令敌阵站位最后的精灵获得50气势和一次立即出手（立即出手每位精灵每个大回合限3次），且自身首次受到致命伤害时重生，恢复50%生命并获得50气势"
	},
	{
		559001,
		3,
		2,
		2,
		0,
		{
			2
		},
		"炽莲-1：附着精灵每次出手令敌阵站位最后的精灵获得50气势和一次立即出手（立即出手每位精灵每个大回合限3次），且自身首次受到致命伤害时重生，恢复50%生命并获得50气势"
	},
	{
		559001,
		3,
		3,
		3,
		0,
		{
			3
		},
		"炽莲-1：附着精灵每次出手令敌阵站位最后的精灵获得50气势和一次立即出手（立即出手每位精灵每个大回合限3次），且自身首次受到致命伤害时重生，恢复50%生命并获得50气势"
	},
	{
		559001,
		3,
		4,
		4,
		0,
		{
			4
		},
		"炽莲-1：附着精灵每次出手令敌阵站位最后的精灵获得50气势和一次立即出手（立即出手每位精灵每个大回合限3次），且自身首次受到致命伤害时重生，恢复50%生命并获得50气势"
	},
	{
		559001,
		3,
		5,
		5,
		0,
		{
			5
		},
		"炽莲-1：附着精灵每次出手令敌阵站位最后的精灵获得50气势和一次立即出手（立即出手每位精灵每个大回合限3次），且自身首次受到致命伤害时重生，恢复50%生命并获得50气势"
	},
	{
		559001,
		3,
		6,
		6,
		0,
		{
			6
		},
		"炽莲-1：附着精灵每次出手令敌阵站位最后的精灵获得50气势和一次立即出手（立即出手每位精灵每个大回合限3次），且自身首次受到致命伤害时重生，恢复50%生命并获得50气势"
	}
}
local t_origin_king_mo_yan_clg_buff = {
	[559001] = {
		{
			dataList[1],
			dataList[2],
			dataList[3],
			dataList[4],
			dataList[5],
			dataList[6]
		},
		{
			dataList[7],
			dataList[8],
			dataList[9],
			dataList[10],
			dataList[11],
			dataList[12]
		},
		{
			dataList[13],
			dataList[14],
			dataList[15],
			dataList[16],
			dataList[17],
			dataList[18]
		}
	}
}

t_origin_king_mo_yan_clg_buff.dataList = dataList

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

return t_origin_king_mo_yan_clg_buff
