-- chunkname: @modules/logic/survival/view/shelter/ShelterTaskDecreeTaskView.lua

module("modules.logic.survival.view.shelter.ShelterTaskDecreeTaskView", package.seeall)

local ShelterTaskDecreeTaskView = class("ShelterTaskDecreeTaskView", BaseView)

function ShelterTaskDecreeTaskView:onInitView()
	self.tabList = {}
end

function ShelterTaskDecreeTaskView:addEvents()
	self.addEventCb(self, SurvivalController.instance, SurvivalEvent.OnTaskViewUpdate, self.refreshView, self)
end

function ShelterTaskDecreeTaskView:removeEvents()
	self.removeEventCb(self, SurvivalController.instance, SurvivalEvent.OnTaskViewUpdate, self.refreshView, self)
end

function ShelterTaskDecreeTaskView:onOpen()
	return
end

function ShelterTaskDecreeTaskView:refreshView(taskType)
	return
end

function ShelterTaskDecreeTaskView:onClose()
	return
end

return ShelterTaskDecreeTaskView
