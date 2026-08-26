-- chunkname: @modules/logic/abyss/model/AbyssTaskModel.lua

module("modules.logic.abyss.model.AbyssTaskModel", package.seeall)

local AbyssTaskModel = class("AbyssTaskModel", BaseModel)

function AbyssTaskModel:onInit()
	self:reInit()
end

function AbyssTaskModel:reInit()
	self._taskInfoMoDic = {}
	self._taskInfoMoList = {}
end

return AbyssTaskModel.instance
