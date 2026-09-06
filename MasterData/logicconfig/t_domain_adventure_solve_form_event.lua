-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_domain_adventure_solve_form_event.lua

module("logicconfig.config.t_domain_adventure_solve_form_event", package.seeall)

local title = {
	challengeId = 2,
	activityId = 1,
	pos = 7,
	skinId = 6,
	creepsMasterId = 3,
	scale = 8,
	prize = 4,
	systemPoolId = 5
}
local dataList = {
	{
		402001,
		2001,
		2001,
		"10:402001:10",
		2001,
		10097,
		[8] = {
			0.1,
			0.1,
			0.1
		}
	},
	{
		402001,
		2002,
		2002,
		"10:402001:10",
		2002,
		10101,
		[8] = {
			0.1,
			0.1,
			0.1
		}
	},
	{
		402001,
		2003,
		2003,
		"10:402001:10",
		2003,
		10334,
		[8] = {
			0.1,
			0.1,
			0.1
		}
	},
	{
		402001,
		2004,
		2004,
		"10:402001:10",
		2004,
		10070,
		[8] = {
			0.1,
			0.1,
			0.1
		}
	},
	{
		402001,
		2005,
		2005,
		"10:402001:10",
		2005,
		16006,
		[8] = {
			0.1,
			0.1,
			0.1
		}
	},
	{
		402001,
		2006,
		2006,
		"10:402001:10",
		2006,
		10342,
		[8] = {
			0.1,
			0.1,
			0.1
		}
	},
	{
		402001,
		2007,
		2007,
		"10:402001:10",
		2007,
		10332,
		[8] = {
			0.1,
			0.1,
			0.1
		}
	},
	{
		402001,
		2008,
		2008,
		"10:402001:10",
		2008,
		10142,
		[8] = {
			0.1,
			0.1,
			0.1
		}
	},
	{
		402001,
		2009,
		2009,
		"10:402001:10",
		2009,
		10360,
		[8] = {
			0.1,
			0.1,
			0.1
		}
	},
	{
		402001,
		2010,
		2010,
		"10:402001:10",
		2010,
		16008,
		[8] = {
			0.1,
			0.1,
			0.1
		}
	},
	{
		402001,
		2011,
		2011,
		"10:402001:10",
		2011,
		16002,
		[8] = {
			0.1,
			0.1,
			0.1
		}
	},
	{
		402001,
		2012,
		2012,
		"10:402001:10",
		2012,
		10313,
		[8] = {
			0.1,
			0.1,
			0.1
		}
	}
}
local t_domain_adventure_solve_form_event = {
	[402001] = {
		[2001] = dataList[1],
		[2002] = dataList[2],
		[2003] = dataList[3],
		[2004] = dataList[4],
		[2005] = dataList[5],
		[2006] = dataList[6],
		[2007] = dataList[7],
		[2008] = dataList[8],
		[2009] = dataList[9],
		[2010] = dataList[10],
		[2011] = dataList[11],
		[2012] = dataList[12]
	}
}

t_domain_adventure_solve_form_event.dataList = dataList

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

return t_domain_adventure_solve_form_event
