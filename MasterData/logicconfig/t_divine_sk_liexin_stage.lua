-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_sk_liexin_stage.lua

module("logicconfig.config.t_divine_sk_liexin_stage", package.seeall)

local title = {
	stagePlanId = 1,
	stageId = 2,
	tagCount = 3,
	creepsMasterId = 4,
	desc = 5
}
local dataList = {
	{
		1,
		1,
		2,
		101,
		"1、红莲规则：因红莲印记触发复活的精灵死亡时，阵亡精灵清除禁疗状态后复活恢复满血满气并获得一次立即出手（每个红莲印记只生效一次）\r\n\r\n2、复活规则：红莲道具放置在空位时，该位置上下左右的精灵若阵亡则立即复活；若上下左右存在多只精灵阵亡，则按照死亡顺序优先复活\r\n\r\n3、己阵在坚持5个大回合后，有存活精灵或击败敌阵全阵精灵视为通关。"
	},
	{
		1,
		2,
		2,
		102,
		"1、红莲规则：因红莲印记触发复活的精灵死亡时，阵亡精灵清除禁疗状态后复活恢复满血满气并获得一次立即出手（每个红莲印记只生效一次）\r\n\r\n2、复活规则：红莲道具放置在空位时，该位置上下左右的精灵若阵亡则立即复活；若上下左右存在多只精灵阵亡，则按照死亡顺序优先复活\r\n\r\n3、己阵在坚持5个大回合后，有存活精灵或击败敌阵全阵精灵视为通关。"
	},
	{
		1,
		3,
		3,
		103,
		"1、红莲规则：因红莲印记触发复活的精灵死亡时，阵亡精灵清除禁疗状态后复活恢复满血满气并获得一次立即出手（每个红莲印记只生效一次）\r\n\r\n2、复活规则：红莲道具放置在空位时，该位置上下左右的精灵若阵亡则立即复活；若上下左右存在多只精灵阵亡，则按照死亡顺序优先复活\r\n\r\n3、己阵在坚持6个大回合后，有存活精灵或击败敌阵全阵精灵视为通关。"
	},
	{
		1,
		4,
		3,
		104,
		"1、红莲规则：因红莲印记触发复活的精灵死亡时，阵亡精灵清除禁疗状态后复活恢复满血满气并获得一次立即出手（每个红莲印记只生效一次）\r\n\r\n2、复活规则：红莲道具放置在空位时，该位置上下左右的精灵若阵亡则立即复活；若上下左右存在多只精灵阵亡，则按照死亡顺序优先复活\r\n\r\n3、己阵在坚持7个大回合后，有存活精灵或击败敌阵全阵精灵视为通关。"
	},
	{
		1,
		5,
		4,
		105,
		"1、红莲规则：因红莲印记触发复活的精灵死亡时，阵亡精灵清除禁疗状态后复活恢复满血满气并获得一次立即出手（每个红莲印记只生效一次）\r\n\r\n2、复活规则：红莲道具放置在空位时，该位置上下左右的精灵若阵亡则立即复活；若上下左右存在多只精灵阵亡，则按照死亡顺序优先复活\r\n\r\n3、己阵在坚持8个大回合后，有存活精灵或击败敌阵全阵精灵视为通关。"
	}
}
local t_divine_sk_liexin_stage = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_divine_sk_liexin_stage.dataList = dataList

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

return t_divine_sk_liexin_stage
