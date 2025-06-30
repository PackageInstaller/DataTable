-- chunkname: @IQIGame\\Config\\CfgLoadingTable.lua

local CfgLoadingTable = {
	{
		Id = 1,
		LoadingBackGround = "/DataResource/UIResource/LoginBG/ComBg_01_01.png"
	},
	{
		LoadingBackGround = "/Common/ComBackground/LoadingUI_ComBg_31_01.png",
		Id = 2,
		Name = {
			getI18NValue(180002928),
			getI18NValue(180002929),
			getI18NValue(180002930),
			getI18NValue(180002931),
			getI18NValue(180002932),
			getI18NValue(180002933),
			getI18NValue(180002934),
			getI18NValue(180002935),
			getI18NValue(180002936),
			getI18NValue(180002937),
			getI18NValue(180002938)
		}
	},
	[5] = {
		LoadingBackGround = "/Common/ComBackground/LoadingUI_ComBg_31_01.png",
		Id = 5,
		Name = {
			getI18NValue(180002939),
			getI18NValue(180002940),
			getI18NValue(180002941),
			getI18NValue(180002942),
			getI18NValue(180002943),
			getI18NValue(180002944),
			getI18NValue(180002945),
			getI18NValue(180002946),
			getI18NValue(180002947),
			getI18NValue(180002948),
			getI18NValue(180002949)
		}
	},
	[6] = {
		LoadingBackGround = "/Common/ComBackground/LoadingUI_ComBg_31_01.png",
		Id = 6,
		Name = {
			getI18NValue(180002950),
			getI18NValue(180002951),
			getI18NValue(180002952),
			getI18NValue(180002953),
			getI18NValue(180002954),
			getI18NValue(180002955),
			getI18NValue(180002956),
			getI18NValue(180002957),
			getI18NValue(180002958),
			getI18NValue(180002959),
			getI18NValue(180002960)
		}
	},
	[7] = {
		LoadingBackGround = "/Common/ComBackground/LoadingUI_ComBg_31_01.png",
		Id = 7,
		Name = {
			getI18NValue(180002961),
			getI18NValue(180002962),
			getI18NValue(180002963),
			getI18NValue(180002964),
			getI18NValue(180002965),
			getI18NValue(180002966),
			getI18NValue(180002967),
			getI18NValue(180002968),
			getI18NValue(180002969),
			getI18NValue(180002970),
			getI18NValue(180002971)
		}
	},
	{
		LoadingBackGround = "/Common/ComBackground/LoadingUI_ComBg_31_01.png",
		Id = 3,
		Name = {
			getI18NValue(180002972),
			getI18NValue(180002973),
			getI18NValue(180002974),
			getI18NValue(180002975),
			getI18NValue(180002976),
			getI18NValue(180002977),
			getI18NValue(180002978),
			getI18NValue(180002979),
			getI18NValue(180002980),
			getI18NValue(180002981),
			getI18NValue(180002982)
		}
	},
	[66] = {
		LoadingBackGround = "/Common/ComBackground/LoadingUI_ComBg_31_01.png",
		Id = 66,
		Name = {
			getI18NValue(180002983),
			getI18NValue(180002984),
			getI18NValue(180002985),
			getI18NValue(180002986),
			getI18NValue(180002987),
			getI18NValue(180002988),
			getI18NValue(180002989),
			getI18NValue(180002990),
			getI18NValue(180002991),
			getI18NValue(180002992),
			getI18NValue(180002993)
		}
	},
	[10] = {
		Id = 10,
		LoadingBackGround = "/Common/ComBackground/black.png"
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
