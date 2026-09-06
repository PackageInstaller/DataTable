-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/model/target/TaskTargetFactory.lua

module("logic.extensions.task.model.target.TaskTargetFactory", package.seeall)

TaskTargetFactory = {}

function TaskTargetFactory.createTaskTarget(taskStep, target)
	local targetType = target.targetType

	if targetType == TaskConst.TSTEP_TARGET_NONE then
		return TaskTargetBase.New(taskStep, target)
	elseif targetType == TaskConst.TSTEP_TARGET_BATTLE_NPC then
		return TaskTargetBattleNpc.New(taskStep, target)
	elseif targetType == TaskConst.TSTEP_TARGET_CHAT_NPC then
		return TaskTargetChatNpc.New(taskStep, target)
	elseif targetType == TaskConst.TSTEP_TARGET_SEARCH then
		return TaskTargetSearch.New(taskStep, target)
	elseif targetType == TaskConst.TSTEP_TARGET_COLLECT then
		return TaskTargetCollect.New(taskStep, target)
	elseif targetType == TaskConst.TSTEP_TARGET_USERACTION then
		return TaskTargeUserAction.New(taskStep, target)
	elseif targetType == TaskConst.TSTEP_TARGET_COMMITITEM then
		return TaskTargetCommitItem.New(taskStep, target)
	elseif targetType == TaskConst.TSTEP_TARGET_PVE then
		return TaskTargetPve.New(taskStep, target)
	elseif targetType == TaskConst.TSTEP_TARGET_HATCHEGG then
		return TaskTargetHatchEgg.New(taskStep, target)
	elseif targetType == TaskConst.TSTEP_TARGET_CATCHMONSTER then
		return TaskTargetCatchMonster.New(taskStep, target)
	elseif targetType == TaskConst.TSTEP_TARGET_CATCHSOURCEMON then
		return TaskTargetCatchSourceMon.New(taskStep, target)
	elseif targetType == TaskConst.TSTEP_TARGET_SOURCEMONLEVEL then
		return TaskTargetSourceMonLevel.New(taskStep, target)
	elseif targetType == TaskConst.TSTEP_TARGET_STARGODLEVEL then
		return TaskTargetStarGodLevel.New(taskStep, target)
	elseif targetType == TaskConst.TSTEP_TARGET_GENIUSTIMES then
		return TaskTargetGeniusTimes.New(taskStep, target)
	elseif targetType == TaskConst.TSTEP_TARGET_DIAMONDACTIVITY then
		return TaskTargetDiamondActivity.New(taskStep, target)
	elseif targetType == TaskConst.TSTEP_TARGET_PETLEVEL then
		return TaskTargetPetLevel.New(taskStep, target)
	elseif targetType == TaskConst.TSTEP_TARGET_COLL_PETS then
		return TaskTargetCollPets.New(taskStep, target)
	elseif targetType == TaskConst.TSTEP_TARGET_JJC then
		return TaskTargetJJC.New(taskStep, target)
	elseif targetType == TaskConst.TSTEP_TARGET_GENIES then
		return TaskTargetPetGenius.New(taskStep, target)
	elseif targetType == TaskConst.TSTEP_TARGET_PETRECORD then
		return TaskTargetPetRecord.New(taskStep, target)
	elseif targetType == TaskConst.TSTEP_TARGET_STARGODHUNTTIMERS then
		return TaskTargetStarGodHuntTimes.New(taskStep, target)
	elseif targetType == TaskConst.TSTEP_TARGET_STARGODQUALITY then
		return TaskTargetStarGodQuality.New(taskStep, target)
	elseif targetType == TaskConst.TSTEP_TARGET_INNEREVOLVE then
		return TaskTargetInnerEvolve.New(taskStep, target)
	elseif targetType == TaskConst.TSTEP_TARGET_GENIES_LEVEL then
		return TaskTargetGeniusLevel.New(taskStep, target)
	elseif targetType == TaskConst.TSTEP_TARGET_SANXIAO then
		return TaskTargetSanXiao.New(taskStep, target)
	elseif targetType == TaskConst.TSTEP_TARGET_ONLINEGIFT then
		return TaskTargetOnLineGift.New(taskStep, target)
	elseif targetType == TaskConst.TSTEP_TARGET_EXPEDITIONSTEP then
		return TaskTargetExpeditionStep.New(taskStep, target)
	elseif targetType == TaskConst.TSTEP_TARGET_XIAONUOBUYTIMES then
		return TaskTargetXiaoNuoBuyTimes.New(taskStep, target)
	elseif targetType == TaskConst.TSTEP_TARGET_BREAKFMTTIMES then
		return TaskTargetBreakFormationTimes.New(taskStep, target)
	elseif targetType == TaskConst.TSTEP_TARGET_ACHIEVEMENTDATA then
		return TaskTargetAchievement.New(taskStep, target)
	elseif targetType == TaskConst.TSTEP_TARGET_EQUIPMENTTIMES then
		return TaskTargetEquipTimes.New(taskStep, target)
	elseif targetType == TaskConst.TSTEP_TARGET_EQUIPMENTLEVELUPTIMES then
		return TaskTargetEquipTimes.New(taskStep, target)
	elseif targetType == TaskConst.TSTEP_TARGET_EQUIPSTARGODTIMES then
		return TaskTargetStarGodEquipTimes.New(taskStep, target)
	elseif targetType == TaskConst.TSTEP_TARGET_DAILYACTIVITY then
		return TaskTargetDailyActivity.New(taskStep, target)
	else
		return TaskTargetBase.New(taskStep, target)
	end
end

return TaskTargetFactory
