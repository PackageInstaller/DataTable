-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/target/ArcadeSkillTargetRandom.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.target.ArcadeSkillTargetRandom", package.seeall)

local ArcadeSkillTargetRandom = class("ArcadeSkillTargetRandom", ArcadeSkillTargetBase)

function ArcadeSkillTargetRandom:onCtor()
	self._tempMoList = {}
	self._randomNum = 1
end

function ArcadeSkillTargetRandom:onConfigParams()
	if self._effectParams and #self._effectParams >= 1 then
		local params = self._effectParams

		self._randomNum = math.max(1, tonumber(params[1]))
	end
end

function ArcadeSkillTargetRandom:onFindTarget()
	local targetNum = self._randomNum

	self:clearList(self._tempMoList)

	if self._cfgNeedTargetTypeDict then
		local entityType = next(self._cfgNeedTargetTypeDict)

		if not entityType then
			return
		end

		local unitMOList = ArcadeGameModel.instance:getEntityMOList(entityType)

		if not unitMOList or #unitMOList < 1 then
			return
		end

		for _, unitMO in ipairs(unitMOList) do
			local gridX, gridY = unitMO:getGridPos()
			local isOutSide = ArcadeGameHelper.isOutSideRoom(gridX, gridY)
			local isAlive = true
			local isCanDead = unitMO:getIsCanDead()

			if isCanDead then
				local isDead = unitMO:getIsDead()
				local hp = unitMO:getHp()

				isAlive = not isDead and hp > 0
			end

			if not isOutSide and isAlive then
				self._tempMoList[#self._tempMoList + 1] = unitMO
			end
		end

		RoomHelper.randomArray(self._tempMoList)

		for i = 1, #self._tempMoList do
			if i <= targetNum then
				self:addTarget(self._tempMoList[i])
			else
				break
			end
		end
	end
end

function ArcadeSkillTargetRandom:getRandomNum()
	return self._randomNum
end

return ArcadeSkillTargetRandom
