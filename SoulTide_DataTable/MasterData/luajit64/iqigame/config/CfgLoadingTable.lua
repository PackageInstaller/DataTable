-- chunkname: @IQIGame\\Config\\CfgLoadingTable.lua

local CfgLoadingTable = {
	[2] = {
		LoadingBackGround = "/Common/ComBackground/LoadingBg/LoadingUI_ComBg_31_01.png",
		Id = 2,
		Name = {
			getI18NValue(180455859),
			getI18NValue(180455860),
			getI18NValue(180455861),
			getI18NValue(180455862),
			getI18NValue(180455863),
			getI18NValue(180455864),
			getI18NValue(180455865),
			getI18NValue(180455866),
			getI18NValue(180455867)
		}
	},
	[5] = {
		Id = 5,
		LoadingBackGround = "/Common/ComBackground/LoadingBg/ComBg_52_01.png"
	},
	[6] = {
		LoadingBackGround = "/Common/ComBackground/LoadingBg/ComBg_39_01.png",
		Id = 6,
		Name = {
			getI18NValue(180455868),
			getI18NValue(180455869),
			getI18NValue(180455870),
			getI18NValue(180455871),
			getI18NValue(180455872),
			getI18NValue(180455873),
			getI18NValue(180455874),
			getI18NValue(180455875),
			getI18NValue(180455876)
		}
	},
	[7] = {
		LoadingBackGround = "/Common/ComBackground/Background/ComBg_15_01.png",
		Id = 7,
		Name = {
			getI18NValue(180455877),
			getI18NValue(180455878),
			getI18NValue(180455879),
			getI18NValue(180455880),
			getI18NValue(180455881),
			getI18NValue(180455882),
			getI18NValue(180455883),
			getI18NValue(180455884),
			getI18NValue(180455885)
		}
	},
	[8] = {
		Id = 8,
		LoadingBackGround = "/Common/ComBackground/LoadingBg/LoadingUI_ComBg_31_01.png"
	},
	[9] = {
		Id = 9,
		LoadingBackGround = "/Common/ComBackground/LoadingBg/LoadingUI_ComBg_31_01.png"
	},
	[10] = {
		Id = 10,
		LoadingBackGround = "/Common/ComBackground/LoadingBg/LoadingUI_ComBg_31_01.png"
	},
	[11] = {
		Id = 11,
		LoadingBackGround = "/Common/ComBackground/LoadingBg/LoadingUI_ComBg_31_01.png"
	},
	[12] = {
		Id = 12,
		LoadingBackGround = "/Common/ComBackground/LoadingBg/LoadingUI_ComBg_31_01.png"
	},
	[13] = {
		Id = 13,
		LoadingBackGround = "/Maze_Background/Activity_MonsterAcademy_01.png"
	}
}

setmetatable(CfgLoadingTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgLoadingTable]")
	end
})

local defaultMetaTable = {
	__index = {
		LoadingBackGround = "",
		Name = {}
	}
}

for i, data in pairs(CfgLoadingTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgLoadingTable
