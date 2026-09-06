-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_skillbuffaffix.lua

module("logicconfig.config.t_skillbuffaffix", package.seeall)

local title = {
	id = 1,
	buffs = 2
}
local dataList = {
	{
		110001,
		{
			buffs = {
				{
					turnTimes = 2,
					addOccasion = 1,
					buffId = 10,
					target = 1
				}
			}
		}
	},
	{
		110002,
		{
			buffs = {
				{
					turnTimes = 2,
					addOccasion = 1,
					buffId = 11,
					target = 1
				}
			}
		}
	},
	{
		110003,
		{
			buffs = {
				{
					turnTimes = 2,
					addOccasion = 1,
					buffId = 12,
					target = 1
				}
			}
		}
	},
	{
		110004,
		{
			buffs = {
				{
					turnTimes = 2,
					addOccasion = 1,
					buffId = 14,
					target = 1
				}
			}
		}
	},
	{
		110005,
		{
			buffs = {
				{
					turnTimes = 1,
					addOccasion = 4,
					buffId = 2,
					target = 2
				}
			}
		}
	},
	{
		110006,
		{
			buffs = {
				{
					turnTimes = 5,
					addOccasion = 1,
					buffId = 3,
					target = 1
				}
			}
		}
	},
	{
		110007,
		{
			buffs = {
				{
					turnTimes = 2,
					addOccasion = 1,
					buffId = 9,
					target = 1
				}
			}
		}
	},
	{
		110008,
		{
			buffs = {
				{
					turnTimes = 2,
					addOccasion = 1,
					buffId = 6,
					target = 1
				},
				{
					turnTimes = 2,
					addOccasion = 4,
					buffId = 4,
					target = 1
				}
			}
		}
	},
	{
		110009,
		{
			buffs = {
				{
					turnTimes = 2,
					addOccasion = 1,
					buffId = 16,
					target = 1
				}
			}
		}
	},
	{
		110010,
		{
			buffs = {
				{
					turnTimes = 2,
					addOccasion = 1,
					buffId = 17,
					target = 1
				}
			}
		}
	},
	{
		110011,
		{
			buffs = {
				{
					turnTimes = 2,
					addOccasion = 1,
					buffId = 20,
					target = 1
				}
			}
		}
	},
	{
		110013,
		{
			buffs = {
				{
					turnTimes = 2,
					addOccasion = 1,
					buffId = 22,
					target = 1
				}
			}
		}
	},
	{
		210002,
		{
			buffs = {
				{
					turnTimes = 1,
					addOccasion = 2,
					buffId = 1,
					target = 2
				}
			}
		}
	},
	{
		210003,
		{
			buffs = {
				{
					turnTimes = 1,
					addOccasion = 2,
					buffId = 1,
					target = 2
				}
			}
		}
	},
	{
		210004,
		{
			buffs = {
				{
					turnTimes = 2,
					addOccasion = 1,
					buffId = 15,
					target = 1
				},
				{
					turnTimes = 1,
					addOccasion = 1,
					buffId = 19,
					target = 1
				}
			}
		}
	},
	{
		210005,
		{
			buffs = {
				{
					turnTimes = 1,
					addOccasion = 4,
					buffId = 2,
					target = 2
				}
			}
		}
	},
	{
		210006,
		{
			buffs = {
				{
					turnTimes = 5,
					addOccasion = 1,
					buffId = 3,
					target = 1
				}
			}
		}
	},
	{
		210007,
		{
			buffs = {
				{
					turnTimes = 2,
					addOccasion = 1,
					buffId = 8,
					target = 1
				}
			}
		}
	},
	{
		210008,
		{
			buffs = {
				{
					turnTimes = 3,
					addOccasion = 1,
					buffId = 6,
					target = 1
				},
				{
					turnTimes = 2,
					addOccasion = 4,
					buffId = 5,
					target = 1
				}
			}
		}
	},
	{
		210009,
		{
			buffs = {
				{
					turnTimes = 2,
					addOccasion = 1,
					buffId = 16,
					target = 1
				},
				{
					turnTimes = 2,
					addOccasion = 1,
					buffId = 18,
					target = 1
				}
			}
		}
	},
	{
		210010,
		{
			buffs = {
				{
					turnTimes = 2,
					addOccasion = 1,
					buffId = 17,
					target = 1
				},
				{
					turnTimes = 2,
					addOccasion = 1,
					buffId = 18,
					target = 1
				}
			}
		}
	},
	{
		210011,
		{
			buffs = {
				{
					turnTimes = 2,
					addOccasion = 1,
					buffId = 21,
					target = 1
				}
			}
		}
	},
	{
		210013,
		{
			buffs = {
				{
					turnTimes = 2,
					addOccasion = 1,
					buffId = 23,
					target = 1
				}
			}
		}
	}
}
local t_skillbuffaffix = {
	[110001] = dataList[1],
	[110002] = dataList[2],
	[110003] = dataList[3],
	[110004] = dataList[4],
	[110005] = dataList[5],
	[110006] = dataList[6],
	[110007] = dataList[7],
	[110008] = dataList[8],
	[110009] = dataList[9],
	[110010] = dataList[10],
	[110011] = dataList[11],
	[110013] = dataList[12],
	[210002] = dataList[13],
	[210003] = dataList[14],
	[210004] = dataList[15],
	[210005] = dataList[16],
	[210006] = dataList[17],
	[210007] = dataList[18],
	[210008] = dataList[19],
	[210009] = dataList[20],
	[210010] = dataList[21],
	[210011] = dataList[22],
	[210013] = dataList[23]
}

t_skillbuffaffix.dataList = dataList

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

return t_skillbuffaffix
