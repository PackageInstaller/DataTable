-- chunkname: @IQIGame\\Config\\CfgLunaBattleLineGlobalTable.lua

local CfgLunaBattleLineGlobalTable = {
	{
		Id = 1,
		Name = getI18NValue(180149038),
		Desc = getI18NValue(180149037),
		Quest = {
			10241101,
			10241102,
			10241201,
			10241301,
			10241308,
			10241313,
			10241318,
			10241323,
			10241328,
			10241333,
			10241338,
			10241343,
			10241348,
			10241401
		},
		MallGoods = {
			1040101001,
			1040101002,
			1040101003,
			1040101004,
			1040101005,
			1040101006,
			1040101007,
			1040101008,
			1040101009,
			1040101010,
			1040101011,
			1040101012
		},
		RemoveItems = {
			203
		},
		Zone = {
			1,
			2,
			3,
			4,
			5,
			6,
			7
		}
	}
}

setmetatable(CfgLunaBattleLineGlobalTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgLunaBattleLineGlobalTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Name = "",
		BackGround = "",
		Desc = "",
		MallGoods = {},
		Zone = {},
		RemoveItems = {},
		Quest = {}
	}
}

for i, data in pairs(CfgLunaBattleLineGlobalTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgLunaBattleLineGlobalTable
