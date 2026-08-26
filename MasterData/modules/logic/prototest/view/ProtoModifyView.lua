-- chunkname: @modules/logic/prototest/view/ProtoModifyView.lua

module("modules.logic.prototest.view.ProtoModifyView", package.seeall)

local ProtoModifyView = class("ProtoModifyView", BaseView)

function ProtoModifyView:onInitView()
	self._btnBack1 = gohelper.findChildButtonWithAudio(self.viewGO, "paramlistpanel/btnBack")
	self._btnBack2 = gohelper.findChildButtonWithAudio(self.viewGO, "modifyparampanel/btnBack")
	self._btnSave = gohelper.findChildButtonWithAudio(self.viewGO, "modifyparampanel/panel/Btn_save")
	self._listPanel = gohelper.findChild(self.viewGO, "paramlistpanel")
	self._modifyPanel = gohelper.findChild(self.viewGO, "modifyparampanel")
	self._txtTitle1 = gohelper.findChildText(self.viewGO, "paramlistpanel/txtTitle")
	self._txtTitle2 = gohelper.findChildText(self.viewGO, "modifyparampanel/txtTitle")
	self._txtParam = gohelper.findChildText(self.viewGO, "modifyparampanel/panel/txtParam")
	self._inputValue = gohelper.findChildTextMeshInputField(self.viewGO, "modifyparampanel/panel/inputValue")
end

function ProtoModifyView:addEvents()
	self._btnBack1:AddClickListener(self._onClickBack, self)
	self._btnBack2:AddClickListener(self._closeModify, self)
	self._btnSave:AddClickListener(self._onClickSave, self)
	ProtoTestMgr.instance:registerCallback(ProtoEnum.OnClickModifyItem, self._enterModifyItem, self)
end

function ProtoModifyView:removeEvents()
	self._btnBack1:RemoveClickListener()
	self._btnBack2:RemoveClickListener()
	self._btnSave:RemoveClickListener()
	ProtoTestMgr.instance:unregisterCallback(ProtoEnum.OnClickModifyItem, self._enterModifyItem, self)
end

function ProtoModifyView:onOpen()
	local protoMO = self.viewParam.protoMO
	local paramId = self.viewParam.paramId

	if protoMO then
		ProtoModifyModel.instance:enterProto(protoMO)

		if paramId then
			self:_enterModifyItem(paramId)
		else
			self:_updateTitle()
		end
	end
end

function ProtoModifyView:_enterModifyItem(id)
	ProtoModifyModel.instance:enterParam(id)

	local lastMO = ProtoModifyModel.instance:getLastMO()
	local isRepeated = lastMO:isRepeated()
	local isProtoType = lastMO:isProtoType()

	if isRepeated or isProtoType then
		gohelper.setActive(self._listPanel, true)
		gohelper.setActive(self._modifyPanel, false)
	else
		local valueStr = lastMO.value

		valueStr = (type(valueStr) == "boolean" or type(valueStr) == "number") and tostring(valueStr) or valueStr

		self._inputValue:SetText(valueStr)
		gohelper.setActive(self._listPanel, false)
		gohelper.setActive(self._modifyPanel, true)
	end

	self:_updateTitle()
end

function ProtoModifyView:_updateTitle()
	local protoMO = ProtoModifyModel.instance:getProtoMO()
	local depthParamMOs = ProtoModifyModel.instance:getDepthParamMOs()
	local lastMO = ProtoModifyModel.instance:getLastMO()
	local titleStr = protoMO.struct

	for _, depthParamMO in ipairs(depthParamMOs) do
		titleStr = depthParamMO.repeated and titleStr .. "[" .. depthParamMO.key .. "]" or titleStr .. " - " .. depthParamMO.key
	end

	self._txtTitle1.text = titleStr
	self._txtTitle2.text = titleStr

	if isTypeOf(lastMO, ProtoTestCaseParamMO) then
		local labelType = ProtoEnum.LabelType[lastMO.pLabel]

		if lastMO.pType == ProtoEnum.ParamType.proto then
			if not lastMO.struct then
				local paramType = ProtoEnum.ParamType[lastMO.pType]

				self._txtParam.text = labelType .. " - " .. paramType
			end
		end
	end
end

function ProtoModifyView:_updateList()
	ProtoModifyModel.instance:onModelUpdate()
	ProtoTestCaseModel.instance:onModelUpdate()
end

function ProtoModifyView:_onClickBack()
	if ProtoModifyModel.instance:isRoot() then
		self:closeThis()
	else
		self:_closeModify()
	end
end

function ProtoModifyView:_closeModify()
	ProtoModifyModel.instance:exitParam()
	gohelper.setActive(self._listPanel, true)
	gohelper.setActive(self._modifyPanel, false)
	self:_updateTitle()
end

function ProtoModifyView:_onClickSave()
	local lastMO = ProtoModifyModel.instance:getLastMO()
	local inputStr = self._inputValue:GetText()

	if lastMO.pType ~= ProtoEnum.ParamType.string and string.nilorempty(inputStr) and not lastMO:isOptional() then
		GameFacade.showToast(ToastEnum.ProtoModifyNotString)

		return
	end

	if lastMO.pType == ProtoEnum.ParamType.int32 or lastMO.pType == ProtoEnum.ParamType.uint32 then
		local value = tonumber(inputStr)

		if not value then
			GameFacade.showToast(ToastEnum.ProtoModifyNotValue)

			return
		end

		lastMO.value = value
	elseif lastMO.pType == ProtoEnum.ParamType.int64 or lastMO.pType == ProtoEnum.ParamType.uint64 then
		if not string.nilorempty(inputStr) and not tonumber(inputStr) then
			GameFacade.showToast(ToastEnum.ProtoModifyNotValue)

			return
		end

		lastMO.value = not string.nilorempty(inputStr) and inputStr or nil
	elseif lastMO.pType == ProtoEnum.ParamType.bool then
		local dict = {
			["0"] = false,
			["false"] = false,
			["1"] = true,
			["true"] = true
		}
		local value = dict[string.lower(inputStr)]

		if not lastMO:isOptional() and value == nil then
			GameFacade.showToast(ToastEnum.ProtoModifyIsNil)

			return
		end

		lastMO.value = value
	else
		lastMO.value = inputStr
	end

	self:_closeModify()
	self:_updateList()
end

function ProtoModifyView:onClickModalMask()
	if self._modifyPanel.activeInHierarchy then
		self:_closeModify()
	else
		self:_onClickBack()
	end
end

return ProtoModifyView
