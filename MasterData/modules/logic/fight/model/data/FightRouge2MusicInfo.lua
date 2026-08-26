-- chunkname: @modules/logic/fight/model/data/FightRouge2MusicInfo.lua

module("modules.logic.fight.model.data.FightRouge2MusicInfo", package.seeall)

local FightRouge2MusicInfo = FightDataClass("FightRouge2MusicInfo")

function FightRouge2MusicInfo:onConstructor(proto)
	self.queueMax = proto.queueMax
	self.musicNotes = {}

	for _, music in ipairs(proto.musicNotes) do
		table.insert(self.musicNotes, FightRouge2MusicNote.New(music))
	end

	self.type2SkillIdStr = proto.type2SkillStr
	self.type2SkillId = {}

	local list = FightStrUtil.instance:getSplitString2Cache(self.type2SkillIdStr, true)

	for _, arr in ipairs(list) do
		self.type2SkillId[arr[1]] = arr[2]
	end
end

function FightRouge2MusicInfo:updateInfo(musicInfo)
	self.queueMax = musicInfo.queueMax

	tabletool.clear(self.musicNotes)

	for _, musicNote in ipairs(musicInfo.musicNotes) do
		table.insert(self.musicNotes, musicNote)
	end

	self.type2SkillIdStr = musicInfo.type2SkillIdStr

	tabletool.clear(self.type2SkillId)

	for key, value in pairs(musicInfo.type2SkillId) do
		self.type2SkillId[key] = value
	end
end

function FightRouge2MusicInfo:getSkillId(type)
	return self.type2SkillId and self.type2SkillId[type]
end

return FightRouge2MusicInfo
