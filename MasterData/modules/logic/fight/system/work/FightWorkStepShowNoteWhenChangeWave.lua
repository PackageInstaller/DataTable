-- chunkname: @modules/logic/fight/system/work/FightWorkStepShowNoteWhenChangeWave.lua

module("modules.logic.fight.system.work.FightWorkStepShowNoteWhenChangeWave", package.seeall)

local FightWorkStepShowNoteWhenChangeWave = class("FightWorkStepShowNoteWhenChangeWave", BaseWork)

function FightWorkStepShowNoteWhenChangeWave:onStart()
	local noteConfigList = VersionActivity1_2NoteConfig.instance:getConfigList(FightModel.instance:getFightParam().episodeId)

	if noteConfigList then
		for i, v in ipairs(noteConfigList) do
			local tarWave = string.splitToNumber(v.fightId, "#")

			if #tarWave > 0 and tarWave[2] == FightModel.instance:getCurWaveId() then
				local showNote = not VersionActivity1_2NoteModel.instance:getNote(v.noteId)
				local clueData = VersionActivity1_2NoteModel.instance:getClueData()

				if clueData then
					for index, value in ipairs(clueData) do
						if clueData.id == value.noteId then
							showNote = true

							table.remove(clueData, index)

							break
						end
					end
				end

				if showNote then
					ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
					ViewMgr.instance:openView(ViewName.VersionActivity_1_2_DungeonMapNoteView, {
						showPaper = true,
						id = v.noteId
					})

					return
				end
			end
		end
	end

	self:onDone(true)
end

function FightWorkStepShowNoteWhenChangeWave:_onCloseViewFinish(viewName)
	if viewName == ViewName.VersionActivity_1_2_DungeonMapNoteView then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
		self:onDone(true)
	end
end

function FightWorkStepShowNoteWhenChangeWave:clearWork()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

return FightWorkStepShowNoteWhenChangeWave
