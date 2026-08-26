-- chunkname: @modules/logic/fight/model/data/FightRouge2MusicNote.lua

module("modules.logic.fight.model.data.FightRouge2MusicNote", package.seeall)

local FightRouge2MusicNote = FightDataClass("FightRouge2MusicNote")

function FightRouge2MusicNote:onConstructor(proto)
	if proto then
		self.type = proto.type
		self.blueValue = proto.blueValue
	else
		self.type = 0
		self.blueValue = 0
	end

	self.preAddValue = 0
end

function FightRouge2MusicNote:setValue(type, blueValue)
	self.type = type
	self.blueValue = blueValue and blueValue or self.type == FightEnum.Rouge2MusicType.Blue and 1 or 0
end

function FightRouge2MusicNote.clone(musicNote)
	local note = FightRouge2MusicNote.New()

	note.type = musicNote.type
	note.blueValue = musicNote.blueValue
	note.preAddValue = musicNote.preAddValue

	return note
end

return FightRouge2MusicNote
