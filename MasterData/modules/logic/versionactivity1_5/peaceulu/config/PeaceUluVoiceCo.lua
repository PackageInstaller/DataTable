-- chunkname: @modules/logic/versionactivity1_5/peaceulu/config/PeaceUluVoiceCo.lua

module("modules.logic.versionactivity1_5.peaceulu.config.PeaceUluVoiceCo", package.seeall)

local PeaceUluVoiceCo = pureTable("PeaceUluVoiceCo")

function PeaceUluVoiceCo:init(co)
	self.heroId = 3076
	self.content = co.content
	self.encontent = co.content
	self.twcontent = co.content
	self.jpcontent = co.content
	self.kocontent = co.content
	self.decontent = co.content
	self.frcontent = co.content
	self.thaicontent = co.content
	self.motion = co.motion
	self.twmotion = co.motion
	self.jpmotion = co.motion
	self.enmotion = co.motion
	self.komotion = co.motion
	self.demotion = co.motion
	self.frmotion = co.motion
	self.thaimotion = co.motion
	self.displayTime = co.displayTime
end

return PeaceUluVoiceCo
