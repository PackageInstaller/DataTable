-- chunkname: @modules/logic/versionactivity4_0/concertlimit/model/MusicGameBlockMO.lua

module("modules.logic.versionactivity4_0.concertlimit.model.MusicGameBlockMO", package.seeall)

local MusicGameBlockMO = pureTable("MusicGameBlockMO")

function MusicGameBlockMO:init(posX, posy)
	self.id = string.format("%s_%s", posX, posy)
	self.x = posX
	self.y = posy
	self.noteType = MusicGameEnum.BlockNoteType.None
	self.type = MusicGameEnum.BlockType.Random
	self.config = MusicGameConfig.instance:getNote(self.noteType)
end

function MusicGameBlockMO:setNoteType(type)
	self.noteType = type
	self.config = MusicGameConfig.instance:getNote(self.noteType)
end

function MusicGameBlockMO:setType(type)
	self.type = type > self.type and type or self.type
end

return MusicGameBlockMO
