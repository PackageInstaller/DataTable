-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/hit/ArcadeSkillHitRandomUseSkill.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.hit.ArcadeSkillHitRandomUseSkill", package.seeall)

local ArcadeSkillHitRandomUseSkill = class("ArcadeSkillHitRandomUseSkill", ArcadeSkillHitBase)

function ArcadeSkillHitRandomUseSkill:onCtor()
	local params = self._params

	self._changeName = params[1]
	self._skillGroupList = {}

	for i = 2, #self._params do
		local arr = string.splitToNumber(self._params[i], ",")

		if arr and #arr > 0 then
			table.insert(self._skillGroupList, arr)
		end
	end

	self._skillSetMO = ArcadeGameSkillSetMO.New(0, nil)
	self._waitingUseSkillIdList = {}
end

function ArcadeSkillHitRandomUseSkill:onHit()
	local skillId

	if #self._waitingUseSkillIdList <= 0 and #self._skillGroupList > 0 then
		local idx = math.random(1, #self._skillGroupList)

		tabletool.addValues(self._waitingUseSkillIdList, self._skillGroupList[idx])
	end

	if self._context and self._context.target and #self._waitingUseSkillIdList > 0 then
		local target = self._context.target

		self:addHiter(target)

		skillId = self._waitingUseSkillIdList[1]

		self._skillSetMO:addSkillById(self._waitingUseSkillIdList[1])

		local skillMO = self._skillSetMO:getSkillById(skillId)

		if skillMO then
			local hitLimit = self:getHitLimitCount(skillMO)

			ArcadeGameSkillController.instance:passiveSkillMO(target, skillMO, self._context)

			if hitLimit == -1 or hitLimit ~= self:getHitLimitCount(skillMO) then
				table.remove(self._waitingUseSkillIdList, 1)
			end
		else
			table.remove(self._waitingUseSkillIdList, 1)
			ArcadeGameSkillController.instance:useActiveSkill(target, skillId, self._context)
		end
	end
end

function ArcadeSkillHitRandomUseSkill:onHitPrintLog()
	logNormal(string.format("%s==> 使用技能：%s", self:getLogPrefixStr(), self._waitingUseSkillIdList[1]))
end

function ArcadeSkillHitRandomUseSkill:getHitLimitCount(skillMO)
	local hitLimit = -1

	if skillMO then
		local triggetList = skillMO:getTriggerList()

		if triggetList and #triggetList > 0 then
			hitLimit = 0

			for _, trigger in ipairs(triggetList) do
				local hitBase = trigger:getHitBase()

				if hitBase then
					hitLimit = hitLimit + hitBase:getCurLimit()
				end
			end
		end
	end

	return hitLimit
end

return ArcadeSkillHitRandomUseSkill
