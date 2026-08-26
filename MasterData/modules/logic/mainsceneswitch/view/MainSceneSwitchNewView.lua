-- chunkname: @modules/logic/mainsceneswitch/view/MainSceneSwitchNewView.lua

module("modules.logic.mainsceneswitch.view.MainSceneSwitchNewView", package.seeall)

local MainSceneSwitchNewView = class("MainSceneSwitchNewView", MainSceneSwitchView)

function MainSceneSwitchNewView:_editableInitView()
	MainSceneSwitchNewView.super._editableInitView(self)
end

function MainSceneSwitchNewView:addEvents()
	MainSceneSwitchNewView.super.addEvents(self)
	self.viewContainer:registerCallback(ViewEvent.ToSwitchTab, self._toSwitchTab, self)
end

function MainSceneSwitchNewView:removeEvents()
	MainSceneSwitchNewView.super.removeEvents(self)
	self.viewContainer:unregisterCallback(ViewEvent.ToSwitchTab, self._toSwitchTab, self)
end

function MainSceneSwitchNewView:_toSwitchTab(tabContainerId, tabId)
	if tabContainerId == 1 and self.viewContainer:getClassify() == MainSwitchClassifyEnum.Classify.Scene then
		if tabId == MainEnum.SwitchType.Scene then
			self:onTabSwitchOpen()
		else
			self:onTabSwitchClose()
		end
	end
end

function MainSceneSwitchNewView:onOpen()
	MainSceneSwitchNewView.super.onOpen(self)
	self:_updateSceneInfo()
	self._rootAnimator:Play("open", 0, 0)

	if self.viewParam and self.viewParam.jumpTabs and self.viewParam.jumpTabs[1] == MainEnum.SwitchType.Scene then
		local index = self.viewParam.jumpTabs[2]

		if index then
			self.viewContainer:switchClassifyTab(index)
			MainSwitchClassifyListModel.instance:selectCell(index, true)
		end
	end
end

function MainSceneSwitchNewView:onTabSwitchOpen()
	MainHeroView.resetPostProcessBlur()

	if self._rootAnimator then
		self._rootAnimator:Play("open", 0, 0)
	end
end

function MainSceneSwitchNewView:onTabSwitchClose()
	return
end

return MainSceneSwitchNewView
