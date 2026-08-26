-- chunkname: @modules/logic/versionactivity3_6/yami/model/V3a6YaMiMissionMO.lua

module("modules.logic.versionactivity3_6.yami.model.V3a6YaMiMissionMO", package.seeall)

local V3a6YaMiMissionMO = class("V3a6YaMiMissionMO")

function V3a6YaMiMissionMO:initMo(co)
	self.co = co
	self.id = co.id
	self._isFinish = false

	local unlockCondition = co.unlockCondition

	self._unlockCondition = {}

	if not string.nilorempty(unlockCondition) then
		local split = string.split(unlockCondition, "#")

		self._unlockCondition[split[1]] = split[2]
	end
end

function V3a6YaMiMissionMO:refreshInfo(info)
	if info then
		self._progress = info.progress or 0
	end

	self._isFinish = info and info.isFinish
end

function V3a6YaMiMissionMO:onFinish()
	self._isFinish = true
end

function V3a6YaMiMissionMO:isFinished()
	return self._isFinish
end

function V3a6YaMiMissionMO:isUnlock()
	local _, curLevel = V3a6YaMiModel.instance:getLevelExp()

	if not self._unlockLevel then
		local unlockLevel = self._unlockCondition[V3a6YaMiEnum.UnlockCondition.ResearchLevel]

		self._unlockLevel = unlockLevel and tonumber(unlockLevel) or 0
	end

	if curLevel >= self._unlockLevel then
		return true
	end
end

return V3a6YaMiMissionMO
