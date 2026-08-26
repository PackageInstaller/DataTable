-- chunkname: @modules/logic/prototest/view/ProtoTestCaseItem.lua

module("modules.logic.prototest.view.ProtoTestCaseItem", package.seeall)

local ProtoTestCaseItem = class("ProtoTestCaseItem", MixScrollCell)

function ProtoTestCaseItem:init(go)
	self._go = go
	self._tr = go.transform
	self._txtId = gohelper.findChildText(go, "Txt_id")
	self._txtFields = {
		gohelper.findChildText(go, "Txt_field")
	}
	self._btnRemove = gohelper.findChildButtonWithAudio(go, "Btn_remove")
	self._btnCopy = gohelper.findChildButtonWithAudio(go, "Btn_copy")
	self._btnSend = gohelper.findChildButtonWithAudio(go, "Btn_send")
end

function ProtoTestCaseItem:addEventListeners()
	self._btnRemove:AddClickListener(self._onClickRemove, self)
	self._btnCopy:AddClickListener(self._onClickCopy, self)
	self._btnSend:AddClickListener(self._onClickSend, self)
	gohelper.getClick(self._go):AddClickListener(self._onClickItem, self)
end

function ProtoTestCaseItem:removeEventListeners()
	self._btnRemove:RemoveClickListener()
	self._btnCopy:RemoveClickListener()
	self._btnSend:RemoveClickListener()
	gohelper.getClick(self._go):RemoveClickListener()

	for i = 1, #self._txtFields do
		local txtField = self._txtFields[i]

		gohelper.getClick(txtField.gameObject):RemoveClickListener()
	end
end

function ProtoTestCaseItem:onUpdateMO(mo, mixType, param)
	recthelper.setHeight(self._tr, param)

	self._mo = mo
	self._txtId.text = self._mo.id .. ". " .. self._mo.struct

	for i, paramMO in ipairs(self._mo.value) do
		local txt1GO = self._txtFields[1].gameObject
		local txtField = self._txtFields[i]

		if not txtField then
			local goTxtField = gohelper.clone(txt1GO, txt1GO.transform.parent.gameObject, txt1GO.name .. i)

			txtField = goTxtField:GetComponent(gohelper.Type_Text) or goTxtField:GetComponent(gohelper.Type_TextMesh)

			recthelper.setAnchorY(txtField.transform, recthelper.getAnchorY(txt1GO.transform) - 28 * (i - 1))
			table.insert(self._txtFields, txtField)
		end

		txtField.text = paramMO:getParamDescLine()

		gohelper.setActive(txtField.gameObject, true)
		gohelper.getClick(txtField.gameObject):AddClickListener(self._onClickParam, self, i)
	end

	for i = #self._mo.value + 1, #self._txtFields do
		gohelper.setActive(self._txtFields[i].gameObject, false)
	end
end

function ProtoTestCaseItem:_onClickItem()
	ViewMgr.instance:openView(ViewName.ProtoModifyView, {
		protoMO = self._mo
	})
end

function ProtoTestCaseItem:_onClickParam(id)
	ViewMgr.instance:openView(ViewName.ProtoModifyView, {
		protoMO = self._mo,
		paramId = id
	})
end

function ProtoTestCaseItem:_onClickRemove()
	ProtoTestCaseModel.instance:remove(self._mo)

	local list = ProtoTestCaseModel.instance:getList()

	for i, mo in ipairs(list) do
		mo.id = i
	end

	ProtoTestCaseModel.instance:setList(list)
end

function ProtoTestCaseItem:_onClickCopy()
	local cloneMO = self._mo:clone()
	local list = ProtoTestCaseModel.instance:getList()

	table.insert(list, cloneMO)

	for i, mo in ipairs(list) do
		mo.id = i
	end

	ProtoTestCaseModel.instance:setList(list)
end

function ProtoTestCaseItem:_onClickSend()
	local protobuf = self._mo:buildProtoMsg()

	LuaSocketMgr.instance:sendMsg(protobuf)
end

return ProtoTestCaseItem
