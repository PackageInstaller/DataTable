-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_entrance_text.lua

module("logicconfig.config.t_entrance_text", package.seeall)

local title = {
	signature = 5,
	subtitle = 3,
	next = 6,
	id = 1,
	title = 2,
	content = 4
}
local dataList = {
	{
		1,
		"",
		"",
		"<color=#70512c>致亲爱的冒险者：</color>\r\n\r\n    <color=#91551f>欢迎来到奥奇学院，您已获准成为第301期奥奇精灵训练师。\r\n    这里有广阔的世界等着您来冒险，各种各样的精灵期待与您相遇。\r\n    期待您在未来的冒险中找到自己一生的追求！</color>",
		"奥奇发明协会名誉副会长\r\n特级精灵训练师\r\n兼 五王议会首席议员\r\n<color=#4269cb>格兰特</color> 谨上",
		0
	},
	{
		2,
		"",
		"",
		"<color=#70512c>致亲爱的冒险者：</color>\r\n\r\n    <color=#91551f>我们又见面了！\r\n    还记得你曾经留下的梦想胶囊，还记得我们一起经历的冒险吗？\r\n    圣光飞龙等候在王者之路的终点，星格洛萨亦在狂沙雷电中守候，而我们，你曾经\n熟悉的奥奇一班，也在学院等着你。\r\n    最强精灵训练师，这可是你的初心呢。来吧，一起再续冒险之缘！\r\n    敬自由，敬冒险，敬不羁的热血之旅！欢迎回到奥奇学院！！</color>",
		"奥奇发明协会名誉副会长\r\n特级精灵训练师\r\n兼 五王议会首席议员\r\n<color=#4269cb>格兰特</color> 谨上",
		0
	},
	{
		3,
		"亲爱的冒险者：",
		"",
		"测试测试\n新的冒险者的一封信",
		"",
		0
	},
	{
		4,
		"亲爱的老奥奇：",
		"",
		"测试测试\n老奥奇的一封信",
		"",
		0
	},
	{
		5,
		"精灵训练师认证考验",
		"",
		"#username#，欢迎你加入奥奇学院，请根据指引完成精灵训练师的入学考验。",
		"",
		0
	},
	{
		6,
		"精灵训练师认证考验",
		"",
		"#username#，欢迎你加入奥奇学院，请根据指引完成精灵训练师的入学考验。",
		"",
		0
	},
	{
		7,
		"精灵训练师认证考验",
		"",
		"#username#，恭喜你完成了精灵训练师的认证考验！",
		"",
		0
	},
	{
		8,
		"精灵训练师认证考验",
		"",
		"#username#，恭喜你完成了精灵训练师的认证考验！",
		"",
		0
	}
}
local t_entrance_text = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8]
}

t_entrance_text.dataList = dataList

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

return t_entrance_text
