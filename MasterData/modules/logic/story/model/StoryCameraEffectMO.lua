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
	self.target = 0
	self.autoRestore = true
	self.keepRefresh = false
end

function StoryCameraEffectMO:init(info)
	self.type = info[1]
	self.name = info[2]
	self.controllerName = info[3]
	self.endTime = info[4]
	self.dialogEff = info[5]
	self.heroEff = info[6]
	self.target = info[7] or 0
	self.autoRestore = info[8] ~= false
	self.keepRefresh = info[9] == true
end

return StoryCameraEffectMO
