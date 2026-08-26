-- chunkname: @modules/logic/fight/model/data/FightRouge2MusicDataMgr.lua

module("modules.logic.fight.model.data.FightRouge2MusicDataMgr", package.seeall)

local FightRouge2MusicDataMgr = FightDataClass("FightRouge2MusicDataMgr", FightDataMgrBase)

function FightRouge2MusicDataMgr:onConstructor()
	self.clientMusicNoteList = {}
	self.serverMusicNoteList = {}
	self.queueMax = 0
end

function FightRouge2MusicDataMgr:onCancelOperation()
	self:syncClientMusicNoteList()
	self:com_sendFightEvent(FightEvent.Rouge2_ForceRefreshMusicType)
end

function FightRouge2MusicDataMgr:updateData(fightData)
	local musicInfo = self.dataMgr.teamDataMgr:getRouge2MusicInfo(FightEnum.TeamType.MySide)

	if musicInfo then
		self:updateDataByMusicInfo(musicInfo)
	end
end

function FightRouge2MusicDataMgr:updateDataByMusicInfo(musicInfo)
	self.queueMax = musicInfo.queueMax

	self:updateMusicNote(musicInfo.musicNotes)
end

function FightRouge2MusicDataMgr:updateMusicNote(musicNoteList)
	tabletool.clear(self.serverMusicNoteList)

	if musicNoteList then
		for _, musicNote in ipairs(musicNoteList) do
			table.insert(self.serverMusicNoteList, musicNote)
		end
	end

	self:syncClientMusicNoteList()
end

function FightRouge2MusicDataMgr:syncClientMusicNoteList()
	tabletool.clear(self.clientMusicNoteList)

	for _, music in ipairs(self.serverMusicNoteList) do
		table.insert(self.clientMusicNoteList, FightRouge2MusicNote.clone(music))
	end
end

function FightRouge2MusicDataMgr:addMusicType(music, blueValue)
	local musicNote = FightRouge2MusicNote.New()

	musicNote:setValue(music, blueValue)
	table.insert(self.clientMusicNoteList, musicNote)
	self:com_sendFightEvent(FightEvent.Rouge2_OnAddMusicType, musicNote)
end

function FightRouge2MusicDataMgr:popMusicType()
	local music = table.remove(self.clientMusicNoteList, 1)

	if not music then
		return
	end

	self:com_sendFightEvent(FightEvent.Rouge2_OnPopMusicType, music)

	return music
end

function FightRouge2MusicDataMgr:tryPopMusicNote()
	local curLen = #self.clientMusicNoteList

	if curLen <= self.queueMax then
		return
	end

	return self:popMusicType()
end

function FightRouge2MusicDataMgr:addClientBlueValue(blueValue)
	for _, musicNote in ipairs(self.clientMusicNoteList) do
		musicNote.preAddValue = musicNote.preAddValue + blueValue
	end
end

function FightRouge2MusicDataMgr:getClientMusicNoteList()
	return self.clientMusicNoteList
end

function FightRouge2MusicDataMgr:getServerMusicNoteList()
	return self.serverMusicNoteList
end

function FightRouge2MusicDataMgr:checkClientIsFull()
	local curLen = #self.clientMusicNoteList

	return curLen >= self.queueMax
end

return FightRouge2MusicDataMgr
