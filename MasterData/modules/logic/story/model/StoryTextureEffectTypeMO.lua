-- chunkname: @modules/logic/story/model/StoryTextureEffectTypeMO.lua

module("modules.logic.story.model.StoryTextureEffectTypeMO", package.seeall)

local StoryTextureEffectTypeMO = pureTable("StoryTextureEffectTypeMO")

function StoryTextureEffectTypeMO:ctor()
	self.type = 0
	self.name = ""
	self.noiseVisible = true
	self.distort1Visible = true
	self.textureShakeSpeed = 0.25
	self.distort1Factor = 0.25
	self.noiseBrightness = 0.47
	self.blackWhiteVisible = true
	self.blackWhiteSpeed = 0.05
	self.blackWhiteStrength = 0.45
	self.distort2Visible = true
	self.distort2Speed = 0.02
	self.distort2Factor = 0.1
end

function StoryTextureEffectTypeMO:init(info)
	self.type = info[1]
	self.name = info[2]
	self.noiseVisible = info[3]
	self.distort1Visible = info[4]
	self.textureShakeSpeed = info[5]
	self.distort1Factor = info[6]
	self.noiseBrightness = info[7]
	self.blackWhiteVisible = info[8]
	self.blackWhiteSpeed = info[9]
	self.blackWhiteStrength = info[10]
	self.distort2Visible = info[11]
	self.distort2Speed = info[12]
	self.distort2Factor = info[13]
end

return StoryTextureEffectTypeMO
