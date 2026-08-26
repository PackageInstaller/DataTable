-- chunkname: @modules/logic/survival/model/SurvivalCustomFragmentMo.lua

module("modules.logic.survival.model.SurvivalCustomFragmentMo", package.seeall)

local SurvivalCustomFragmentMo = pureTable("SurvivalCustomFragmentMo")

function SurvivalCustomFragmentMo:setData(difficultyId, index)
	self.difficultyId = difficultyId
	self.index = index
	self.cfg = lua_survival_hardness_mod.configDict[self.difficultyId]

	self:refreshTempDiffSelectIds()

	self.customDifficulty = self:loadCustomHard()
	self.customDifficultyDict = {}

	for i, v in ipairs(self.customDifficulty) do
		self.customDifficultyDict[v] = true
	end
end

function SurvivalCustomFragmentMo:loadCustomHard()
	local key = string.format("%s_%s_SurvivalCustomDifficulty", PlayerModel.instance:getPlayinfo().userId, self.difficultyId)
	local localPos = PlayerPrefsHelper.getString(key)
	local hardList = {}

	if not string.nilorempty(localPos) then
		local info = SurvivalModel.instance:getOutSideInfo()
		local list = string.splitToNumber(localPos, "#")

		for _, hardId in ipairs(list) do
			local config = lua_survival_hardness.configDict[hardId]

			if config and config.optional == 1 and info:isUnlockDifficulty(hardId) then
				table.insert(hardList, hardId)
			end
		end
	end

	return hardList
end

function SurvivalCustomFragmentMo:refreshTempDiffSelectIds()
	self.tempDiffSelectIds = {}

	if not string.nilorempty(self.cfg.hardness) then
		local hardness = string.splitToNumber(self.cfg.hardness, "#")

		for _, hardId in pairs(hardness) do
			table.insert(self.tempDiffSelectIds, hardId)
		end
	end
end

function SurvivalCustomFragmentMo:saveCustomHard()
	local list = self.customDifficulty
	local key = string.format("%s_%s_SurvivalCustomDifficulty", PlayerModel.instance:getPlayinfo().userId, self.difficultyId)

	PlayerPrefsHelper.setString(key, table.concat(list, "#"))
end

return SurvivalCustomFragmentMo
