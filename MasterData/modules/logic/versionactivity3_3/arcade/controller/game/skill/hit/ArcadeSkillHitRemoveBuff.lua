-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/hit/ArcadeSkillHitRemoveBuff.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.hit.ArcadeSkillHitRemoveBuff", package.seeall)

local ArcadeSkillHitRemoveBuff = class("ArcadeSkillHitRemoveBuff", ArcadeSkillHitBase)

function ArcadeSkillHitRemoveBuff:onCtor()
	local params = self._params

	self._changeName = params[1]
	self._skillTargetId = tonumber(params[2])
	self._buffId = tonumber(params[3])
	self._skillTargetBase = ArcadeSkillFactory.instance:createSkillTargetById(self._skillTargetId)
end

function ArcadeSkillHitRemoveBuff:onHit()
	if self._skillTargetBase then
		self._skillTargetBase:findByContext(self._context)

		local unitMOList = self._skillTargetBase:getTargetList()

		self:addHiterList(unitMOList)

		local buffIdList = {
			self._buffId
		}

		for _, unitMO in ipairs(unitMOList) do
			ArcadeGameController.instance:removeEntityBuffs(buffIdList, unitMO:getEntityType(), unitMO:getUid())
		end
	end
end

function ArcadeSkillHitRemoveBuff:onHitPrintLog()
	local unitMOList = self._skillTargetBase:getTargetList()

	if unitMOList and #unitMOList > 0 then
		local target = unitMOList[1]

		logNormal(string.format("%s ==> 添加目标一个特定BUFF:%s  type:%s id:%s uid:%s", self:getLogPrefixStr(), self._buffId, target:getEntityType(), target:getId(), target:getUid()))
	end
end

return ArcadeSkillHitRemoveBuff
