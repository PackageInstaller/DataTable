-- chunkname: @modules/logic/partycloth/model/PartyClothMo.lua

module("modules.logic.partycloth.model.PartyClothMo", package.seeall)

local PartyClothMo = pureTable("PartyClothMo")

function PartyClothMo:init(id, quantity)
	self.clothId = id
	self.config = PartyClothConfig.instance:getClothConfig(id)
	self.quantity = quantity
end

function PartyClothMo:addQuantity(quantity)
	self.quantity = self.quantity + quantity
end

return PartyClothMo
