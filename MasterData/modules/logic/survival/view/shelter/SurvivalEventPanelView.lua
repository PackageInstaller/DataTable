-- chunkname: @modules/logic/survival/view/shelter/SurvivalEventPanelView.lua

module("modules.logic.survival.view.shelter.SurvivalEventPanelView", package.seeall)

local SurvivalEventPanelView = class("SurvivalEventPanelView", BaseView)

function SurvivalEventPanelView:onInitView()
	self.btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
end

function SurvivalEventPanelView:addEvents()
	self.btnClose:AddClickListener(self.onClickBtnClose, self)
end

function SurvivalEventPanelView:removeEvents()
	self.btnClose:RemoveClickListener()
end

function SurvivalEventPanelView:onClickBtnClose()
	self:closeThis()

	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local taskConfig = SurvivalConfig.instance:getTaskCo(self.moduleId, self.taskId)

	if not taskConfig then
		return
	end

	local eventID = taskConfig.eventID

	ViewMgr.instance:openView(ViewName.ShelterMapEventView, {
		moduleId = self.moduleId,
		taskConfig = taskConfig,
		eventID = eventID
	})
end

function SurvivalEventPanelView:onOpen()
	self:refreshParam()
	self:refreshView()
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_gudu_win)
end

function SurvivalEventPanelView:onUpdateParam()
	self:refreshParam()
	self:refreshView()
end

function SurvivalEventPanelView:refreshParam()
	self.moduleId = self.viewParam.moduleId
	self.taskId = self.viewParam.taskId
end

function SurvivalEventPanelView:refreshView()
	return
end

return SurvivalEventPanelView
