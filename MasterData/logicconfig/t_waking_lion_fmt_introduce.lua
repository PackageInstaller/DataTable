-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_waking_lion_fmt_introduce.lua

module("logicconfig.config.t_waking_lion_fmt_introduce", package.seeall)

local title = {
	id = 2,
	name = 3,
	introduceId = 1,
	desc = 4
}
local dataList = {
	{
		1,
		1,
		"五行青阵",
		"五行青阵寓意天时、地利、人和、兴旺。\r\n\r\n表演时，青阵上会摆放五色令旗（白、绿、黑、红、黄），用来代表五行阵金、木、水、火、土的五行元素。\r\n\r\n此青阵采青要诀：相生探阵，相克破阵。舞狮者将伴以稳健灵活的步形步法，随着鼓点的快、慢、轻、重的节奏舞出千姿百态，传达出吉祥如意的美好愿望。"
	},
	{
		1,
		2,
		"灵蛇衔珠青阵",
		"灵蛇衔珠青阵寓意知恩图报。\r\n\r\n此青阵有一个典故：灵蛇之珠-即隋珠，出自《淮南子·说览冥训》。“隋侯，汉东之国姬姓诸侯也。隋侯见大蛇伤断，以药傅(fū，敷)之，后蛇于江中衔大珠以报之，因曰隋侯之珠，盖明月珠也。”\r\n\r\n此蛇乃属灵蛇，本阵法需要表现的是将灵蛇护送回蛇洞的故事。采青过程中，舞狮者不可脚踏蛇身或有攻击蛇的动作，应处处护蛇，将蛇安全送回洞中，同时在洞里采到“灵蛇之珠”。"
	},
	{
		1,
		3,
		"九宫八卦青阵",
		"九宫八卦青阵寓意驱邪化煞、转运开运。\r\n\r\n采青要诀：二四为肩，六八为足，左三右七，戴九履一，五居中央（注：九或五可为主青）。\r\n\r\n舞狮者需要按照九宫八卦的方位，进行探阵破阵，舞动起来有“静如灵猫伺鼠出穴，动如猛虎擒羊敏捷”的风范。"
	}
}
local t_waking_lion_fmt_introduce = {
	{
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_waking_lion_fmt_introduce.dataList = dataList

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

return t_waking_lion_fmt_introduce
