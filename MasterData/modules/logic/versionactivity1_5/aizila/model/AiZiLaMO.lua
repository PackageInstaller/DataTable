-- chunkname: @modules/logic/versionactivity1_5/aizila/model/AiZiLaMO.lua

module("modules.logic.versionactivity1_5.aizila.model.AiZiLaMO", package.seeall)

local AiZiLaMO = pureTable("AiZiLaMO")

function AiZiLaMO:init(actId)
	self.id = actId
	self.activityId = actId
end

return AiZiLaMO
