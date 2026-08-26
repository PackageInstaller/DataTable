-- chunkname: @modules/logic/rouge/view/RougeCollectionDetailBtnComp.lua

module("modules.logic.rouge.view.RougeCollectionDetailBtnComp", package.seeall)

local RougeCollectionDetailBtnComp = class("RougeCollectionDetailBtnComp", BaseView)

function RougeCollectionDetailBtnComp:onInitView()
	self._btndetails = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_details")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeCollectionDetailBtnComp:addEvents()
	self._btndetails:AddClickListener(self._btndetailsOnClick, self)
end

function RougeCollectionDetailBtnComp:removeEvents()
	self._btndetails:RemoveClickListener()
end

function RougeCollectionDetailBtnComp:_btndetailsOnClick()
	RougeCollectionModel.instance:switchCollectionInfoType()
end

function RougeCollectionDetailBtnComp:_editableInitView()
	self.addEventCb(self, RougeController.instance, RougeEvent.SwitchCollectionInfoType, self._onSwitchCollectionInfoType, self)
end

function RougeCollectionDetailBtnComp:onOpen()
	self:refreshDetailBtnUI()
end

function RougeCollectionDetailBtnComp:refreshDetailBtnUI()
	local infoType = RougeCollectionModel.instance:getCurCollectionInfoType()
	local goselect = gohelper.findChild(self._btndetails.gameObject, "circle/select")

	gohelper.setActive(goselect, infoType == RougeEnum.CollectionInfoType.Complex)
end

function RougeCollectionDetailBtnComp:_onSwitchCollectionInfoType()
	self:refreshDetailBtnUI()
end

function RougeCollectionDetailBtnComp:onClose()
	return
end

function RougeCollectionDetailBtnComp:onDestroyView()
	return
end

return RougeCollectionDetailBtnComp
