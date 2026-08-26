-- chunkname: @modules/logic/towercompose/view/TowerModeChangeView.lua

module("modules.logic.towercompose.view.TowerModeChangeView", package.seeall)

local TowerModeChangeView = class("TowerModeChangeView", BaseView)

function TowerModeChangeView:onInitView()
	self._gonewToOld = gohelper.findChild(self.viewGO, "NewToOld")
	self._gooldToNew = gohelper.findChild(self.viewGO, "OldToNew")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TowerModeChangeView:addEvents()
	self.addEventCb(self, TowerComposeController.instance, TowerComposeEvent.CloseModeChangeView, self.playCloseViewAnim, self)
end

function TowerModeChangeView:removeEvents()
	self.removeEventCb(self, TowerComposeController.instance, TowerComposeEvent.CloseModeChangeView, self.playCloseViewAnim, self)
end

TowerModeChangeView.EffectTime = 0.67
TowerModeChangeView.CloseOriginViewTime = 0.67
TowerModeChangeView.CloseThisViewTime = 0.67

function TowerModeChangeView:_editableInitView()
	self.newToOldAnim = self._gonewToOld:GetComponent(typeof(UnityEngine.Animator))
	self.oldToNewAnim = self._gooldToNew:GetComponent(typeof(UnityEngine.Animator))
end

function TowerModeChangeView:onUpdateParam()
	return
end

function TowerModeChangeView:onOpen()
	self.needCloseViewName = self.viewParam.needCloseViewName
	self.targetModeType = self.viewParam and self.viewParam.targetModeType
	self.param = self.viewParam.param

	gohelper.setActive(self._gooldToNew, self.targetModeType == TowerComposeEnum.TowerMainType.NewTower)
	gohelper.setActive(self._gonewToOld, self.targetModeType == TowerComposeEnum.TowerMainType.OldTower)

	if self.targetModeType == TowerComposeEnum.TowerMainType.NewTower then
		TaskDispatcher.runDelay(self.closeNeedCloseView, self, TowerModeChangeView.CloseOriginViewTime)
		TaskDispatcher.runDelay(self.openTowerComposeMainView, self, TowerModeChangeView.EffectTime)
		AudioMgr.instance:trigger(AudioEnum.TowerCompose.play_ui_fight_open_black)
	elseif self.targetModeType == TowerComposeEnum.TowerMainType.OldTower then
		TaskDispatcher.runDelay(self.closeNeedCloseView, self, TowerModeChangeView.CloseOriginViewTime)
		TaskDispatcher.runDelay(self.openTowerMainView, self, TowerModeChangeView.EffectTime)
		AudioMgr.instance:trigger(AudioEnum.TowerCompose.play_ui_fight_open_white)
	end
end

function TowerModeChangeView:closeNeedCloseView()
	ViewMgr.instance:closeView(self.needCloseViewName)
end

function TowerModeChangeView:openTowerComposeMainView()
	TowerComposeController.instance:openTowerComposeMainView(self.param)
end

function TowerModeChangeView:openTowerMainView()
	TowerController.instance:openMainView(self.param)
end

function TowerModeChangeView:playCloseViewAnim()
	if self.targetModeType == TowerComposeEnum.TowerMainType.NewTower then
		self.oldToNewAnim:Play("close", 0, 0)
		self.oldToNewAnim:Update(0)
		TaskDispatcher.runDelay(self.closeThis, self, TowerModeChangeView.CloseThisViewTime)
	elseif self.targetModeType == TowerComposeEnum.TowerMainType.OldTower then
		self.newToOldAnim:Play("close", 0, 0)
		self.newToOldAnim:Update(0)
		TaskDispatcher.runDelay(self.closeThis, self, TowerModeChangeView.CloseThisViewTime)
	end
end

function TowerModeChangeView:onClose()
	TaskDispatcher.cancelTask(self.closeNeedCloseView, self)
	TaskDispatcher.cancelTask(self.openTowerComposeMainView, self)
	TaskDispatcher.cancelTask(self.openTowerMainView, self)
	TaskDispatcher.cancelTask(self.closeThis, self)
	gohelper.setAsFirstSibling(self.viewGO)
end

function TowerModeChangeView:onDestroyView()
	return
end

return TowerModeChangeView
