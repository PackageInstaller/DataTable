-- chunkname: @modules/logic/endofdream/model/EndOfDreamModel.lua

module("modules.logic.endofdream.model.EndOfDreamModel", package.seeall)

local EndOfDreamModel = class("EndOfDreamModel", BaseModel)

function EndOfDreamModel:onInit()
	self:clear()
end

function EndOfDreamModel:reInit()
	self:clear()
end

function EndOfDreamModel:clear()
	EndOfDreamModel.super.clear()
end

function EndOfDreamModel:isLevelUnlocked(levelId)
	return true
end

EndOfDreamModel.instance = EndOfDreamModel.New()

return EndOfDreamModel
