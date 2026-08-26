-- chunkname: @modules/logic/teach/model/TeachNoteInfoMo.lua

module("modules.logic.teach.model.TeachNoteInfoMo", package.seeall)

local TeachNoteInfoMo = pureTable("TeachNoteInfoMo")

function TeachNoteInfoMo:ctor()
	self.unlockIds = {}
	self.getRewardIds = {}
	self.getFinalReward = false
	self.openIds = {}
end

function TeachNoteInfoMo:init(info)
	self:update(info)
end

function TeachNoteInfoMo:update(info)
	self.unlockIds = self:_getUnlockTopicIds(info.unlockIds)
	self.getRewardIds = info.getRewardIds
	self.getFinalReward = info.getFinalReward
	self.openIds = self:_getUnlockTopicIds(info.openIds)
end

function TeachNoteInfoMo:_getUnlockTopicIds(infos)
	local ids = {}

	for _, info in pairs(infos) do
		local lvCos = TeachNoteConfig.instance:getInstructionLevelCos()

		for _, lv in pairs(lvCos) do
			if info == lv.episodeId then
				table.insert(ids, lv.id)
			end
		end
	end

	return ids
end

return TeachNoteInfoMo
