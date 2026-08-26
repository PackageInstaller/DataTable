-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/hit/ArcadeSkillHitAttackTargetChange.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.hit.ArcadeSkillHitAttackTargetChange", package.seeall)

local ArcadeSkillHitAttackTargetChange = class("ArcadeSkillHitAttackTargetChange", ArcadeSkillHitBase)
local CHANGE_MODE = {
	Add = "add",
	Replace = "replace"
}

function ArcadeSkillHitAttackTargetChange:onCtor()
	local params = self._params

	self._changeName = params[1]
	self._skillTargetId = tonumber(params[2])
	self._skillTargetBase = ArcadeSkillFactory.instance:createSkillTargetById(self._skillTargetId)
	self._changeMode = params[3] or CHANGE_MODE.Replace
end

function ArcadeSkillHitAttackTargetChange:replace()
	local hitterList = self._context.hiterList

	for i = #hitterList, 1, -1 do
		if self._skillTargetBase:isHasTarget(hitterList[i]) then
			table.remove(hitterList, i)
		end
	end

	local newTargetList = self._skillTargetBase:getTargetList()

	tabletool.addValues(hitterList, newTargetList)
end

function ArcadeSkillHitAttackTargetChange:add()
	local existDict = {}
	local hitterList = self._context.hiterList

	for _, hitter in ipairs(hitterList) do
		local entityType = hitter:getEntityType()
		local uid = hitter:getUid()
		local typeDict = ArcadeGameHelper.checkDictTable(existDict, entityType)

		typeDict[uid] = true
	end

	local newTargetList = self._skillTargetBase:getTargetList()

	for _, target in ipairs(newTargetList) do
		local entityType = target:getEntityType()
		local uid = target:getUid()
		local typeDict = existDict[entityType]

		if not typeDict or not typeDict[uid] then
			hitterList[#hitterList + 1] = target
		end
	end
end

function ArcadeSkillHitAttackTargetChange:onHit()
	if not self._skillTargetBase or not self._context.hiterList then
		return
	end

	self._skillTargetBase:findByContext(self._context)

	local newTargetList = self._skillTargetBase:getTargetList()

	self:addHiterList(newTargetList)

	local handler = self[self._changeMode]

	if handler then
		handler(self)
	else
		logError(string.format("ArcadeSkillHitAttackTargetChange:onHit error, no handler: %s", self._changeMode))
	end
end

function ArcadeSkillHitAttackTargetChange:onHitPrintLog()
	logNormal(string.format("%s 攻击目标选择器修正 targetId:%s mode:%s", self:getLogPrefixStr(), self._skillTargetId, self._changeMode))
end

return ArcadeSkillHitAttackTargetChange
