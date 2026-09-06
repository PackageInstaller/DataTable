-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formation/view/FormationPopupMenuItem.lua

module("logic.extensions.formation.view.FormationPopupMenuItem", package.seeall)

local FormationPopupMenuItem = class("FormationPopupMenuItem")

function FormationPopupMenuItem:ctor()
	self._nameRegex = FormationNameRegexProcess.New()

	self._nameRegex:init("^[a-zA-Z0-9_\\u4e00-\\u9fa5]+$")
end

function FormationPopupMenuItem:init(rootGo, index, tabId)
	rootGo.name = string.format("item_popup_%d", index)
	self._rootGo = rootGo
	self._imgEditGo = goutil.findChild(rootGo, "imgEdit")
	self._imgInputField = goutil.findChild(rootGo, "InputField"):GetComponent(goutil.Type_UIImage)
	self._inputFieldAdapter = Framework.InputFieldAdapter.GetFrom(rootGo, "InputField")
	self._ImgLock = goutil.findChild(rootGo, "ImgLock")

	self._inputFieldAdapter:AddOnEndEdit(self._onEndEdit, self)
	self._inputFieldAdapter:AddOnValueChanged(self._onValueChanged, self)

	self._tabId = tabId
	self._curName = ""
	self._newName = ""

	self:_setStateDirect(0)
end

function FormationPopupMenuItem:destroy()
	self._inputFieldAdapter:RemoveOnEndEdit()
	self._inputFieldAdapter:RemoveOnValueChanged()
	self:_setStateDirect(0)

	self._rootGo = nil
	self._imgEditGo = nil
	self._imgInputField = nil
	self.InputFieldAdapter = nil
	self._ImgLock = nil
end

function FormationPopupMenuItem:setState(state)
	self:_setStateDirect(state)
end

function FormationPopupMenuItem:_setStateDirect(state)
	if state == 1 then
		self._imgInputField.enabled = true

		if not self:_isLock() then
			self._imgEditGo:SetActive(true)

			self._inputFieldAdapter.input.interactable = true
		else
			self._imgEditGo:SetActive(false)

			self._inputFieldAdapter.input.interactable = false
		end
	else
		self._imgEditGo:SetActive(false)

		self._imgInputField.enabled = false
		self._inputFieldAdapter.input.interactable = false
	end
end

function FormationPopupMenuItem:getInput()
	return self._inputFieldAdapter.input
end

function FormationPopupMenuItem:setInputName(name)
	self._inputFieldAdapter:SetText(name)

	self._curName = name
end

function FormationPopupMenuItem:_getInputName()
	self._inputFieldAdapter:GetText()
end

function FormationPopupMenuItem:setImgLock(isLock)
	self._ImgLock:SetActive(isLock)
end

function FormationPopupMenuItem:_isLock()
	return self._ImgLock.activeSelf
end

function FormationPopupMenuItem:_onEndEdit(str)
	printInfo("结束编辑", str)

	if self:_isSatisfyCondition(str) then
		self._inputFieldAdapter:SetText(str)

		self._newName = str

		FormationFacade.instance:setTabNameReq(self._tabId, self._newName, self._sucessFunc, self, self._failedFunc)
	else
		self._inputFieldAdapter:SetText(self._curName)
	end
end

function FormationPopupMenuItem:_onValueChanged(str)
	if string.nilorempty(str) then
		return
	end

	local isMatch = self._nameRegex:isMatch(str)

	if not isMatch then
		FloatWordMgr.instance:show("阵型名只能由<color=#bb2b2f>汉字、字母、数字和下划线等</color>组成，不能含有空格或特殊符号哦！")
	end

	local resultStr = str

	resultStr = self._nameRegex:getMatchInput(resultStr)
	resultStr = self._nameRegex:clampStringAvailableLength(resultStr, 18)

	self._inputFieldAdapter:SetText(resultStr)
end

function FormationPopupMenuItem:_isSatisfyCondition(str)
	if string.nilorempty(str) then
		FloatWordMgr.instance:show("阵型名不能为空哦！")

		return false
	end

	if string.find(str, "^_+$") then
		FloatWordMgr.instance:show("不能全部是下划线哦！")

		return false
	end

	return true
end

function FormationPopupMenuItem:_sucessFunc(msg)
	self:setInputName(msg.newTabName)
	FloatWordMgr.instance:show(string.format("阵型名 %s 设置成功！", msg.newTabName))
	FormationController.instance:setTeamTabName(msg.tabId, msg.newTabName)
end

function FormationPopupMenuItem:_failedFunc(msg, status)
	self:setInputName(self._curName)
end

return FormationPopupMenuItem
