-- chunkname: @modules/logic/fight/system/work/FightWorkGuideAfterPlay.lua

module("modules.logic.fight.system.work.FightWorkGuideAfterPlay", package.seeall)

local FightWorkGuideAfterPlay = class("FightWorkGuideAfterPlay", FightWorkItem)

function FightWorkGuideAfterPlay:onStart()
	if SkillEditorMgr and SkillEditorMgr.instance.inEditMode then
		self:onDone(true)

		return
	end

	if FightDataHelper.stateMgr.isReplay then
		self:onDone(true)

		return
	end

	if FightGameMgr.stageMgr:getCurStage() == FightStageMgr.StageType.Play then
		self:onDone(true)

		return
	end

	if FightDataHelper.operationDataMgr:isCardOpEnd() then
		self:onDone(true)

		return
	end

	if FightModel.instance:isFinish() then
		self:onDone(true)

		return
	end

	if ViewMgr.instance:isOpen(ViewName.GuideView) then
		self:onDone(true)

		return
	end

	FightMsgMgr.sendMsg(FightMsgId.CheckGuideFightItemPlayerSkillGroup)
	self:onDone(true)
end

return FightWorkGuideAfterPlay
