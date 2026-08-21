-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_audio.lua

module("logic.config.t_audio", package.seeall)

local title = {
	id = 1,
	name = 2,
	groupType = 3,
	musicName = 4
}
local dataList = {
	{
		100001,
		"bgm/battlebgm_new.mp3",
		0,
		""
	},
	{
		100002,
		"skill/bs_feiniao.mp3",
		13,
		""
	},
	{
		100003,
		"skill/bs_fenlier.mp3",
		13,
		""
	},
	{
		100004,
		"skill/bs_yun.mp3",
		13,
		""
	},
	{
		100005,
		"skill/bs_yikaluosi.mp3",
		13,
		""
	},
	{
		100006,
		"footsteps_machine_new.wav",
		1,
		""
	},
	{
		100007,
		"footsteps_hardsoledshoes_new.wav",
		1,
		""
	},
	{
		100008,
		"footsteps_mediumsize_new.wav",
		1,
		""
	},
	{
		100009,
		"battle_start.ogg",
		1,
		""
	},
	{
		100010,
		"battle_win.ogg",
		1,
		""
	},
	{
		100011,
		"battle_fail",
		1,
		""
	},
	{
		100012,
		"bgm/loadingbgm.mp3",
		0,
		""
	}
}
local t_audio = {
	[100001] = dataList[1],
	[100002] = dataList[2],
	[100003] = dataList[3],
	[100004] = dataList[4],
	[100005] = dataList[5],
	[100006] = dataList[6],
	[100007] = dataList[7],
	[100008] = dataList[8],
	[100009] = dataList[9],
	[100010] = dataList[10],
	[100011] = dataList[11],
	[100012] = dataList[12]
}

t_audio.dataList = dataList

local multiLanguageCells = {
	musicName = true
}
local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			local value = rawget(t, index)

			if multiLanguageCells[key] then
				value = lang(value)
			end

			return value
		else
			error(string.format("the field name [%s] is nonexist!", key))
		end
	end
}

for i, v in ipairs(dataList) do
	setmetatable(v, mt)
end

return t_audio
