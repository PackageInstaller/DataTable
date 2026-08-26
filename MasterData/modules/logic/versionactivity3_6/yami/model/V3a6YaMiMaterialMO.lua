-- chunkname: @modules/logic/versionactivity3_6/yami/model/V3a6YaMiMaterialMO.lua

module("modules.logic.versionactivity3_6.yami.model.V3a6YaMiMaterialMO", package.seeall)

local V3a6YaMiMaterialMO = class("V3a6YaMiMaterialMO")

function V3a6YaMiMaterialMO:initMo(co)
	self.co = co

	local unlockCondition = co.unlockCondition

	self._unlockCondition = {}

	if not string.nilorempty(unlockCondition) then
		local split = string.split(unlockCondition, "#")

		self._unlockCondition[split[1]] = split[2]
	end
end

function V3a6YaMiMaterialMO:getUnlockLevel()
	if not self._unlockLevel then
		local unlockLevel = self._unlockCondition[V3a6YaMiEnum.UnlockCondition.ResearchLevel]

		self._unlockLevel = unlockLevel and tonumber(unlockLevel) or 0
	end

	return self._unlockLevel
end

function V3a6YaMiMaterialMO:isUnlock()
	local _, curLevel = V3a6YaMiModel.instance:getLevelExp()
	local unlockLevel = self:getUnlockLevel()

	if unlockLevel <= curLevel then
		return true
	end
end

function V3a6YaMiMaterialMO:isNewUnlock()
	local isUnlock = self:isUnlock()

	if not isUnlock then
		return
	end

	if GameUtil.playerPrefsGetNumberByUserId(V3a6YaMiEnum.PrefsKey.UnlockMaterial .. self.co.id, 0) == 0 then
		return true
	end
end

function V3a6YaMiMaterialMO:cancelNewUnlock()
	GameUtil.playerPrefsSetNumberByUserId(V3a6YaMiEnum.PrefsKey.UnlockMaterial .. self.co.id, 1)
end

return V3a6YaMiMaterialMO
