-- chunkname: @modules/logic/rouge2/outside/view/Rouge2_CollectionDetailBtnComp.lua

module("modules.logic.rouge2.outside.view.Rouge2_CollectionDetailBtnComp", package.seeall)

local Rouge2_CollectionDetailBtnComp = class("Rouge2_CollectionDetailBtnComp", BaseView)

function Rouge2_CollectionDetailBtnComp:onInitView()
	self._btndetails = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_details")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_CollectionDetailBtnComp:addEvents()
	self._btndetails:AddClickListener(self._btndetailsOnClick, self)
end

function Rouge2_CollectionDetailBtnComp:removeEvents()
	self._btndetails:RemoveClickListener()
end

function Rouge2_CollectionDetailBtnComp:_btndetailsOnClick()
	Rouge2_OutsideModel.instance:switchCollectionInfoType()
end

function Rouge2_CollectionDetailBtnComp:_editableInitView()
	self._goSelect = gohelper.findChild(self._btndetails.gameObject, "circle/#go_select")

	self.addEventCb(self, Rouge2_OutsideController.instance, Rouge2_OutsideEvent.SwitchCollectionInfoType, self._onSwitchCollectionInfoType, self)
end

function Rouge2_CollectionDetailBtnComp:onOpen()
	self:refreshDetailBtnUI()
end

function Rouge2_CollectionDetailBtnComp:refreshDetailBtnUI()
	local infoType = Rouge2_OutsideModel.instance:getCurCollectionInfoType()

	gohelper.setActive(self._goSelect, infoType == Rouge2_OutsideEnum.CollectionInfoType.Complex)
end

function Rouge2_CollectionDetailBtnComp:_onSwitchCollectionInfoType()
	self:refreshDetailBtnUI()
end

function Rouge2_CollectionDetailBtnComp:onClose()
	return
end

function Rouge2_CollectionDetailBtnComp:onDestroyView()
	return
end

return Rouge2_CollectionDetailBtnComp
