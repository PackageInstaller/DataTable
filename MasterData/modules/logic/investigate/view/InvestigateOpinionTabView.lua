-- chunkname: @modules/logic/investigate/view/InvestigateOpinionTabView.lua

module("modules.logic.investigate.view.InvestigateOpinionTabView", package.seeall)

local InvestigateOpinionTabView = class("InvestigateOpinionTabView", BaseView)

function InvestigateOpinionTabView:onInitView()
	self._gocontainer = gohelper.findChild(self.viewGO, "root/#go_container")
	self._gotopleft = gohelper.findChild(self.viewGO, "root/#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function InvestigateOpinionTabView:addEvents()
	return
end

function InvestigateOpinionTabView:removeEvents()
	return
end

function InvestigateOpinionTabView:_editableInitView()
	self.addEventCb(self, InvestigateController.instance, InvestigateEvent.ChangeArrow, self._onChangeArrow, self)
end

function InvestigateOpinionTabView:_onChangeArrow()
	local mo, _ = InvestigateOpinionModel.instance:getInfo()
	local isAllLinked = InvestigateOpinionModel.instance:allOpinionLinked(mo.id)

	if isAllLinked then
		self.viewContainer:switchTab(InvestigateEnum.OpinionTab.Extend)
	else
		self.viewContainer:switchTab(InvestigateEnum.OpinionTab.Normal)
	end
end

function InvestigateOpinionTabView:onUpdateParam()
	return
end

function InvestigateOpinionTabView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2Investigate.play_ui_leimi_theft_open)
end

function InvestigateOpinionTabView:onClose()
	return
end

function InvestigateOpinionTabView:onDestroyView()
	return
end

return InvestigateOpinionTabView
