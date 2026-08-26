-- chunkname: @modules/logic/survival/model/shelter/SurvivalShelterModel.lua

module("modules.logic.survival.model.shelter.SurvivalShelterModel", package.seeall)

local SurvivalShelterModel = class("SurvivalShelterModel", BaseModel)

function SurvivalShelterModel:onInit()
	self._weekInfo = nil
	self._bossFightId = nil
	self._needShowDestroy = nil
	self._needShowBossInvade = nil
end

function SurvivalShelterModel:reInit()
	self:onInit()
end

function SurvivalShelterModel:setWeekData(data, isNewWeek, extendScore)
	self._weekInfo = self._weekInfo or SurvivalShelterWeekMo.New()

	self._weekInfo:init(data, extendScore)

	self._playerMo = self._playerMo or SurvivalShelterPlayerMo.New()

	self._playerMo:init(data.shelterMapId, isNewWeek)
	SurvivalEquipRedDotHelper.instance:checkRed()
end

function SurvivalShelterModel:getWeekInfo()
	return self._weekInfo
end

function SurvivalShelterModel:getPlayerMo()
	return self._playerMo
end

function SurvivalShelterModel:addExRule(ruleList)
	ruleList = ruleList or {}

	local weekInfo = self:getWeekInfo()

	if weekInfo then
		local worldLv = weekInfo:getAttr(SurvivalEnum.AttrType.WorldLevel)
		local str = SurvivalConfig.instance:getConstValue(SurvivalEnum.ConstId.FightExRule)

		if not string.nilorempty(str) then
			local dict = GameUtil.splitString2(str, true)

			for _, arr in ipairs(dict) do
				if arr[1] == worldLv then
					table.insert(ruleList, {
						arr[2],
						arr[3]
					})
				end
			end
		end
	end

	return ruleList
end

function SurvivalShelterModel:haveBoss()
	if self._weekInfo then
		local fight = self._weekInfo:getMonsterFight()

		return fight:isFighting()
	else
		return true
	end

	return false
end

function SurvivalShelterModel:setNeedShowFightSuccess(state, fightId)
	self._needShowDestroy = state

	if fightId ~= nil then
		self._bossFightId = fightId
	end
end

function SurvivalShelterModel:getNeedShowFightSuccess()
	return self._needShowDestroy, self._bossFightId
end

function SurvivalShelterModel:setNeedShowBossInvade(isNeedShow)
	self._needShowBossInvade = isNeedShow
end

function SurvivalShelterModel:getNeedShowBossInvade()
	return self._needShowBossInvade
end

SurvivalShelterModel.instance = SurvivalShelterModel.New()

return SurvivalShelterModel
