-- chunkname: @modules/logic/versionactivity3_3/arcade/model/game/entity/ArcadeGameMonsterMO.lua

module("modules.logic.versionactivity3_3.arcade.model.game.entity.ArcadeGameMonsterMO", package.seeall)

local ArcadeGameMonsterMO = class("ArcadeGameMonsterMO", ArcadeGameBaseUnitMO)

function ArcadeGameMonsterMO:onCtor(extraParam)
	self.groupId = extraParam and extraParam.groupId
	self.config = self:getCfg()

	local skillSetMO = self:getSkillSetMO()

	if skillSetMO and self.config and not string.nilorempty(self.config.skillIds) then
		local skillIds = string.splitToNumber(self.config.skillIds, "#")

		for _, skillId in ipairs(skillIds) do
			skillSetMO:addSkillById(skillId)
		end
	end
end

function ArcadeGameMonsterMO:getCfg()
	return (ArcadeConfig.instance:getMonsterCfg(self.id, true))
end

function ArcadeGameMonsterMO:getSize()
	if not self._sizeX then
		self._sizeX, self._sizeY = ArcadeConfig.instance:getMonsterSize(self.id)
	end

	return self._sizeX, self._sizeY
end

function ArcadeGameMonsterMO:getRes()
	return ArcadeConfig.instance:getMonsterRes(self.id)
end

function ArcadeGameMonsterMO:getHasCorpse()
	return ArcadeConfig.instance:getMonsterHasCorpse(self.id)
end

function ArcadeGameMonsterMO:getDropList()
	return ArcadeConfig.instance:getMonsterDropList(self.id)
end

function ArcadeGameMonsterMO:getTipIsUseImg()
	return true
end

function ArcadeGameMonsterMO:getImgOffsetArr()
	return (ArcadeConfig.instance:getMonsterIconOffset(self.id))
end

function ArcadeGameMonsterMO:getImgScaleArr()
	return (ArcadeConfig.instance:getMonsterIconScale(self.id))
end

function ArcadeGameMonsterMO:setLockRound(round)
	self._lockRound = tonumber(round) or 0

	if not self._lockRound or self._lockRound < 1 then
		self._lockRound = 0
	end
end

function ArcadeGameMonsterMO:getLockRound()
	return self._lockRound or 0
end

return ArcadeGameMonsterMO
