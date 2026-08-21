-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/battleflow/ClimbingTowerDarkSideBattleFlow.lua

module("logic.extensions.dungeon.battleflow.ClimbingTowerDarkSideBattleFlow", package.seeall)

local ClimbingTowerDarkSideBattleFlow = class("ClimbingTowerDarkSideBattleFlow", DungeonBattleFlowBase)

function ClimbingTowerDarkSideBattleFlow:isSupportRestart()
	return true
end

function ClimbingTowerDarkSideBattleFlow:userRequestRestart(restartType)
	local canRestart = true
	local lastBattleInfo = ClimbingTowerDarkModel.instance:getLastDungeonBattleInfo()
	local round = lastBattleInfo.darkRound

	if round then
		local roundCO = ClimbingTowerConfig.instance:getDarkRoundCO(round)

		if roundCO and roundCO:isExpired() then
			canRestart = false
		end
	else
		canRestart = false
	end

	if canRestart then
		ClimbingTowerDarkSideBattleFlow.super.userRequestRestart(self, restartType)
	else
		FloatWordMgr.instance:show(lang("tip_dark_not_work"))
	end
end

function ClimbingTowerDarkSideBattleFlow:sendRestartRequest(restartType)
	if restartType == BattleEnum.RestartType.TONEXT then
		local gamePlay = self.model:getGamePlay()

		if ClimbingTowerController.instance:startNextBattleLevel(self:getPassId(), gamePlay) then
			return
		end
	end

	ClimbingTowerDarkSideBattleFlow.super.sendRestartRequest(self, restartType)
end

function ClimbingTowerDarkSideBattleFlow:fillExtensionViewClassList(extensionViewClassList)
	return
end

function ClimbingTowerDarkSideBattleFlow:fillForbiddenCareerList(forbiddenCareerList)
	local dungeonCode = BattleEnterUtil.getCurrentDungeonCode()
	local dungeonMO = ClimbingTowerDarkModel.instance:getDungeonMoById(dungeonCode)
	local darkTowerCfgId = dungeonMO:getTowerCfgId()
	local darkCO = ClimbingTowerConfig.instance:getDarkTowerCO(darkTowerCfgId)

	if darkCO and darkCO:getCareerLimitCount() > 0 then
		local careerLimitMap = darkCO:getCareerLimitMap()

		for career, _ in pairs(careerLimitMap) do
			table.insert(forbiddenCareerList, career)
		end
	end
end

function ClimbingTowerDarkSideBattleFlow:fillForbiddenCampList(forbiddenCampList)
	local dungeonCode = BattleEnterUtil.getCurrentDungeonCode()
	local dungeonMO = ClimbingTowerDarkModel.instance:getDungeonMoById(dungeonCode)
	local darkTowerCfgId = dungeonMO:getTowerCfgId()
	local darkCO = ClimbingTowerConfig.instance:getDarkTowerCO(darkTowerCfgId)

	if darkCO and darkCO:getCampLimitCount() > 0 then
		local campLimitMap = darkCO:getCampLimitMap()

		for camp, _ in pairs(campLimitMap) do
			table.insert(forbiddenCampList, camp)
		end
	end
end

function ClimbingTowerDarkSideBattleFlow:fillForbiddenRoleList(forbiddenRoleList)
	local dungeonCode = BattleEnterUtil.getCurrentDungeonCode()
	local dungeonMO = ClimbingTowerDarkModel.instance:getDungeonMoById(dungeonCode)
	local darkTowerCfgId = dungeonMO:getTowerCfgId()
	local darkCO = ClimbingTowerConfig.instance:getDarkTowerCO(darkTowerCfgId)

	if darkCO and darkCO:getRoleLimitCount() > 0 then
		local roleLimitMap = darkCO:getRoleLimitMap()

		for roleId, _ in pairs(roleLimitMap) do
			table.insert(forbiddenRoleList, roleId)
		end
	end
end

function ClimbingTowerDarkSideBattleFlow:getEntityCountLimitOfCamp(campId)
	return ClimbingTowerDarkSideBattleFlow.super.getEntityCountLimitOfCamp(self, campId)
end

function ClimbingTowerDarkSideBattleFlow:fillAvailableHeroMOList(availableHeroMOList)
	ClimbingTowerDarkSideBattleFlow.super.fillAvailableHeroMOList(self, availableHeroMOList)
end

return ClimbingTowerDarkSideBattleFlow
