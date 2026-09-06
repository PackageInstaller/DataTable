-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_sell_shop_const.lua

module("logicconfig.config.t_sell_shop_const", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"FirstGiftId",
		"430:8#444:15#453:17#478:20"
	},
	{
		"SecGiftId",
		"430:9#444:16#453:18#478:21"
	},
	{
		"HdsOtherGiftId",
		"478:22"
	},
	{
		"Func_387_BG",
		"board_jlzg_bg01"
	},
	{
		"Func_410_BG",
		"board_shlb_bg01"
	},
	{
		"Func_430_BG",
		"board_myzg_bg01"
	},
	{
		"Func_368_BG",
		"board_myzg_bg01"
	},
	{
		"Func_444_BG",
		"board_jlzgks_bg01"
	},
	{
		"Func_453_BG",
		"board_yyw_bg01"
	},
	{
		"Func_478_BG",
		"board_lz_bg01"
	}
}
local t_sell_shop_const = {
	FirstGiftId = dataList[1],
	SecGiftId = dataList[2],
	HdsOtherGiftId = dataList[3],
	Func_387_BG = dataList[4],
	Func_410_BG = dataList[5],
	Func_430_BG = dataList[6],
	Func_368_BG = dataList[7],
	Func_444_BG = dataList[8],
	Func_453_BG = dataList[9],
	Func_478_BG = dataList[10]
}

t_sell_shop_const.dataList = dataList

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

return t_sell_shop_const
