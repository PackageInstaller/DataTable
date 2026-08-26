-- chunkname: @modules/logic/sp01/act208/model/Act208InfoMo.lua

module("modules.logic.sp01.act208.model.Act208InfoMo", package.seeall)

local Act208InfoMo = pureTable("Act208InfoMo")

function Act208InfoMo:init()
	self.bonusList = {}
	self.bonusDic = {}
end

function Act208InfoMo:setInfo(activityId, bonus)
	self.activityId = activityId

	tabletool.clear(self.bonusList)
	tabletool.clear(self.bonusDic)

	for _, info in ipairs(bonus) do
		table.insert(self.bonusList, info)

		self.bonusDic[info.id] = info
	end
end

function Act208InfoMo:canGet()
	return
end

function Act208InfoMo:isGet()
	return
end

return Act208InfoMo
