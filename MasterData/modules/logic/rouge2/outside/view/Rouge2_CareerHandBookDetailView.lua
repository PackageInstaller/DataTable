-- chunkname: @modules/logic/rouge2/outside/view/Rouge2_CareerHandBookDetailView.lua

module("modules.logic.rouge2.outside.view.Rouge2_CareerHandBookDetailView", package.seeall)

local Rouge2_CareerHandBookDetailView = class("Rouge2_CareerHandBookDetailView", BaseView)

function Rouge2_CareerHandBookDetailView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._scrolltips = gohelper.findChildScrollRect(self.viewGO, "#scroll_tips")
	self._simageskillicon = gohelper.findChildSingleImage(self.viewGO, "#scroll_tips/Viewport/Content/top/#image_skillicon")
	self._txtname = gohelper.findChildText(self.viewGO, "#scroll_tips/Viewport/Content/top/#txt_name")
	self._godesccontainer = gohelper.findChild(self.viewGO, "#scroll_tips/Viewport/Content/#go_desccontainer")
	self._txtdecitem = gohelper.findChildText(self.viewGO, "#scroll_tips/Viewport/Content/#go_desccontainer/#txt_decitem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_CareerHandBookDetailView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self.addEventCb(self, Rouge2_OutsideController.instance, Rouge2_OutsideEvent.OnSelectHandBookTalent, self.onSelectHandBookTalent, self)
end

function Rouge2_CareerHandBookDetailView:removeEvents()
	self._btnclose:RemoveClickListener()
	self.removeEventCb(self, Rouge2_OutsideController.instance, Rouge2_OutsideEvent.OnSelectHandBookTalent, self.onSelectHandBookTalent, self)
end

function Rouge2_CareerHandBookDetailView:_btncloseOnClick()
	self:closeThis()
end

function Rouge2_CareerHandBookDetailView:_editableInitView()
	return
end

function Rouge2_CareerHandBookDetailView:onUpdateParam()
	return
end

function Rouge2_CareerHandBookDetailView:onOpen()
	if self.viewParam.parentGo then
		gohelper.addChild(self.viewParam.parentGo, self.viewGO)
	end

	self._curTalentId = self.viewParam.talentId

	self:refreshUI()
end

function Rouge2_CareerHandBookDetailView:onSelectHandBookTalent(talentId)
	if talentId == nil then
		self:closeThis()
	else
		self._curTalentId = talentId

		self:refreshUI()
	end
end

function Rouge2_CareerHandBookDetailView:refreshUI()
	local talentConfig = Rouge2_OutSideConfig.instance:getTalentConfigById(self._curTalentId)

	self._txtname.text = talentConfig.name
	self._txtdecitem.text = talentConfig.careerDesc

	Rouge2_IconHelper.setTalentIcon(self._curTalentId, self._simageskillicon)
end

function Rouge2_CareerHandBookDetailView:onClose()
	Rouge2_OutsideController.instance:dispatchEvent(Rouge2_OutsideEvent.OnDetailItemClickClose, nil)
end

function Rouge2_CareerHandBookDetailView:onDestroyView()
	return
end

return Rouge2_CareerHandBookDetailView
