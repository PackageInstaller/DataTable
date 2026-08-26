-- chunkname: @modules/logic/act189/model/ShortenActModel.lua

module("modules.logic.act189.model.ShortenActModel", package.seeall)

local ShortenActModel = class("ShortenActModel", BaseModel)

function ShortenActModel:onInit()
	self:reInit()
end

function ShortenActModel:reInit()
	return
end

function ShortenActModel:getActivityId()
	return ShortenActConfig.instance:getActivityId()
end

function ShortenActModel:isClaimable()
	return Activity189Model.instance:isClaimable(self:getActivityId())
end

ShortenActModel.instance = ShortenActModel.New()

return ShortenActModel
