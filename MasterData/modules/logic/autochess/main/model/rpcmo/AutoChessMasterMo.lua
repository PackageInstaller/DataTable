-- chunkname: @modules/logic/autochess/main/model/rpcmo/AutoChessMasterMo.lua

module("modules.logic.autochess.main.model.rpcmo.AutoChessMasterMo", package.seeall)

local AutoChessMasterMo = pureTable("AutoChessMasterMo")

function AutoChessMasterMo:init(data)
	self.id = data.id
	self.teamType = data.teamType
	self.hp = tonumber(data.hp)
	self.uid = tonumber(data.uid)

	self:updateMasterSkill(data.skill)

	self.buffContainer = GameUtil.rpcInfoToMo(data.buffContainer, AutoChessBuffContainerMo)
	self.collectionIds = data.collectionIds
	self.mutationIds = data.mutationIds
	self.loseStreak = data.loseStreak

	if self.id ~= 0 then
		self.config = AutoChessConfig.instance:getLeaderCfg(self.id)
	end
end

function AutoChessMasterMo:updateMasterSkill(skill)
	self.skill = GameUtil.rpcInfoToMo(skill, AutoChessMasterSkillMo)

	AutoChessController.instance:dispatchEvent(AutoChessEvent.UpdateMasterSkill)
end

function AutoChessMasterMo:addHp(value)
	self.hp = self.hp + tonumber(value)
end

function AutoChessMasterMo:getMutationId()
	return self.mutationIds and self.mutationIds[1]
end

function AutoChessMasterMo:isLockFreshMall()
	local buffs = self.buffContainer.buffs

	for i = #buffs, 1, -1 do
		local mo = buffs[i]

		if mo.config then
			local effect = mo.config.effect
			local effects = string.split(effect, "#")

			if effects[1] == AutoChessStrEnum.BuffEffect.MallRefreshDisable then
				return true
			end
		end
	end

	return false
end

return AutoChessMasterMo
