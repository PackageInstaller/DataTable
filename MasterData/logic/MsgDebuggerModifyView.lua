-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/gm/view/msgdebugger/MsgDebuggerModifyView.lua

module("logic.extensions.msgdebugger.MsgDebuggerModifyView", package.seeall)

local MsgDebuggerModifyView = class("MsgDebuggerModifyView")

function MsgDebuggerModifyView:show(paramMO)
	self._paramMO = paramMO

	if not self._viewGO then
		getres(MsgDebuggerConfig.ModifyViewPath, self._onResourceLoaded, self, ResType.AssetBunble, false)
	else
		goutil.setActive(self._viewGO, true)
		self:_updateUI()
	end
end

function MsgDebuggerModifyView:_onResourceLoaded(res)
	if res.IsSuccess then
		self._res = res

		self._res:Retain()

		self._viewGO = goutil.clone(res:GetMainAsset())

		goutil.addChildToParent(self._viewGO, MsgDebugger.instance.parentGO)

		self._btnClose = Framework.ButtonAdapter.GetFrom(self._viewGO, "imgBg/imgTitleBg/btnClose")
		self._btnOK = Framework.ButtonAdapter.GetFrom(self._viewGO, "imgBg/btnOK")

		self._btnClose:AddClickListener(self._onClickClose, self)
		self._btnOK:AddClickListener(self._onClickOK, self)

		self._closeTrigger = Framework.UIClickTrigger.Get(goutil.findChild(self._viewGO, "imgMask"))

		self._closeTrigger:AddClickListener(self._onClickClose, self)

		self._txtParamName = goutil.findChildTextComponent(self._viewGO, "imgBg/txtParamName")
		self._txtPlaceholder = goutil.findChildTextComponent(self._viewGO, "imgBg/InputField/Placeholder")
		self._inpValue = Framework.InputFieldAdapter.GetFrom(self._viewGO, "imgBg/InputField")
		self._defaultValueGO = goutil.findChild(self._viewGO, "imgBg/defaultValue")
		self._defaultValueBtns = {}
		self._firstDefaultValueBtn = Framework.UIClickTrigger.Get(goutil.findChild(self._viewGO, "imgBg/defaultValue/btnValue1"))

		table.insert(self._defaultValueBtns, self._firstDefaultValueBtn)
		self:_updateUI()
	end
end

function MsgDebuggerModifyView:_onClickClose()
	self._paramMO = nil

	goutil.setActive(self._viewGO, false)
end

function MsgDebuggerModifyView:_onClickOK()
	local inputStr = self._inpValue:GetText()

	if inputStr ~= tostring(self._paramMO.msgValue) then
		self._paramMO:modifyValue(inputStr)
		MsgDebugger.instance:localNotify(MsgDebugger.EvtModifyParam, self._paramMO)
	end

	self._paramMO = nil

	goutil.setActive(self._viewGO, false)
end

function MsgDebuggerModifyView:_updateUI()
	self._txtParamName.text = self._paramMO.msgDebuggerMO.pbUpStructName .. "." .. self._paramMO.paramName

	local value = self._paramMO.msgValue and tostring(self._paramMO.msgValue) or ""

	self._txtPlaceholder.text = value

	self._inpValue:SetText(value)

	local defaultValues = MsgDebuggerConfig.DefaultValue[self._paramMO.paramTypeStr]

	goutil.setActive(self._defaultValueGO, defaultValues)

	if defaultValues then
		for i = 1, #defaultValues do
			local btn = self._defaultValueBtns[i]

			if not btn then
				local btnGO = goutil.clone(self._firstDefaultValueBtn.gameObject, "btnValue" .. i)

				goutil.addChildToParent(btnGO, self._defaultValueGO)

				btn = Framework.UIClickTrigger.Get(btnGO)
				self._defaultValueBtns[i] = btn
			end

			local innerBtnText = goutil.findChildTextComponent(btn.gameObject, "Text")

			innerBtnText.text = defaultValues[i]

			goutil.setActive(btn.gameObject, true)
			Framework.GeometryUtil.SetAnchorPosY(btn.transform, -35 * (i - 1))
			Framework.GeometryUtil.SetWidth(btn.transform, innerBtnText.preferredWidth + 30)
			btn:RemoveClickListener()
			btn:AddClickListener(self._onClickDefaultValue, self, i)
		end

		for i = #defaultValues + 1, #self._defaultValueBtns do
			goutil.setActive(self._defaultValueBtns[i].gameObject, false)
		end
	end
end

function MsgDebuggerModifyView:_onClickDefaultValue(evtData, index)
	local defaultValues = MsgDebuggerConfig.DefaultValue[self._paramMO.paramTypeStr]
	local value = defaultValues[index]

	self._inpValue:SetText(value)
end

function MsgDebuggerModifyView:destroy()
	if self._defaultValueBtns then
		for i = 1, #self._defaultValueBtns do
			self._defaultValueBtns[i]:RemoveClickListener()
		end

		self._defaultValueBtns = nil
	end

	if self._viewGO then
		self._btnClose:RemoveClickListener()
		goutil.destroy(self._viewGO)

		self._viewGO = nil
		self._btnClose = nil
	end

	if self._res then
		self._res:Release()

		self._res = nil
	end
end

MsgDebuggerModifyView.instance = MsgDebuggerModifyView.New()

return MsgDebuggerModifyView
