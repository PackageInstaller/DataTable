-- chunkname: @modules/logic/rouge2/outside/view/Rouge2_AlchemyEnterView.lua

module("modules.logic.rouge2.outside.view.Rouge2_AlchemyEnterView", package.seeall)

local Rouge2_AlchemyEnterView = class("Rouge2_AlchemyEnterView", BaseView)

function Rouge2_AlchemyEnterView:onInitView()
	self._simagefullbg = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_fullbg")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "middle/#simage_icon")
	self._txteffect = gohelper.findChildText(self.viewGO, "middle/#txt_effect")
	self._txtname = gohelper.findChildText(self.viewGO, "middle/image_nameBG/#txt_name")
	self._btndetail = gohelper.findChildButtonWithAudio(self.viewGO, "middle/#btn_detail")
	self._btnagain = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_again")
	self._btnenter = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_enter")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_AlchemyEnterView:addEvents()
	self._btndetail:AddClickListener(self._btndetailOnClick, self)
	self._btnagain:AddClickListener(self._btnagainOnClick, self)
	self._btnenter:AddClickListener(self._btnenterOnClick, self)
	self.addEventCb(self, Rouge2_OutsideController.instance, Rouge2_OutsideEvent.onAlchemyCancel, self.onAlchemyCancel, self)
end

function Rouge2_AlchemyEnterView:removeEvents()
	self._btndetail:RemoveClickListener()
	self._btnagain:RemoveClickListener()
	self._btnenter:RemoveClickListener()
	self.addEventCb(self, Rouge2_OutsideController.instance, Rouge2_OutsideEvent.onAlchemyCancel, self.onAlchemyCancel, self)
end

function Rouge2_AlchemyEnterView:_btndetailOnClick()
	local viewParam = {}

	viewParam.state = Rouge2_OutsideEnum.AlchemySuccessViewState.Detail

	Rouge2_OutsideController.instance:openAlchemySuccessView(viewParam)
end

function Rouge2_AlchemyEnterView:_btnagainOnClick()
	Rouge2_OutsideController.instance:tryClearCurFormula()
end

function Rouge2_AlchemyEnterView:_btnenterOnClick()
	Rouge2_OutsideController.instance:dispatchEvent(Rouge2_OutsideEvent.EnterGame)
	self:closeThis()
end

function Rouge2_AlchemyEnterView:_editableInitView()
	self._animator = gohelper.findChildComponent(self.viewGO, "", gohelper.Type_Animator)
end

function Rouge2_AlchemyEnterView:onUpdateParam()
	return
end

function Rouge2_AlchemyEnterView:onOpen()
	if self.viewParam and self.viewParam.isFromAlchemyView == true then
		self._animator:Play("backsuccess", 0, 0)
	else
		self._animator:Play("open", 0, 0)
	end

	self:refreshUI()
end

function Rouge2_AlchemyEnterView:refreshUI()
	local alchemyInfo = Rouge2_AlchemyModel.instance:getHaveAlchemyInfo()
	local formulaConfig = Rouge2_OutSideConfig.instance:getFormulaConfig(alchemyInfo.formula)

	Rouge2_IconHelper.setFormulaIcon(alchemyInfo.formula, self._simageicon)

	local rareStr = Rouge2_OutsideEnum.FormulaRareColor[formulaConfig.rare]

	self._txtname.text = string.format("<color=%s>%s</color>", rareStr, formulaConfig.name)
end

function Rouge2_AlchemyEnterView:onAlchemyCancel()
	self:closeThis()
	Rouge2_OutsideController.instance:openAlchemyView()
end

function Rouge2_AlchemyEnterView:onClose()
	return
end

function Rouge2_AlchemyEnterView:onDestroyView()
	return
end

return Rouge2_AlchemyEnterView
