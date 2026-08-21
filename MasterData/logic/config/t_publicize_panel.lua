-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_publicize_panel.lua

module("logic.config.t_publicize_panel", package.seeall)

local title = {
	jumpId = 7,
	bgImagePath = 2,
	showReward = 6,
	txtContetnt = 4,
	rewardTxtContent = 5,
	titleImage = 3,
	isShowTime = 9,
	code = 1,
	btnTxtContetnt = 8
}
local dataList = {
	{
		140001,
		"com_publicize_dynamic/kqgfhd_bg_0001",
		"com_publicize/com_publicize_dynamic/kqgfhd_text_tra",
		"tip_publicize_airworkshop_content",
		"tip_publicize_airworkshop_rewardcontent",
		{
			1100002,
			1001001
		},
		11301001,
		"tip_publicize_airworkshop_btncontent",
		0
	},
	{
		140002,
		"com_publicize_dynamic/alshd_bg_0001",
		"com_publicize/com_publicize_dynamic/alshd_text_tra",
		"",
		"",
		nil,
		10803004,
		"tip_publicize_airworkshop_btncontent",
		0
	}
}
local t_publicize_panel = {}

t_publicize_panel.dataList = dataList

local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			return rawget(t, index)
		else
			error(string.format("the field name [%s] is nonexist!", key))
		end
	end
}

for i, v in ipairs(dataList) do
	t_publicize_panel[v[1]] = v

	setmetatable(v, mt)
end

return t_publicize_panel
