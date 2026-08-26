-- chunkname: @modules/logic/monthcard/model/VersionActivity3_8FreeMonthCardAct240InfoMo.lua

module("modules.logic.monthcard.model.VersionActivity3_8FreeMonthCardAct240InfoMo", package.seeall)

local VersionActivity3_8FreeMonthCardAct240InfoMo = pureTable("VersionActivity3_8FreeMonthCardAct240InfoMo")

function VersionActivity3_8FreeMonthCardAct240InfoMo:ctor()
	self.id = 0
	self.state = 0
end

function VersionActivity3_8FreeMonthCardAct240InfoMo:init(info)
	self.id = info.id
	self.state = info.state
end

function VersionActivity3_8FreeMonthCardAct240InfoMo:updateState(state)
	self.state = state
end

return VersionActivity3_8FreeMonthCardAct240InfoMo
