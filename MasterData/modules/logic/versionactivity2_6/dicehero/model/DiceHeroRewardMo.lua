-- chunkname: @modules/logic/versionactivity2_6/dicehero/model/DiceHeroRewardMo.lua

module("modules.logic.versionactivity2_6.dicehero.model.DiceHeroRewardMo", package.seeall)

local DiceHeroRewardMo = class("DiceHeroRewardMo")

function DiceHeroRewardMo:init(data)
	self.type = data.type
	self.id = data.id
	self.index = nil
end

return DiceHeroRewardMo
