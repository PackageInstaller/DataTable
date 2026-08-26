-- chunkname: @modules/logic/rouge2/map/view/tip/Rouge2_MapTipView.lua

module("modules.logic.rouge2.map.view.tip.Rouge2_MapTipView", package.seeall)

local Rouge2_MapTipView = class("Rouge2_MapTipView", BaseView)

function Rouge2_MapTipView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_MapTipView:addEvents()
	return
end

function Rouge2_MapTipView:removeEvents()
	return
end

function Rouge2_MapTipView:_editableInitView()
	self.goTip = gohelper.findChild(self.viewGO, "#go_tip")
	self.txtTip = gohelper.findChildText(self.viewGO, "#go_tip/#txt_Tips")

	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onShowTip, self.onShowTip, self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onHideTip, self.onHideTip, self)

	self.animator = self.viewGO:GetComponent(gohelper.Type_Animator)

	self.animator:Play("close", 0, 1)
end

function Rouge2_MapTipView:onShowTip(tip)
	self.txtTip.text = tip

	self.animator:Play("open", 0, 0)
end

function Rouge2_MapTipView:onHideTip()
	self.animator:Play("close", 0, 0)
end

return Rouge2_MapTipView
