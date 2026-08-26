-- chunkname: @modules/logic/partygame/view/carddrop/entity/CardDropEntityCompBase.lua

module("modules.logic.partygame.view.carddrop.entity.CardDropEntityCompBase", package.seeall)

local CardDropEntityCompBase = class("CardDropEntityCompBase", UserDataDispose)

function CardDropEntityCompBase:init(uid, entity)
	self:__onInit()

	self.uid = uid
	self.entity = entity
end

function CardDropEntityCompBase:destroy()
	self:__onDispose()
end

return CardDropEntityCompBase
