-- chunkname: @modules/logic/versionactivity2_4/pinball/model/PinballCurrencyMo.lua

module("modules.logic.versionactivity2_4.pinball.model.PinballCurrencyMo", package.seeall)

local PinballCurrencyMo = pureTable("PinballCurrencyMo")

function PinballCurrencyMo:init(data)
	self.type = data.type
	self.num = data.num
	self.changeNum = data.changeNum
end

return PinballCurrencyMo
