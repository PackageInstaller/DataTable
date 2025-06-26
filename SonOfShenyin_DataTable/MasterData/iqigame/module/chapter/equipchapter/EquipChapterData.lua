-- chunkname: @IQIGame\\Module\\Chapter\\EquipChapter\\EquipChapterData.lua

local equipPassData = require("IQIGame.Module.Chapter.EquipChapter.EquipPassData")
local EquipChapterData = {
	Index = 0,
	cid = 0
}

function EquipChapterData.New(DupPOD, pass)
	local obj = Clone(EquipChapterData)

	obj:RefreshData(DupPOD, pass)

	return obj
end

function EquipChapterData:RefreshData(DupPOD, pass)
	for k, v in pairs(DupPOD) do
		self[k] = v
	end

	self.cid = DupPOD.cid
	self.Index = self:GetCfg().Index
	self.passStatus = {}

	for k, v in pairs(pass) do
		local state

		state = DupPOD.passStatus[v.Id] == nil and 0 or DupPOD.passStatus[v.Id]

		if self.passStatus[v.Id] ~= nil then
			self.passStatus[v.Id]:RefreshData(v.Id, state)
		else
			table.insert(self.passStatus, v.Id, equipPassData.New(v.Id, state))
		end
	end
end

function EquipChapterData:GetCfg()
	return CfgEquipDupChapterTable[self.cid]
end

function EquipChapterData:SubStageIsUnLock()
	return ConditionModule.Check(self:GetCfg().UnlockConditionId)
end

return EquipChapterData
