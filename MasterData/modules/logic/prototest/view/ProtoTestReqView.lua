-- chunkname: @modules/logic/prototest/view/ProtoTestReqView.lua

module("modules.logic.prototest.view.ProtoTestReqView", package.seeall)

local ProtoTestReqView = class("ProtoTestReqView", BaseView)

function ProtoTestReqView:onInitView()
	self._panelNew = gohelper.findChild(self.viewGO, "Panel_testcase/Panel_new")
	self._bgGO = gohelper.findChild(self.viewGO, "Panel_testcase/Panel_new/bg")
	self._bgTr = self._bgGO.transform
	self._inpRequest = gohelper.findChildTextMeshInputField(self.viewGO, "Panel_testcase/Panel_new/bg/inpRequest")
	self._btnNewCase = gohelper.findChildButtonWithAudio(self.viewGO, "Panel_testcase/Panel_oprator/Btn_NewCase")
	self._click = gohelper.getClick(self._panelNew)
end

function ProtoTestReqView:addEvents()
	self._click:AddClickListener(self._onClickMask, self)
	self._btnNewCase:AddClickListener(self._onClickBtnNewCase, self)
	self._inpRequest:AddOnValueChanged(self._onValueChanged, self)
	self.addEventCb(self, ProtoTestMgr.instance, ProtoEnum.OnClickReqListItem, self._onClickReqListItem, self)
end

function ProtoTestReqView:removeEvents()
	self._click:RemoveClickListener()
	self._btnNewCase:RemoveClickListener()
	self._inpRequest:RemoveOnValueChanged()
	self.removeEventCb(self, ProtoTestMgr.instance, ProtoEnum.OnClickReqListItem, self._onClickReqListItem, self)
end

function ProtoTestReqView:onOpen()
	gohelper.setActive(self._panelNew, false)
end

function ProtoTestReqView:_onClickMask()
	gohelper.setActive(self._panelNew, false)
end

function ProtoTestReqView:_onClickBtnNewCase()
	gohelper.setActive(self._panelNew, true)
	self:_updateListView()
end

function ProtoTestReqView:_onValueChanged(inputStr)
	self:_updateListView()
end

function ProtoTestReqView:_onClickReqListItem(mo)
	gohelper.setActive(self._panelNew, false)

	local proto = ProtoParamHelper.buildProtoByStructName(mo.req)
	local newMO = ProtoTestCaseMO.New()

	newMO:initFromProto(mo.cmd, proto)
	ProtoTestCaseModel.instance:addAtLast(newMO)
end

function ProtoTestReqView:_updateListView()
	local list = ProtoReqListModel.instance:getFilterList(self._inpRequest:GetText())
	local count = #list

	count = count > 10 and 10 or count
	count = count < 1 and 1 or count

	recthelper.setHeight(self._bgTr, 40 + count * 60)
	ProtoReqListModel.instance:setList(list)
end

return ProtoTestReqView
