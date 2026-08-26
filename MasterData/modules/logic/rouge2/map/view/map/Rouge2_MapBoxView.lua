-- chunkname: @modules/logic/rouge2/map/view/map/Rouge2_MapBoxView.lua

module("modules.logic.rouge2.map.view.map.Rouge2_MapBoxView", package.seeall)

local Rouge2_MapBoxView = class("Rouge2_MapBoxView", BaseView)

function Rouge2_MapBoxView:onInitView()
	self._btnBox = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#btn_box")
	self._txtProgress = gohelper.findChildText(self.viewGO, "Left/#btn_box/#txt_progress")
	self._goBoxReddot = gohelper.findChild(self.viewGO, "Left/#btn_box/#go_boxreddot")
	self._goCanGet = gohelper.findChild(self.viewGO, "Left/#btn_box/#canget")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_MapBoxView:addEvents()
	self._btnBox:AddClickListener(self._btnBoxOnClick, self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onUpdateMapInfo, self._onUpdateMapInfo, self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onChangeMapInfo, self._onChangeMapInfo, self)
	self.addEventCb(self, Rouge2_Controller.instance, Rouge2_Event.OnUpdateAttrInfo, self._onUpdateAttrInfo, self)
end

function Rouge2_MapBoxView:removeEvents()
	self._btnBox:RemoveClickListener()
end

function Rouge2_MapBoxView:_btnBoxOnClick()
	ViewMgr.instance:openView(ViewName.Rouge2_BackpackBoxTipsView)
end

function Rouge2_MapBoxView:_editableInitView()
	gohelper.setActive(self._btnBox, false)
	RedDotController.instance:addRedDot(self._goBoxReddot, RedDotEnum.DotNode.Rouge2BXSBox)
end

function Rouge2_MapBoxView:onOpen()
	self:refreshUI()
end

function Rouge2_MapBoxView:refreshUI()
	self._isFit = Rouge2_Model.instance:isUseBXSCareer()
	self._isMiddle = Rouge2_MapModel.instance:isMiddle()
	self._show = self._isFit and not self._isMiddle

	self:refreshBox()
end

function Rouge2_MapBoxView:refreshBox()
	gohelper.setActive(self._btnBox.gameObject, self._show)

	if not self._show then
		return
	end

	local curPoint = Rouge2_BackpackModel.instance:getCurBoxPoint()
	local maxPoint = Rouge2_MapConfig.instance:BXSMaxBoxPoint()

	self._txtProgress.text = string.format("%s/%s", curPoint, maxPoint)

	gohelper.setActive(self._goCanGet, maxPoint <= curPoint)
end

function Rouge2_MapBoxView:_onUpdateAttrInfo()
	self:refreshUI()
end

function Rouge2_MapBoxView:_onChangeMapInfo()
	self:refreshUI()
end

function Rouge2_MapBoxView:_onUpdateMapInfo()
	self:refreshUI()
end

return Rouge2_MapBoxView
