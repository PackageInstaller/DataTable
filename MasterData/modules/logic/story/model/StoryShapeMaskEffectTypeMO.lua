-- chunkname: @modules/logic/story/model/StoryShapeMaskEffectTypeMO.lua

module("modules.logic.story.model.StoryShapeMaskEffectTypeMO", package.seeall)

local StoryShapeMaskEffectTypeMO = pureTable("StoryShapeMaskEffectTypeMO")

function StoryShapeMaskEffectTypeMO:ctor()
	self.type = 0
	self.name = ""
	self.createTime = 0.2
	self.shapePrefabPath = ""
	self.holeSize = 1

	if StoryEnum and StoryEnum.EffLayer then
		self.maskLayer = StoryEnum.EffLayer.UpCon3 or 9
	end

	self.startPosX = 0
	self.startPosY = 0
	self.moveStartTime = 0
	self.targetPosX = 0
	self.targetPosY = 0
	self.moveDuration = 0

	if EaseType then
		self.moveEase = EaseType.Linear or 1
	end
end

function StoryShapeMaskEffectTypeMO:init(info)
	self.type = info[1]
	self.name = info[2]
	self.createTime = info[3]
	self.shapePrefabPath = info[4]
	self.holeSize = info[5]
	self.maskLayer = info[6]
	self.startPosX = info[7]
	self.startPosY = info[8]
	self.moveStartTime = info[9]
	self.targetPosX = info[10]
	self.targetPosY = info[11]
	self.moveDuration = info[12]
	self.moveEase = info[13]
end

return StoryShapeMaskEffectTypeMO
