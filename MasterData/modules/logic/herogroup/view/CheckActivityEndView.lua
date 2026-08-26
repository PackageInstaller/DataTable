-- chunkname: @modules/logic/herogroup/view/CheckActivityEndView.lua

module("modules.logic.herogroup.view.CheckActivityEndView", package.seeall)

local CheckActivityEndView = class("CheckActivityEndView", BaseView)

function CheckActivityEndView:onInitView()
	return
end

function CheckActivityEndView:addEvents()
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self.checkIsActivityFight, self)
end

function CheckActivityEndView:removeEvents()
	self.removeEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self.checkIsActivityFight, self)
end

function CheckActivityEndView:checkIsActivityFight(actId)
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

function CheckActivityEndView:_checkAct(actId)
	local status = ActivityHelper.getActivityStatus(actId)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		GameFacade.showMessageBox(MessageBoxIdDefine.EndActivity, MsgBoxEnum.BoxType.Yes, CheckActivityEndView.yesCallback)
	end
end

function CheckActivityEndView.yesCallback()
	ActivityController.instance:dispatchEvent(ActivityEvent.CheckGuideOnEndActivity)
	NavigateButtonsView.homeClick()
end

return CheckActivityEndView
