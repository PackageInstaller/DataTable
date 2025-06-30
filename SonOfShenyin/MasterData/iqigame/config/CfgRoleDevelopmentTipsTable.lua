-- chunkname: @IQIGame\\Config\\CfgRoleDevelopmentTipsTable.lua

local CfgRoleDevelopmentTipsTable = {
	[2] = {
		Type = 1,
		Id = 2,
		icon = "Assets/05_Images/Common/Warlock/Warlock_Element/Role_Element_1.png",
		Order = 2,
		OrderValue = {
			1
		},
		Title = getI18NValue(180041485),
		Content = getI18NValue(180041484)
	},
	[3] = {
		Type = 1,
		Id = 3,
		icon = "Assets/05_Images/Common/Warlock/Warlock_Element/Role_Element_2.png",
		Order = 3,
		OrderValue = {
			2
		},
		Title = getI18NValue(180041487),
		Content = getI18NValue(180041486)
	},
	[4] = {
		Type = 1,
		Id = 4,
		icon = "Assets/05_Images/Common/Warlock/Warlock_Element/Role_Element_3.png",
		Order = 4,
		OrderValue = {
			3
		},
		Title = getI18NValue(180041489),
		Content = getI18NValue(180041488)
	},
	[5] = {
		Type = 1,
		Id = 5,
		icon = "Assets/05_Images/Common/Warlock/Warlock_Element/Role_Element_4.png",
		Order = 5,
		OrderValue = {
			4
		},
		Title = getI18NValue(180041491),
		Content = getI18NValue(180041490)
	},
	[8] = {
		Type = 2,
		Id = 8,
		icon = "Assets/05_Images/Common/Warlock/Warlock_Element/Role_Element_011.png",
		Order = 1,
		OrderValue = {
			1,
			3
		},
		Content = getI18NValue(180041492)
	},
	[9] = {
		Type = 2,
		Id = 9,
		icon = "Assets/05_Images/Common/Warlock/Warlock_Element/Role_Element_012.png",
		Order = 2,
		OrderValue = {
			2,
			3
		},
		Content = getI18NValue(180041493)
	},
	[10] = {
		Type = 2,
		Id = 10,
		icon = "Assets/05_Images/Common/Warlock/Warlock_Element/Role_Element_013.png",
		Order = 3,
		OrderValue = {
			4,
			1
		},
		Content = getI18NValue(180041494)
	},
	[11] = {
		Type = 2,
		Id = 11,
		icon = "Assets/05_Images/Common/Warlock/Warlock_Element/Role_Element_014.png",
		Order = 4,
		OrderValue = {
			4,
			3
		},
		Content = getI18NValue(180041495)
	},
	[12] = {
		Type = 2,
		Id = 12,
		icon = "Assets/05_Images/Common/Warlock/Warlock_Element/Role_Element_015.png",
		Order = 5,
		OrderValue = {
			2,
			4
		},
		Content = getI18NValue(180041496)
	},
	[13] = {
		Type = 2,
		Id = 13,
		icon = "Assets/05_Images/Common/Warlock/Warlock_Element/Role_Element_016.png",
		Order = 6,
		OrderValue = {
			2,
			1
		},
		Content = getI18NValue(180041497)
	},
	[15] = {
		Type = 3,
		Id = 15,
		icon = "Assets/05_Images/Common/Warlock/Profession/Profession_1.png",
		Order = 1,
		OrderValue = {
			1
		},
		Content = getI18NValue(180041498)
	},
	[17] = {
		Type = 3,
		Id = 17,
		icon = "Assets/05_Images/Common/Warlock/Profession/Profession_3.png",
		Order = 3,
		OrderValue = {
			3
		},
		Content = getI18NValue(180041500)
	},
	[18] = {
		Type = 3,
		Id = 18,
		icon = "Assets/05_Images/Common/Warlock/Profession/Profession_4.png",
		Order = 4,
		OrderValue = {
			4
		},
		Content = getI18NValue(180041501)
	},
	[19] = {
		Type = 3,
		Id = 19,
		icon = "Assets/05_Images/Common/Warlock/Profession/Profession_5.png",
		Order = 5,
		OrderValue = {
			5
		},
		Content = getI18NValue(180041502)
	}
}

setmetatable(CfgRoleDevelopmentTipsTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgRoleDevelopmentTipsTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Content = "",
		Type = 0,
		icon = "",
		Order = 0,
		Title = "",
		OrderValue = {}
	}
}

for i, data in pairs(CfgRoleDevelopmentTipsTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgRoleDevelopmentTipsTable
