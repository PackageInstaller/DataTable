-- chunkname: @IQIGame\\Config\\CfgGalgameMonsterAttributeTable.lua

local CfgGalgameMonsterAttributeTable = {
	[301] = {
		Group = 1,
		Type = 1,
		Id = 301,
		Icon = "/Activity/MonsterAcademy/Batch1/MonsterAcademyCommonUI/MonsterAcademyPlayer_Image_01.png",
		SubType = 1,
		Name = getI18NValue(180846948),
		Describe = getI18NValue(180846947)
	},
	[302] = {
		Group = 1,
		Type = 1,
		Id = 302,
		Icon = "/Activity/MonsterAcademy/Batch1/MonsterAcademyCommonUI/MonsterAcademyPlayer_Image_04.png",
		SubType = 1,
		Name = getI18NValue(180846950),
		Describe = getI18NValue(180846949)
	},
	[303] = {
		Group = 1,
		Type = 1,
		Id = 303,
		Icon = "/Activity/MonsterAcademy/Batch1/MonsterAcademyCommonUI/MonsterAcademyPlayer_Image_03.png",
		SubType = 1,
		Name = getI18NValue(180846952),
		Describe = getI18NValue(180846951)
	},
	[304] = {
		Group = 1,
		Type = 1,
		Id = 304,
		Icon = "/Activity/MonsterAcademy/Batch1/MonsterAcademyCommonUI/MonsterAcademyPlayer_Image_02.png",
		SubType = 2,
		Name = getI18NValue(180846954),
		Describe = getI18NValue(180846953)
	},
	[201] = {
		Group = 4,
		Type = 1,
		Id = 201,
		Icon = "/Activity/MonsterAcademy/Batch1/MonsterAcademyCommonUI/MonsterAcademyPlayer_Image_05.png",
		SubType = 1,
		Name = getI18NValue(180520889),
		Describe = getI18NValue(180520888)
	},
	[202] = {
		Group = 4,
		Type = 1,
		Id = 202,
		Icon = "/Activity/MonsterAcademy/Batch1/MonsterAcademyCommonUI/MonsterAcademyPlayer_Image_06.png",
		SubType = 1,
		Name = getI18NValue(180520891),
		Describe = getI18NValue(180520890)
	},
	[203] = {
		Group = 4,
		Type = 1,
		Id = 203,
		Icon = "/Activity/MonsterAcademy/Batch1/MonsterAcademyCommonUI/MonsterAcademyPlayer_Image_03.png",
		SubType = 1,
		Name = getI18NValue(180520893),
		Describe = getI18NValue(180520892)
	},
	[204] = {
		Group = 4,
		Type = 1,
		Id = 204,
		Icon = "/Activity/MonsterAcademy/Batch1/MonsterAcademyCommonUI/MonsterAcademyPlayer_Image_04.png",
		SubType = 2,
		Name = getI18NValue(180520895),
		Describe = getI18NValue(180520894)
	},
	[101] = {
		Group = 3,
		Type = 1,
		Id = 101,
		Icon = "/Activity/MonsterAcademy/Batch1/MonsterAcademyCommonUI/MonsterAcademyPlayer_Image_01.png",
		SubType = 1,
		Name = getI18NValue(180432694),
		Describe = getI18NValue(180432693)
	},
	[102] = {
		Group = 3,
		Type = 1,
		Id = 102,
		Icon = "/Activity/MonsterAcademy/Batch1/MonsterAcademyCommonUI/MonsterAcademyPlayer_Image_04.png",
		SubType = 1,
		Name = getI18NValue(180432696),
		Describe = getI18NValue(180432695)
	},
	[103] = {
		Group = 3,
		Type = 1,
		Id = 103,
		Icon = "/Activity/MonsterAcademy/Batch1/MonsterAcademyCommonUI/MonsterAcademyPlayer_Image_03.png",
		SubType = 1,
		Name = getI18NValue(180432698),
		Describe = getI18NValue(180432697)
	},
	[104] = {
		Group = 3,
		Type = 1,
		Id = 104,
		Icon = "/Activity/MonsterAcademy/Batch1/MonsterAcademyCommonUI/MonsterAcademyPlayer_Image_02.png",
		SubType = 2,
		Name = getI18NValue(180432700),
		Describe = getI18NValue(180432699)
	},
	[401] = {
		Group = 2,
		Type = 1,
		Id = 401,
		Icon = "/Activity/MonsterAcademy/Batch1/MonsterAcademyCommonUI/MonsterAcademyPlayer_Image_05.png",
		SubType = 1,
		Name = getI18NValue(180922064),
		Describe = getI18NValue(180922063)
	},
	[402] = {
		Group = 2,
		Type = 1,
		Id = 402,
		Icon = "/Activity/MonsterAcademy/Batch1/MonsterAcademyCommonUI/MonsterAcademyPlayer_Image_06.png",
		SubType = 1,
		Name = getI18NValue(180922066),
		Describe = getI18NValue(180922065)
	},
	[403] = {
		Group = 2,
		Type = 1,
		Id = 403,
		Icon = "/Activity/MonsterAcademy/Batch1/MonsterAcademyCommonUI/MonsterAcademyPlayer_Image_03.png",
		SubType = 1,
		Name = getI18NValue(180922068),
		Describe = getI18NValue(180922067)
	},
	[404] = {
		Group = 2,
		Type = 1,
		Id = 404,
		Icon = "/Activity/MonsterAcademy/Batch1/MonsterAcademyCommonUI/MonsterAcademyPlayer_Image_04.png",
		SubType = 2,
		Name = getI18NValue(180922070),
		Describe = getI18NValue(180922069)
	}
}

setmetatable(CfgGalgameMonsterAttributeTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgGalgameMonsterAttributeTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Group = 0,
		Describe = "",
		Name = "",
		Type = 0,
		Icon = "",
		SubType = 0
	}
}

for i, data in pairs(CfgGalgameMonsterAttributeTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgGalgameMonsterAttributeTable
