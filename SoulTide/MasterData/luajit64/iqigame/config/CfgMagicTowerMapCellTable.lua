-- chunkname: @IQIGame\\Config\\CfgMagicTowerMapCellTable.lua

local CfgMagicTowerMapCellTable = {
	{
		Id = 1,
		DataList = {
			1
		}
	},
	{
		Id = 2,
		DataList = {
			2
		}
	},
	{
		Id = 3,
		DataList = {
			3
		}
	},
	{
		Id = 4,
		DataList = {
			4
		}
	},
	{
		Id = 5,
		DataList = {
			5
		}
	},
	{
		Id = 6,
		DataList = {
			6
		}
	},
	{
		Id = 7,
		DataList = {
			7
		}
	},
	[101] = {
		Id = 101,
		DataList = {
			300101,
			300201,
			300301,
			800001
		}
	},
	[102] = {
		Id = 102,
		DataList = {
			300102,
			300202,
			300302,
			800001
		}
	},
	[103] = {
		Id = 103,
		DataList = {
			300103,
			300203,
			300303,
			800002
		}
	},
	[104] = {
		Id = 104,
		DataList = {
			300104,
			300204,
			300304,
			800002
		}
	},
	[105] = {
		Id = 105,
		DataList = {
			300105,
			300205,
			300305,
			800003
		}
	},
	[106] = {
		Id = 106,
		DataList = {
			300101,
			300201
		}
	},
	[107] = {
		Id = 107,
		DataList = {
			300102,
			300202,
			300302
		}
	},
	[108] = {
		Id = 108,
		DataList = {
			300103,
			300203,
			300303
		}
	},
	[109] = {
		Id = 109,
		DataList = {
			300104,
			300204,
			300304
		}
	},
	[110] = {
		Id = 110,
		DataList = {
			300105,
			300205,
			300305
		}
	},
	[201] = {
		Id = 201,
		DataList = {
			600101
		}
	},
	[202] = {
		Id = 202,
		DataList = {
			600102
		}
	},
	[203] = {
		Id = 203,
		DataList = {
			600103
		}
	},
	[204] = {
		Id = 204,
		DataList = {
			600104
		}
	},
	[205] = {
		Id = 205,
		DataList = {
			600105
		}
	},
	[301] = {
		Id = 301,
		DataList = {
			600201
		}
	},
	[302] = {
		Id = 302,
		DataList = {
			600202
		}
	},
	[303] = {
		Id = 303,
		DataList = {
			600203
		}
	},
	[304] = {
		Id = 304,
		DataList = {
			600204
		}
	},
	[305] = {
		Id = 305,
		DataList = {
			600205
		}
	},
	[401] = {
		Id = 401,
		DataList = {
			100101,
			100102,
			100103
		}
	},
	[402] = {
		Id = 402,
		DataList = {
			100201,
			100202,
			100203
		}
	},
	[403] = {
		Id = 403,
		DataList = {
			100301,
			100302,
			100303
		}
	},
	[404] = {
		Id = 404,
		DataList = {
			100401,
			100402,
			100403
		}
	},
	[405] = {
		Id = 405,
		DataList = {
			100501,
			100502,
			100503
		}
	},
	[406] = {
		Id = 406,
		DataList = {
			100601,
			100602,
			100603
		}
	},
	[407] = {
		Id = 407,
		DataList = {
			100701,
			100702,
			100703
		}
	},
	[408] = {
		Id = 408,
		DataList = {
			100801,
			100802,
			100803
		}
	},
	[409] = {
		Id = 409,
		DataList = {
			100901,
			100902,
			100903
		}
	},
	[410] = {
		Id = 410,
		DataList = {
			101001,
			101002,
			101003
		}
	},
	[411] = {
		Id = 411,
		DataList = {
			101101,
			101102,
			101103
		}
	},
	[412] = {
		Id = 412,
		DataList = {
			101201,
			101202,
			101203
		}
	},
	[501] = {
		Id = 501,
		DataList = {
			100201
		}
	},
	[601] = {
		Id = 601,
		DataList = {
			400001
		}
	},
	[701] = {
		Id = 701,
		DataList = {
			300401,
			300501,
			300601
		}
	},
	[702] = {
		Id = 702,
		DataList = {
			300402,
			300502,
			300602
		}
	},
	[703] = {
		Id = 703,
		DataList = {
			300403,
			300503,
			300603
		}
	}
}

setmetatable(CfgMagicTowerMapCellTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgMagicTowerMapCellTable]")
	end
})

local defaultMetaTable = {
	__index = {
		DataList = {}
	}
}

for i, data in pairs(CfgMagicTowerMapCellTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgMagicTowerMapCellTable
