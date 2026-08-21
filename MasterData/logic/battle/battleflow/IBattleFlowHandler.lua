-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/IBattleFlowHandler.lua

module("logic.battle.battleflow.IBattleFlowHandler", package.seeall)

local IBattleFlowHandler = class("IBattleFlowHandler")

function IBattleFlowHandler:handleInit()
	return
end

function IBattleFlowHandler:handleEnterBattle()
	return
end

function IBattleFlowHandler:fillResourcePathList(resPathList)
	return
end

function IBattleFlowHandler:buildBattleFieldInfo(originalInfo)
	return
end

function IBattleFlowHandler:handleEnterBattleFinish()
	return
end

function IBattleFlowHandler:handleBeforeInitCommands()
	return
end

function IBattleFlowHandler:createBeforeStartBattleWork()
	return
end

function IBattleFlowHandler:handleBattleStart()
	return
end

function IBattleFlowHandler:createBeforeEndBattleWork()
	return
end

function IBattleFlowHandler:backupCalculateModel()
	return
end

function IBattleFlowHandler:setupCalculateModel()
	return
end

function IBattleFlowHandler:createCalculateWork()
	return
end

function IBattleFlowHandler:createExitBattleWork()
	return
end

function IBattleFlowHandler:createAfterExitBattleWork()
	return
end

function IBattleFlowHandler:handleExitBattleFinish()
	return
end

function IBattleFlowHandler:isSupportRestart()
	return
end

function IBattleFlowHandler:isSupportUndo()
	return
end

function IBattleFlowHandler:userRequestRestart(restartType)
	return
end

function IBattleFlowHandler:sendRestartRequest(restartType)
	return
end

function IBattleFlowHandler:isEnableCampAdjustment()
	return
end

function IBattleFlowHandler:isShowBlackLoading()
	return false
end

function IBattleFlowHandler:getEntityCountLimitOfCamp(campId)
	return 0
end

function IBattleFlowHandler:getSortPriorityCareer()
	return 0
end

function IBattleFlowHandler:getMaxRoundCount()
	return 10
end

function IBattleFlowHandler:fillAvailableHeroMOList(availableHeroMOList)
	return
end

function IBattleFlowHandler:fillForbiddenCareerList(forbiddenCareerList)
	return
end

function IBattleFlowHandler:fillForbiddenCampList(forbiddenCampList)
	return
end

function IBattleFlowHandler:fillForbiddenRoleList(forbiddenRoleList)
	return
end

function IBattleFlowHandler:fillBornUnionIndexListOfCamp(campId, bornUnionIndexList, bornDirectionList)
	return
end

function IBattleFlowHandler:fillLockedCharacterCodeListOfCamp(campId, lockedCharacterCodeList)
	return
end

function IBattleFlowHandler:fillAssistantCharacterCodeListOfCamp(campId, assistantCharacterCodeList)
	return
end

function IBattleFlowHandler:fillCameraWalkUnionIndexListOfCamp(campId, walkUnionIndexList)
	return
end

function IBattleFlowHandler:fillForbiddenSkillTypeList(forbiddenSkillTypeList)
	return
end

function IBattleFlowHandler:fillForbiddenSkillPurposeList(forbiddenSkillPurposeList)
	return
end

function IBattleFlowHandler:getForbiddenMoveStatus()
	return false
end

function IBattleFlowHandler:getForbiddenAutoStatus()
	return false
end

function IBattleFlowHandler:getForbiddenSkillStrengthenStatus()
	return false
end

function IBattleFlowHandler:fillKillEntityCodeListOfCamp(killEntityCodeList)
	return
end

function IBattleFlowHandler:fillProtectEntityCodeListOfCamp(protectEntityCodeList)
	return
end

function IBattleFlowHandler:fillExtensionViewClassList(extensionViewClassList)
	return
end

function IBattleFlowHandler:fillTrialCharacterCodeList(trialHeroList)
	return
end

function IBattleFlowHandler:getReadyTimeLimit()
	return
end

function IBattleFlowHandler:fillTeamInfoMOList(teamInfoMOList)
	return
end

return IBattleFlowHandler
