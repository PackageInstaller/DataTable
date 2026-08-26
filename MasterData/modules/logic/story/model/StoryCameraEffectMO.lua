-- chunkname: @modules/logic/story/model/StoryCameraEffectMO.lua

module("modules.logic.story.model.StoryCameraEffectMO", package.seeall)

local StoryCameraEffectMO = pureTable("StoryCameraEffectMO")

function StoryCameraEffectMO:ctor()
	self.type = 0
	self.name = ""
	self.controllerName = ""
	self.endTime = 0
	self.dialogEff = true
	self.heroEff = true
end

function StoryCameraEffectMO:init(info)
	self.type = info[1]
	self.name = info[2]
	self.controllerName = info[3]
	self.endTime = info[4]
	self.dialogEff = info[5]
	self.heroEff = info[6]
end

return StoryCameraEffectMO
