-- chunkname: @modules/logic/enemyinfo/view/EnemyInfoTipView.lua

module("modules.logic.enemyinfo.view.EnemyInfoTipView", package.seeall)

local EnemyInfoTipView = class("EnemyInfoTipView", BaseViewExtended)

function EnemyInfoTipView:onInitView()
	self._gotipconatiner = gohelper.findChild(self.viewGO, "#go_tip_container")
	self._goruletip = gohelper.findChild(self.viewGO, "#go_tip_container/#go_ruletip")

	gohelper.setActive(self._goruletip, false)

	self._gobufftip = gohelper.findChild(self.viewGO, "#go_tip_container/#go_bufftip")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function EnemyInfoTipView:addEvents()
	return
end

function EnemyInfoTipView:removeEvents()
	return
end

function EnemyInfoTipView:onClickCloseTip()
	self.showTip = nil

	self:hideAllTip()
	EnemyInfoController.instance:dispatchEvent(EnemyInfoEvent.HideTip)
end

function EnemyInfoTipView:_editableInitView()
	self.closeTipClick = gohelper.findChildClickWithDefaultAudio(self._gotipconatiner, "#go_tipclose")

	self.closeTipClick:AddClickListener(self.onClickCloseTip, self)
	self.addEventCb(self, EnemyInfoController.instance, EnemyInfoEvent.ShowTip, self.onShowTip, self)
end

function EnemyInfoTipView:onShowTip(tipEnum)
	gohelper.setActive(self._gotipconatiner, true)

	if self.showTip == tipEnum then
		return
	end

	self.showTip = tipEnum

	gohelper.setActive(self._gobufftip, self.showTip == EnemyInfoEnum.Tip.BuffTip)
end

function EnemyInfoTipView:hideAllTip()
	gohelper.setActive(self._gotipconatiner, false)
	gohelper.setActive(self._gobufftip, false)
end

function EnemyInfoTipView:onOpen()
	self:hideAllTip()
end

function EnemyInfoTipView:onClose()
	return
end

function EnemyInfoTipView:onDestroyView()
	self.closeTipClick:RemoveClickListener()
end

return EnemyInfoTipView
