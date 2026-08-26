-- chunkname: @modules/logic/sp02/atomic/model/AtomicMO.lua

module("modules.logic.sp02.atomic.model.AtomicMO", package.seeall)

local AtomicMO = pureTable("AtomicMO")

function AtomicMO:init()
	self.talentMo = AtomicTalentMO.New()

	self.talentMo:init()

	self.unlockLibraryDict = {}
end

function AtomicMO:updateInfo(info)
	self.talentMo:updateInfo(info.talentInfo)
	self:updateLibraryInfo(info.libraryInfo)
end

function AtomicMO:updateLibraryInfo(info)
	self.unlockLibraryDict = {}

	self:unlockLibraryList(info.unlockLibraryIds)
end

function AtomicMO:unlockLibraryList(list)
	for i = 1, #list do
		local id = list[i]

		self.unlockLibraryDict[id] = true
	end
end

function AtomicMO:isLibraryUnlock(id)
	return self.unlockLibraryDict[id] or false
end

function AtomicMO:getTalentInfo()
	return self.talentMo
end

return AtomicMO
