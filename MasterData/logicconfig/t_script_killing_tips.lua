-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_script_killing_tips.lua

module("logicconfig.config.t_script_killing_tips", package.seeall)

local title = {
	id = 1,
	desc = 3,
	url = 2
}
local dataList = {
	{
		1,
		"ui/bigbg/elementspark/board_yuansuhuozhong_106.png",
		"<size=20>部分线索会有特效提示，部分线索无特效提示，请认真搜寻哦！\r\n<color=#c54949>每一次搜索场景、关联线索，都会扣除1行动点</color>，每天有200点行动点，次日凌晨5点回满~</size>"
	}
}
local t_script_killing_tips = {
	dataList[1]
}

t_script_killing_tips.dataList = dataList

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

return t_script_killing_tips
