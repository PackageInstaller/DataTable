-- chunkname: @modules/logic/rouge2/map/view/map/Rouge2_MapEntrustDetailView.lua

module("modules.logic.rouge2.map.view.map.Rouge2_MapEntrustDetailView", package.seeall)

local Rouge2_MapEntrustDetailView = class("Rouge2_MapEntrustDetailView", BaseView)

function Rouge2_MapEntrustDetailView:onInitView()
	self._btnClose1 = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Root/#btn_Close1")
	self._btnClose2 = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Root/#btn_Close2")
	self._goContent = gohelper.findChild(self.viewGO, "#go_Root/#scroll_Detail/Viewport/Content")
	self._goDetailItem = gohelper.findChild(self.viewGO, "#go_Root/#scroll_Detail/Viewport/Content/#go_DetailItem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_MapEntrustDetailView:addEvents()
	self._btnClose1:AddClickListener(self._btnCloseOnClick, self)
	self._btnClose2:AddClickListener(self._btnCloseOnClick, self)
end

function Rouge2_MapEntrustDetailView:removeEvents()
	self._btnClose1:RemoveClickListener()
	self._btnClose2:RemoveClickListener()
end

function Rouge2_MapEntrustDetailView:_btnCloseOnClick()
	self:closeThis()
end

function Rouge2_MapEntrustDetailView:onOpen()
	local entrustList = Rouge2_MapModel.instance:getDoingEntrustList() or {}

	gohelper.CreateObjList(self, self._refreshEntrustItem, entrustList, self._goContent, self._goDetailItem)
end

function Rouge2_MapEntrustDetailView:_refreshEntrustItem(obj, entrustMo, index)
	local txtDesc = gohelper.findChildText(obj, "txt_Desc")
	local txtSuccDesc = gohelper.findChildText(obj, "txt_SuccDesc")
	local entrustId = entrustMo:getEntrustId()
	local entrustCo = lua_rouge2_entrust.configDict[entrustId]

	txtDesc.text = Rouge2_MapEntrustHelper.getEntrustDesc(entrustMo)
	txtSuccDesc.text = entrustCo and entrustCo.desc
end

return Rouge2_MapEntrustDetailView
