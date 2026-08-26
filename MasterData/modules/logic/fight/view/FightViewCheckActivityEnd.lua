-- chunkname: @modules/logic/fight/view/FightViewCheckActivityEnd.lua

module("modules.logic.fight.view.FightViewCheckActivityEnd", package.seeall)

local FightViewCheckActivityEnd = class("FightViewCheckActivityEnd", BaseView)

function FightViewCheckActivityEnd:onInitView()
	return
end

function FightViewCheckActivityEnd:addEvents()
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self.checkIsActivityFight, self)
end

function FightViewCheckActivityEnd:removeEvents()
	self.removeEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self.checkIsActivityFight, self)
end

function FightViewCheckActivityEnd:checkIsActivityFight(actId)
	if string.nilorempty(actId) or actId == 0 then
		return
	end

	local fightParam = FightModel.instance:getFightParam()
	local chapterId = fightParam.chapterId
	local chapterCo = DungeonConfig.instance:getChapterCO(chapterId)

	if DungeonController.closePreviewChapterViewActEnd(actId, chapterId) then
		self:_checkAct(actId)

		return
	end

	if not chapterCo or chapterCo.actId ~= actId then
		return
	end

	self:_checkAct(actId)
end

function FightViewCheckActivityEnd:_checkAct(actId)
	local status = ActivityHelper.getActivityStatus(actId)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		GameFacade.showMessageBox(MessageBoxIdDefine.EndActivity, MsgBoxEnum.BoxType.Yes, FightViewCheckActivityEnd.yesCallback)
	end
end

function FightViewCheckActivityEnd.yesCallback()
	ActivityController.instance:dispatchEvent(ActivityEvent.CheckGuideOnEndActivity)

	if FightDataHelper.fieldMgr:isDouQuQu() then
		FightSystem.instance:dispose()
		FightModel.instance:clearRecordMO()
		FightController.instance:exitFightScene()

		return
	end

	FightRpc.instance:sendEndFightRequest(true)
end

return FightViewCheckActivityEnd
