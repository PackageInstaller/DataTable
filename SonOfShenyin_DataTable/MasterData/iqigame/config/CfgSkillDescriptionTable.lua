-- chunkname: @IQIGame\\Config\\CfgSkillDescriptionTable.lua

local CfgSkillDescriptionTable = {
	[10110] = {
		Id = 10110,
		EffectName = getI18NValue(180230319),
		Describe = getI18NValue(180230318)
	},
	[10120] = {
		Id = 10120,
		EffectName = getI18NValue(180230321),
		Describe = getI18NValue(180230320)
	},
	[10130] = {
		Id = 10130,
		EffectName = getI18NValue(180230323),
		Describe = getI18NValue(180230322)
	},
	[10140] = {
		Id = 10140,
		EffectName = getI18NValue(180230325),
		Describe = getI18NValue(180230324)
	},
	[10150] = {
		Id = 10150,
		EffectName = getI18NValue(180230327),
		Describe = getI18NValue(180230326)
	},
	[10160] = {
		Id = 10160,
		EffectName = getI18NValue(180230329),
		Describe = getI18NValue(180230328)
	},
	[10170] = {
		Id = 10170,
		EffectName = getI18NValue(180230331),
		Describe = getI18NValue(180230330)
	},
	[10180] = {
		Id = 10180,
		EffectName = getI18NValue(180230333),
		Describe = getI18NValue(180230332)
	},
	[10190] = {
		Id = 10190,
		EffectName = getI18NValue(180230335),
		Describe = getI18NValue(180230334)
	},
	[10200] = {
		Id = 10200,
		EffectName = getI18NValue(180230337),
		Describe = getI18NValue(180230336)
	},
	[10210] = {
		Id = 10210,
		EffectName = getI18NValue(180230339),
		Describe = getI18NValue(180230338)
	},
	[10220] = {
		Id = 10220,
		EffectName = getI18NValue(180230341),
		Describe = getI18NValue(180230340)
	},
	[20101] = {
		Id = 20101,
		EffectName = getI18NValue(180251734),
		Describe = getI18NValue(180251733)
	},
	[20102] = {
		Id = 20102,
		EffectName = getI18NValue(180251736),
		Describe = getI18NValue(180251735)
	},
	[20103] = {
		Id = 20103,
		EffectName = getI18NValue(180251738),
		Describe = getI18NValue(180251737)
	},
	[20104] = {
		Id = 20104,
		EffectName = getI18NValue(180251740),
		Describe = getI18NValue(180251739)
	},
	[20105] = {
		Id = 20105,
		EffectName = getI18NValue(180251742),
		Describe = getI18NValue(180251741)
	},
	[20106] = {
		Id = 20106,
		EffectName = getI18NValue(180251744),
		Describe = getI18NValue(180251743)
	},
	[20107] = {
		Id = 20107,
		EffectName = getI18NValue(180251746),
		Describe = getI18NValue(180251745)
	},
	[20108] = {
		Id = 20108,
		EffectName = getI18NValue(180251748),
		Describe = getI18NValue(180251747)
	},
	[20109] = {
		Id = 20109,
		EffectName = getI18NValue(180251750),
		Describe = getI18NValue(180251749)
	},
	[20110] = {
		Id = 20110,
		EffectName = getI18NValue(180251752),
		Describe = getI18NValue(180251751)
	},
	[20111] = {
		Id = 20111,
		EffectName = getI18NValue(180251754),
		Describe = getI18NValue(180251753)
	},
	[20112] = {
		Id = 20112,
		EffectName = getI18NValue(180251756),
		Describe = getI18NValue(180251755)
	},
	[30101] = {
		Id = 30101
	},
	[30102] = {
		Id = 30102
	},
	[30103] = {
		Id = 30103
	},
	[30104] = {
		Id = 30104
	},
	[30105] = {
		Id = 30105
	},
	[30106] = {
		Id = 30106
	},
	[30107] = {
		Id = 30107
	},
	[30108] = {
		Id = 30108
	},
	[30109] = {
		Id = 30109
	},
	[30110] = {
		Id = 30110
	},
	[30111] = {
		Id = 30111
	},
	[30112] = {
		Id = 30112
	}
}

setmetatable(CfgSkillDescriptionTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgSkillDescriptionTable]")
	end
})

local defaultMetaTable = {
	__index = {
		EffectName = "",
		Describe = "",
		Icon = ""
	}
}

for i, data in pairs(CfgSkillDescriptionTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgSkillDescriptionTable
