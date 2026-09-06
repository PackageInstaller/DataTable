-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_breach_form_master_defense_buff.lua

module("logicconfig.config.t_breach_form_master_defense_buff", package.seeall)

local title = {
	defenseBuffPlanId = 1,
	buffs = 4,
	buffId = 2,
	zdl = 3
}
local dataList = {
	{
		1,
		1,
		0,
		{
			{
				clazz = "Common",
				target = "enemy",
				params = {
					buffs = "20073101:99#20073102:99#20073137:99"
				}
			}
		}
	},
	{
		1,
		2,
		800000,
		{
			{
				clazz = "Common",
				target = "enemy",
				params = {
					buffs = "20073103:99#20073104:99#20073137:99"
				}
			}
		}
	},
	{
		1,
		3,
		900000,
		{
			{
				clazz = "Common",
				target = "enemy",
				params = {
					buffs = "20073105:99#20073106:99#20073137:99"
				}
			}
		}
	},
	{
		1,
		4,
		1000000,
		{
			{
				clazz = "Common",
				target = "enemy",
				params = {
					buffs = "20073107:99#20073108:99#20073137:99"
				}
			}
		}
	},
	{
		1,
		5,
		1100000,
		{
			{
				clazz = "Common",
				target = "enemy",
				params = {
					buffs = "20073109:99#20073110:99#20073137:99"
				}
			}
		}
	},
	{
		1,
		6,
		1200000,
		{
			{
				clazz = "Common",
				target = "enemy",
				params = {
					buffs = "20073111:99#20073112:99#20073137:99"
				}
			}
		}
	},
	{
		1,
		7,
		1300000,
		{
			{
				clazz = "Common",
				target = "enemy",
				params = {
					buffs = "20073113:99#20073114:99#20073137:99"
				}
			}
		}
	},
	{
		1,
		8,
		1400000,
		{
			{
				clazz = "Common",
				target = "enemy",
				params = {
					buffs = "20073115:99#20073116:99#20073137:99"
				}
			}
		}
	},
	{
		1,
		9,
		1500000,
		{
			{
				clazz = "Common",
				target = "enemy",
				params = {
					buffs = "20073117:99#20073118:99#20073137:99"
				}
			}
		}
	},
	{
		1,
		10,
		1600000,
		{
			{
				clazz = "Common",
				target = "enemy",
				params = {
					buffs = "20073119:99#20073120:99#20073137:99"
				}
			}
		}
	},
	{
		1,
		11,
		1700000,
		{
			{
				clazz = "Common",
				target = "enemy",
				params = {
					buffs = "20073121:99#20073122:99#20073137:99"
				}
			}
		}
	},
	{
		1,
		12,
		1800000,
		{
			{
				clazz = "Common",
				target = "enemy",
				params = {
					buffs = "20073123:99#20073124:99#20073137:99"
				}
			}
		}
	},
	{
		1,
		13,
		1900000,
		{
			{
				clazz = "Common",
				target = "enemy",
				params = {
					buffs = "20073125:99#20073126:99#20073137:99"
				}
			}
		}
	},
	{
		1,
		14,
		2000000,
		{
			{
				clazz = "Common",
				target = "enemy",
				params = {
					buffs = "20073127:99#20073128:99#20073137:99"
				}
			}
		}
	},
	{
		1,
		15,
		2100000,
		{
			{
				clazz = "Common",
				target = "enemy",
				params = {
					buffs = "20073129:99#20073130:99#20073137:99"
				}
			}
		}
	},
	{
		1,
		16,
		2200000,
		{
			{
				clazz = "Common",
				target = "enemy",
				params = {
					buffs = "20073131:99#20073132:99#20073137:99"
				}
			}
		}
	},
	{
		1,
		17,
		2300000,
		{
			{
				clazz = "Common",
				target = "enemy",
				params = {
					buffs = "20073133:99#20073134:99#20073137:99"
				}
			}
		}
	},
	{
		1,
		18,
		2400000,
		{
			{
				clazz = "Common",
				target = "enemy",
				params = {
					buffs = "20073135:99#20073136:99#20073137:99"
				}
			}
		}
	},
	{
		1,
		19,
		2500000,
		{
			{
				clazz = "Common",
				target = "enemy",
				params = {
					buffs = ""
				}
			}
		}
	}
}
local t_breach_form_master_defense_buff = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16],
		dataList[17],
		dataList[18],
		dataList[19]
	}
}

t_breach_form_master_defense_buff.dataList = dataList

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

return t_breach_form_master_defense_buff
