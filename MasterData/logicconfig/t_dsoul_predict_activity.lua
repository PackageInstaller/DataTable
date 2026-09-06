-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dsoul_predict_activity.lua

module("logicconfig.config.t_dsoul_predict_activity", package.seeall)

local title = {
	redPointId = 4,
	jumpTo = 5,
	playerList = 6,
	voteEndTime = 3,
	activityId = 1,
	voteMp = 2
}
local dataList = {
	{
		428001,
		"10:428001:1",
		"2024-12-13T05:00:00",
		643,
		"func#913#281003",
		"1#2#283#284#285#286#287#288#289#290#291#292#293#294#295#296#297#298#299#300#301#302#303#304#305#306#307#308#309#310#311#312#313#314#315#316#317#318#319#320#321#322#323#324#325#326#327#328#329#330#331#332#333#334#335#336#337#338#339#340#341#342#343#344#345#346#347"
	}
}
local t_dsoul_predict_activity = {
	[428001] = dataList[1]
}

t_dsoul_predict_activity.dataList = dataList

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

return t_dsoul_predict_activity
