-- chunkname: @modules/logic/rouge/map/view/tip/RougeMapTipView.lua

module("modules.logic.rouge.map.view.tip.RougeMapTipView", package.seeall)

local RougeMapTipView = class("RougeMapTipView", BaseView)

function RougeMapTipView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeMapTipView:addEvents()
	return
end

function RougeMapTipView:removeEvents()
	return
end

function RougeMapTipView:_editableInitView()
	self.goTip = gohelper.findChild(self.viewGO, "#go_tip")
	self.txtTip = gohelper.findChildText(self.viewGO, "#go_tip/#txt_Tips")

	gohelper.setActive(self.goTip, false)
	self.addEventCb(self, RougeMapController.instance, RougeMapEvent.onShowTip, self.onShowTip, self)
	self.addEventCb(self, RougeMapController.instance, RougeMapEvent.onHideTip, self.onHideTip, self)

	self.animator = self.viewGO:GetComponent(gohelper.Type_Animator)

	self.animator:Play("close", 0, 1)
end

function RougeMapTipView:onShowTip(tip)
	self.txtTip.text = tip

	self.animator:Play("open", 0, 0)
end

function RougeMapTipView:onHideTip()
	self.animator:Play("close", 0, 0)
end

return RougeMapTipView
