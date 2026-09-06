-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/model/GuideBranchFactory.lua

module("logic.extensions.guide.model.branch.GuideBranchFactory", package.seeall)

local GuideBranchFactory = class("GuideBranchFactory")

function GuideBranchFactory.createBranch(branch, currGuieId)
	printInfo("createBranch:" .. branch)

	if branch == GuideConst.BRANCH_PET then
		return GuideBranchPet.New(branch, currGuieId)
	elseif branch == GuideConst.BRANCH_MAIN then
		return GuideBranchBase.New(branch, currGuieId)
	elseif branch == GuideConst.BRANCH_CONTRACT then
		return GuideBranchBase.New(branch, currGuieId)
	elseif branch == GuideConst.BRANCH_MISSION then
		return GuideBranchBase.New(branch, currGuieId)
	elseif branch == GuideConst.BRANCH_OPEN_IDLEGAME then
		return GuideBranchBase.New(branch, currGuieId)
	elseif branch == GuideConst.BRANCH_PAIQIAN_64 then
		return GuideBranchBase.New(branch, currGuieId)
	elseif branch == GuideConst.BRANCH_CATCHPET then
		return GuideBranchCatchPet.New(branch, currGuieId)
	elseif branch == GuideConst.BRANCH_TASK then
		return GuideBranchForceDrag.New(branch, currGuieId)
	elseif branch == GuideConst.BRANCH_BATTLE_GAS then
		return GuideBranchBattleGas.New(branch, currGuieId)
	elseif branch == GuideConst.BRANCH_Effect then
		return GuideBranchEffect.New(branch, currGuieId)
	elseif branch == GuideConst.BRANCH_MISSION_POP then
		return GuideBranchForceDrag.New(branch, currGuieId)
	elseif branch == GuideConst.BRANCH_DRAG_BAIHU then
		return GuideBranchForceDrag.New(branch, currGuieId)
	elseif branch == GuideConst.BRANCH_Exp then
		return GuideBranchExp.New(branch, currGuieId)
	elseif branch == GuideConst.BRANCH_Qilin then
		return GuideBranchQilin.New(branch, currGuieId)
	elseif branch == GuideConst.BRANCH_TIANBINGSHENHU_2 then
		return GuideBranchGoFirstStep.New(branch, currGuieId)
	elseif branch == GuideConst.BRANCH_DRESS_GUIDE then
		return GuideBranchDress.New(branch, currGuieId)
	elseif branch == GuideConst.BRANCH_TASK_START_26 or branch == GuideConst.BRANCH_TASK_START_27 then
		return GuideBranchTaskStart.New(branch, currGuieId)
	elseif branch == GuideConst.BRANCH_BATTLE_RESTRICTION then
		return GuideBranchBattleRestriction.New(branch, currGuieId)
	elseif branch == GuideConst.BRANCH_TASK_START_28 or branch == GuideConst.BRANCH_TASK_START_30 or branch == GuideConst.BRANCH_TASK_START_32 then
		return GuideBranchForceDrag.New(branch, currGuieId)
	elseif branch == GuideConst.BRANCH_WARRIORTOWER_EXP then
		return GuideBranchExpPool.New(branch, currGuieId)
	elseif branch == GuideConst.BRANCH_FIRST_BUZHEN then
		return GuideBranchForceDrag.New(branch, currGuieId)
	elseif branch == GuideConst.BRANCH_FIRST_TASK then
		return GuideBranchFirstTask.New(branch, currGuieId)
	elseif branch == GuideConst.BRANCH_BATTLE_SPEEDX_78 then
		return GuideBranchFunOpenBattle.New(branch, currGuieId)
	elseif branch == GuideConst.BRANCH__97 then
		return GuideBranchEnterZooScene.New(branch, currGuieId)
	elseif branch == GuideConst.BRANCH_BATTLE_130 then
		return GuideBranchFunOpenBattle.New(branch, currGuieId)
	elseif branch == GuideConst.BRANCH_BATTLE_131 then
		return GuideBranchFunOpenBattle.New(branch, currGuieId)
	else
		return GuideBranchFunOpen.New(branch, currGuieId)
	end
end

return GuideBranchFactory
