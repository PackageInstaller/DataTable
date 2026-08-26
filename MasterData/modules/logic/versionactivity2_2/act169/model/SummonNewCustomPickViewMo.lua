-- chunkname: @modules/logic/versionactivity2_2/act169/model/SummonNewCustomPickViewMo.lua

module("modules.logic.versionactivity2_2.act169.model.SummonNewCustomPickViewMo", package.seeall)

local SummonNewCustomPickViewMo = class("SummonNewCustomPickViewMo")

function SummonNewCustomPickViewMo:ctor(activityId, heroId)
	self.activityId = activityId
	self.heroId = heroId
	self.selectId = heroId
end

return SummonNewCustomPickViewMo
