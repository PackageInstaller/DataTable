-- chunkname: @modules/logic/prototest/view/ProtoModifyListItem.lua

module("modules.logic.prototest.view.ProtoModifyListItem", package.seeall)

local ProtoModifyListItem = class("ProtoModifyListItem", ListScrollCell)

function ProtoModifyListItem:init(go)
	self._txtKey = gohelper.findChildText(go, "txtKey")
	self._txtValue = gohelper.findChildText(go, "txtValue")
	self._btnRemove = gohelper.findChildButtonWithAudio(go, "btnRemove")
	self._btnAdd = gohelper.findChildButtonWithAudio(go, "btnAdd")
	self._click = gohelper.getClick(go)
end

function ProtoModifyListItem:addEventListeners()
	self._btnRemove:AddClickListener(self._onClickRemove, self)
	self._btnAdd:AddClickListener(self._onClickAdd, self)
	self._click:AddClickListener(self._onClickThis, self)
end

function ProtoModifyListItem:removeEventListeners()
	self._btnRemove:RemoveClickListener()
	self._btnAdd:RemoveClickListener()
	self._click:RemoveClickListener()
end

function ProtoModifyListItem:onUpdateMO(mo)
	self._mo = mo

	local isProtoItem = isTypeOf(mo, ProtoTestCaseParamMO)

	if isProtoItem then
		if mo.repeated then
			if not ("[" .. mo.key .. "]") then
				local keyStr = mo.key
				local labelStr = ProtoEnum.LabelType[mo.pLabel]

				if mo.pType == ProtoEnum.ParamType.proto then
					if not mo.struct then
						local typeStr = ProtoEnum.ParamType[mo.pType]

						self._txtKey.text = keyStr .. "  <color=#A42316>" .. labelStr .. " - " .. typeStr .. "</color>"
						self._txtValue.text = mo:getParamDescLine()

						gohelper.setActive(self._txtKey.gameObject, true)
						gohelper.setActive(self._txtValue.gameObject, true)
						gohelper.setActive(self._btnRemove.gameObject, mo.repeated)
						gohelper.setActive(self._btnAdd.gameObject, false)
					end
				end
			end
		end
	else
		gohelper.setActive(self._txtKey.gameObject, false)
		gohelper.setActive(self._txtValue.gameObject, false)
		gohelper.setActive(self._btnRemove.gameObject, false)
		gohelper.setActive(self._btnAdd.gameObject, true)
	end
end

function ProtoModifyListItem:_onClickThis()
	ProtoTestMgr.instance:dispatchEvent(ProtoEnum.OnClickModifyItem, self._mo.id)
end

function ProtoModifyListItem:_onClickRemove()
	ProtoModifyModel.instance:removeRepeatedParam(self._mo.id)
end

function ProtoModifyListItem:_onClickAdd()
	ProtoModifyModel.instance:addRepeatedParam()
	ProtoTestCaseModel.instance:onModelUpdate()
end

return ProtoModifyListItem
