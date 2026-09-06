-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timecapsule/model/TimeCapsuleModel.lua

module("logic.extensions.timecapsule.model.TimeCapsuleModel", package.seeall)

local TimeCapsuleModel = class("TimeCapsuleModel", BaseListModel)

function TimeCapsuleModel:ctor()
	TimeCapsuleModel.super.ctor(self)
end

function TimeCapsuleModel:onInit()
	TimeCapsuleModel.super.onInit(self)

	self._noteActiveList = {}
end

function TimeCapsuleModel:onReset()
	TimeCapsuleModel.super.onReset(self)
end

function TimeCapsuleModel:setNoteInfo(infos)
	self._noteInfo = {}

	for i, info in ipairs(infos) do
		local noteInfo = TimeCapsuleConfig.instance:getNoteById(info.noteId)

		if info.active then
			noteInfo.noteId = info.noteId
			noteInfo.active = info.active

			table.insert(self._noteInfo, noteInfo)
		else
			local tempList = {}
			local temp = {
				noteId = info.noteId,
				active = info.active,
				icon = noteInfo.icon,
				title = noteInfo.title
			}

			table.insert(tempList, temp)

			for j, j_info in ipairs(self._noteInfo) do
				table.insert(tempList, j_info)
			end

			self._noteInfo = tempList
		end
	end

	self._maxPageNum = math.ceil(#self._noteInfo / 10)
end

function TimeCapsuleModel:getNoteInfoByPage(page)
	local result = {}

	for i = 1 + 10 * (page - 1), page * 10 do
		if self._noteInfo[i] then
			table.insert(result, self._noteInfo[i])
		else
			break
		end
	end

	return result
end

function TimeCapsuleModel:getNoteNum()
	return #self._noteInfo
end

function TimeCapsuleModel:getMaxPageNum()
	return self._maxPageNum or 0
end

function TimeCapsuleModel:setGainDailyPrizeBit(flag)
	self.gainDailyPrizeBit = flag
end

function TimeCapsuleModel:getGainDailyPrizeBit()
	return self.gainDailyPrizeBit
end

function TimeCapsuleModel:setTreasureNoteId(noteId)
	self.treasureNoteId = noteId
end

function TimeCapsuleModel:getTreasureNoteId(noteId)
	return self.treasureNoteId
end

function TimeCapsuleModel:setNoteActive(noteId)
	for i = 1, #self._noteInfo do
		if self._noteInfo[i].noteId == noteId then
			local noteInfo = TimeCapsuleConfig.instance:getNoteById(noteId)

			self._noteInfo[i].icon = noteInfo.icon
			self._noteInfo[i].title = noteInfo.title
			self._noteInfo[i].duoDuoHao = noteInfo.duoDuoHao
			self._noteInfo[i].time = noteInfo.time
			self._noteInfo[i].content = noteInfo.content
			self._noteInfo[i].active = true

			table.insert(self._noteActiveList, noteId)

			break
		end
	end
end

function TimeCapsuleModel:getNoteActiveList()
	return self._noteActiveList
end

function TimeCapsuleModel:clearNoteActiveList()
	self._noteActiveList = {}
end

TimeCapsuleModel.instance = TimeCapsuleModel.New()

return TimeCapsuleModel
