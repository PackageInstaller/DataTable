-- chunkname: @modules/logic/versionactivity1_2/versionactivity1_2dungeon/model/VersionActivity1_2NoteModel.lua

module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.model.VersionActivity1_2NoteModel", package.seeall)

local VersionActivity1_2NoteModel = class("VersionActivity1_2NoteModel", BaseModel)

function VersionActivity1_2NoteModel:onInit()
	return
end

function VersionActivity1_2NoteModel:reInit()
	return
end

function VersionActivity1_2NoteModel:onReceiveGet121InfosReply(resultCode, proto)
	if resultCode == 0 then
		self:_setData(proto)
	end

	VersionActivity1_2DungeonController.instance:dispatchEvent(VersionActivity1_2DungeonEvent.onReceiveGet121InfosReply, resultCode)
end

function VersionActivity1_2NoteModel:getNotes()
	return self._notes
end

function VersionActivity1_2NoteModel:getNote(id)
	return self._notes and self._notes[id]
end

function VersionActivity1_2NoteModel:setNote(id)
	self._notes = self._notes or {}
	self._notes[id] = id
end

function VersionActivity1_2NoteModel:getBonusFinished(id)
	return self._getBonusStory and self._getBonusStory[id]
end

function VersionActivity1_2NoteModel:_setData(proto)
	self._notes = {}

	for i, v in ipairs(proto.info.notes) do
		self._notes[v] = v
	end

	self._getBonusStory = {}

	for i, v in ipairs(proto.info.getBonusStory) do
		self._getBonusStory[v] = v
	end
end

function VersionActivity1_2NoteModel:onReceiveGet121BonusReply(proto)
	self._getBonusStory = self._getBonusStory or {}
	self._getBonusStory[proto.storyId] = proto.storyId

	VersionActivity1_2DungeonController.instance:dispatchEvent(VersionActivity1_2DungeonEvent.onReceiveGet121BonusReply, proto.storyId)
end

function VersionActivity1_2NoteModel:onReceiveAct121UpdatePush(proto)
	local oldNotes = tabletool.copy(self._notes or {})

	self:_setData(proto)

	for k, v in pairs(self._notes or {}) do
		if not oldNotes[v] then
			local config = lua_activity121_note.configDict[v]
			local tarWave = string.splitToNumber(config.fightId, "#")

			if #tarWave == 0 then
				self.showClueData = self.showClueData or {}

				table.insert(self.showClueData, {
					showPaper = true,
					id = v
				})
			end
		end
	end

	VersionActivity1_2DungeonController.instance:dispatchEvent(VersionActivity1_2DungeonEvent.onReceiveAct121UpdatePush)
end

function VersionActivity1_2NoteModel:getClueData()
	return self.showClueData
end

function VersionActivity1_2NoteModel:isCollectedAllNote()
	local allNoteCount = VersionActivity1_2NoteConfig.instance:getAllNoteCount()
	local curNoteCount = self._notes and tabletool.len(self._notes) or 0

	return allNoteCount <= curNoteCount
end

function VersionActivity1_2NoteModel:isAllBonusFinished()
	local storyList = VersionActivity1_2NoteConfig.instance:getStoryList()

	return tabletool.len(self._getBonusStory) == tabletool.len(storyList)
end

VersionActivity1_2NoteModel.instance = VersionActivity1_2NoteModel.New()

return VersionActivity1_2NoteModel
