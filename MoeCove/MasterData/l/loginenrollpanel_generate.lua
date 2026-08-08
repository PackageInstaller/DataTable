---@class LoginEnrollPanel_Generate_label
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI
---@field public textLink TextLink

---@class LoginEnrollPanel_Generate_cheakToggle
---@field public gameObject UnityEngine.GameObject
---@field public toggle UnityEngine.UI.Toggle

---@class LoginEnrollPanel_Generate_closeBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class LoginEnrollPanel_Generate_okBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class LoginEnrollPanel_Generate_waitBtn_sendCodeTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class LoginEnrollPanel_Generate_waitBtn
---@field public gameObject UnityEngine.GameObject
---@field public sendCodeTxt LoginEnrollPanel_Generate_waitBtn_sendCodeTxt

---@class LoginEnrollPanel_Generate_sendCodeBtn_sendCodeTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class LoginEnrollPanel_Generate_sendCodeBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton
---@field public sendCodeTxt LoginEnrollPanel_Generate_sendCodeBtn_sendCodeTxt

---@class LoginEnrollPanel_Generate_cheakPasswordInput
---@field public gameObject UnityEngine.GameObject
---@field public inputField UnityEngine.UI.InputField

---@class LoginEnrollPanel_Generate_newPasswordInput
---@field public gameObject UnityEngine.GameObject
---@field public inputField UnityEngine.UI.InputField

---@class LoginEnrollPanel_Generate_codeInput
---@field public gameObject UnityEngine.GameObject
---@field public inputField UnityEngine.UI.InputField

---@class LoginEnrollPanel_Generate_phoneInput
---@field public gameObject UnityEngine.GameObject
---@field public inputField UnityEngine.UI.InputField

---@class LoginEnrollPanel_Generate_titleTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class LoginEnrollPanel_Generate_maskBg
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class LoginEnrollPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public maskBg LoginEnrollPanel_Generate_maskBg
---@field public titleTxt LoginEnrollPanel_Generate_titleTxt
---@field public phoneInput LoginEnrollPanel_Generate_phoneInput
---@field public codeInput LoginEnrollPanel_Generate_codeInput
---@field public newPasswordInput LoginEnrollPanel_Generate_newPasswordInput
---@field public cheakPasswordInput LoginEnrollPanel_Generate_cheakPasswordInput
---@field public sendCodeBtn LoginEnrollPanel_Generate_sendCodeBtn
---@field public waitBtn LoginEnrollPanel_Generate_waitBtn
---@field public okBtn LoginEnrollPanel_Generate_okBtn
---@field public closeBtn LoginEnrollPanel_Generate_closeBtn
---@field public cheakToggle LoginEnrollPanel_Generate_cheakToggle
---@field public label LoginEnrollPanel_Generate_label
local LoginEnrollPanel = class("LoginEnrollPanel", require("WndBase"))

function LoginEnrollPanel:ctor(data)
end

---@private
function LoginEnrollPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("LoginEnrollPanel")

	local Root = self.transform 
	local tmp

	self:InitGenerate__1(Root,data)
	self:InitGenerate__2(Root,data)
	self:InitGenerate__3(Root,data)
	self:InitGenerate__4(Root,data)
	self:InitGenerate__5(Root,data)
	self:InitGenerate__6(Root,data)
	self:InitGenerate__7(Root,data)
	self:InitGenerate__8(Root,data)
	self:InitGenerate__9(Root,data)
	self:InitGenerate__10(Root,data)
	self:InitGenerate__11(Root,data)
	self:InitGenerate__12(Root,data)
	self:InitGenerate__13(Root,data)
	self:InitGenerate__14(Root,data)
	self:InitGenerate__15(Root,data)

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function LoginEnrollPanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function LoginEnrollPanel:InitGenerate__2(Root, data)
--[[
	MaskBg
--]]
	local tmp = Root:Find("MaskBg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.maskBg = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("LoginEnrollPanel_maskBg")
			if self.maskBg_Button_onClick then
				self:maskBg_Button_onClick(self.maskBg)
			end
		end)


end

---@private
function LoginEnrollPanel:InitGenerate__3(Root, data)
--[[
	PanelBg/TitleBg/TitleTxt
--]]
	local tmp = Root:Find("PanelBg/TitleBg/TitleTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.titleTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function LoginEnrollPanel:InitGenerate__4(Root, data)
--[[
	PanelBg/PhoneInput
--]]
	local tmp = Root:Find("PanelBg/PhoneInput").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.phoneInput = tmp

	tmp.inputField = tmp:GetComponent(TypeInfo.InputField)
	tmp.inputField.onEndEdit:RemoveAllListeners()
	tmp.inputField.onEndEdit:AddListener(function (content)
			if self.phoneInput_InputField_onEndEdit then
				self:phoneInput_InputField_onEndEdit(self.phoneInput,content)
			end
		end)
	tmp.inputField.onValueChanged:RemoveAllListeners()
	tmp.inputField.onValueChanged:AddListener(function (content)
			if self.phoneInput_InputField_onValueChanged then
				self:phoneInput_InputField_onValueChanged(self.phoneInput,content)
			end
		end)


end

---@private
function LoginEnrollPanel:InitGenerate__5(Root, data)
--[[
	PanelBg/CodeInput
--]]
	local tmp = Root:Find("PanelBg/CodeInput").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.codeInput = tmp

	tmp.inputField = tmp:GetComponent(TypeInfo.InputField)
	tmp.inputField.onEndEdit:RemoveAllListeners()
	tmp.inputField.onEndEdit:AddListener(function (content)
			if self.codeInput_InputField_onEndEdit then
				self:codeInput_InputField_onEndEdit(self.codeInput,content)
			end
		end)
	tmp.inputField.onValueChanged:RemoveAllListeners()
	tmp.inputField.onValueChanged:AddListener(function (content)
			if self.codeInput_InputField_onValueChanged then
				self:codeInput_InputField_onValueChanged(self.codeInput,content)
			end
		end)


end

---@private
function LoginEnrollPanel:InitGenerate__6(Root, data)
--[[
	PanelBg/NewPasswordInput
--]]
	local tmp = Root:Find("PanelBg/NewPasswordInput").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.newPasswordInput = tmp

	tmp.inputField = tmp:GetComponent(TypeInfo.InputField)
	tmp.inputField.onEndEdit:RemoveAllListeners()
	tmp.inputField.onEndEdit:AddListener(function (content)
			if self.newPasswordInput_InputField_onEndEdit then
				self:newPasswordInput_InputField_onEndEdit(self.newPasswordInput,content)
			end
		end)
	tmp.inputField.onValueChanged:RemoveAllListeners()
	tmp.inputField.onValueChanged:AddListener(function (content)
			if self.newPasswordInput_InputField_onValueChanged then
				self:newPasswordInput_InputField_onValueChanged(self.newPasswordInput,content)
			end
		end)


end

---@private
function LoginEnrollPanel:InitGenerate__7(Root, data)
--[[
	PanelBg/CheakPasswordInput
--]]
	local tmp = Root:Find("PanelBg/CheakPasswordInput").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.cheakPasswordInput = tmp

	tmp.inputField = tmp:GetComponent(TypeInfo.InputField)
	tmp.inputField.onEndEdit:RemoveAllListeners()
	tmp.inputField.onEndEdit:AddListener(function (content)
			if self.cheakPasswordInput_InputField_onEndEdit then
				self:cheakPasswordInput_InputField_onEndEdit(self.cheakPasswordInput,content)
			end
		end)
	tmp.inputField.onValueChanged:RemoveAllListeners()
	tmp.inputField.onValueChanged:AddListener(function (content)
			if self.cheakPasswordInput_InputField_onValueChanged then
				self:cheakPasswordInput_InputField_onValueChanged(self.cheakPasswordInput,content)
			end
		end)


end

---@private
function LoginEnrollPanel:InitGenerate__8(Root, data)
--[[
	PanelBg/SendCodeBtn
--]]
	local tmp = Root:Find("PanelBg/SendCodeBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.sendCodeBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("LoginEnrollPanel_sendCodeBtn")
			if self.sendCodeBtn_ScaleButton_onClick then
				self:sendCodeBtn_ScaleButton_onClick(self.sendCodeBtn)
			end
		end)


end

---@private
function LoginEnrollPanel:InitGenerate__9(Root, data)
--[[
	PanelBg/SendCodeBtn/SendCodeTxt
--]]
	local tmp = Root:Find("PanelBg/SendCodeBtn/SendCodeTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.sendCodeBtn.sendCodeTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function LoginEnrollPanel:InitGenerate__10(Root, data)
--[[
	PanelBg/WaitBtn
--]]
	local tmp = Root:Find("PanelBg/WaitBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.waitBtn = tmp


end

---@private
function LoginEnrollPanel:InitGenerate__11(Root, data)
--[[
	PanelBg/WaitBtn/SendCodeTxt
--]]
	local tmp = Root:Find("PanelBg/WaitBtn/SendCodeTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.waitBtn.sendCodeTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function LoginEnrollPanel:InitGenerate__12(Root, data)
--[[
	PanelBg/OkBtn
--]]
	local tmp = Root:Find("PanelBg/OkBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.okBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("LoginEnrollPanel_okBtn")
			if self.okBtn_ScaleButton_onClick then
				self:okBtn_ScaleButton_onClick(self.okBtn)
			end
		end)


end

---@private
function LoginEnrollPanel:InitGenerate__13(Root, data)
--[[
	PanelBg/CloseBtn
--]]
	local tmp = Root:Find("PanelBg/CloseBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.closeBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("LoginEnrollPanel_closeBtn")
			if self.closeBtn_ScaleButton_onClick then
				self:closeBtn_ScaleButton_onClick(self.closeBtn)
			end
		end)


end

---@private
function LoginEnrollPanel:InitGenerate__14(Root, data)
--[[
	PanelBg/CheakToggle
--]]
	local tmp = Root:Find("PanelBg/CheakToggle").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.cheakToggle = tmp

	tmp.toggle = tmp:GetComponent(TypeInfo.Toggle)
	tmp.toggle.onValueChanged:RemoveAllListeners()
	tmp.toggle.onValueChanged:AddListener(function (isOn)
			if self.cheakToggle_Toggle_onValueChanged then
				self:cheakToggle_Toggle_onValueChanged(self.cheakToggle,isOn)
			end
		end)


end

---@private
function LoginEnrollPanel:InitGenerate__15(Root, data)
--[[
	PanelBg/Label
--]]
	local tmp = Root:Find("PanelBg/Label").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.label = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)

	tmp.textLink = tmp:GetComponent(TypeInfo.TextLink)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function LoginEnrollPanel:SetLocalizedText(Root)

    local locObj_LoginEnrollPanel_Placeholder = Root:Find("PanelBg/PhoneInput/Placeholder")
    if locObj_LoginEnrollPanel_Placeholder then
        locObj_LoginEnrollPanel_Placeholder.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.LoginEnrollPanel_Placeholder
    end

    local locObj_LoginEnrollPanel_Ct_Placeholder = Root:Find("PanelBg/CodeInput/Placeholder")
    if locObj_LoginEnrollPanel_Ct_Placeholder then
        locObj_LoginEnrollPanel_Ct_Placeholder.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.LoginEnrollPanel_Ct_Placeholder
    end

    local locObj_LoginEnrollPanel_Nt_Placeholder = Root:Find("PanelBg/NewPasswordInput/Placeholder")
    if locObj_LoginEnrollPanel_Nt_Placeholder then
        locObj_LoginEnrollPanel_Nt_Placeholder.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.LoginEnrollPanel_Nt_Placeholder
    end

    local locObj_LoginEnrollPanel_Pg_Ct_Placeholder = Root:Find("PanelBg/CheakPasswordInput/Placeholder")
    if locObj_LoginEnrollPanel_Pg_Ct_Placeholder then
        locObj_LoginEnrollPanel_Pg_Ct_Placeholder.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.LoginEnrollPanel_Pg_Ct_Placeholder
    end

    local locObj_LoginEnrollPanel_Text = Root:Find("PanelBg/OkBtn/Text")
    if locObj_LoginEnrollPanel_Text then
        locObj_LoginEnrollPanel_Text.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.LoginEnrollPanel_Text
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return LoginEnrollPanel