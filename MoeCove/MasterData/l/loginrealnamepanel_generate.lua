---@class LoginRealNamePanel_Generate_okBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class LoginRealNamePanel_Generate_idCardInput
---@field public gameObject UnityEngine.GameObject
---@field public inputField UnityEngine.UI.InputField

---@class LoginRealNamePanel_Generate_nameInput
---@field public gameObject UnityEngine.GameObject
---@field public inputField UnityEngine.UI.InputField

---@class LoginRealNamePanel_Generate_titleTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class LoginRealNamePanel_Generate_maskBg
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class LoginRealNamePanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public maskBg LoginRealNamePanel_Generate_maskBg
---@field public titleTxt LoginRealNamePanel_Generate_titleTxt
---@field public nameInput LoginRealNamePanel_Generate_nameInput
---@field public idCardInput LoginRealNamePanel_Generate_idCardInput
---@field public okBtn LoginRealNamePanel_Generate_okBtn
local LoginRealNamePanel = class("LoginRealNamePanel", require("WndBase"))

function LoginRealNamePanel:ctor(data)
end

---@private
function LoginRealNamePanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("LoginRealNamePanel")

	local Root = self.transform 
	local tmp

	self:InitGenerate__1(Root,data)
	self:InitGenerate__2(Root,data)
	self:InitGenerate__3(Root,data)
	self:InitGenerate__4(Root,data)
	self:InitGenerate__5(Root,data)
	self:InitGenerate__6(Root,data)

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function LoginRealNamePanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function LoginRealNamePanel:InitGenerate__2(Root, data)
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
		UIMgr:SendUiUseMessage("LoginRealNamePanel_maskBg")
			if self.maskBg_Button_onClick then
				self:maskBg_Button_onClick(self.maskBg)
			end
		end)


end

---@private
function LoginRealNamePanel:InitGenerate__3(Root, data)
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
function LoginRealNamePanel:InitGenerate__4(Root, data)
--[[
	PanelBg/NameInput
--]]
	local tmp = Root:Find("PanelBg/NameInput").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.nameInput = tmp

	tmp.inputField = tmp:GetComponent(TypeInfo.InputField)
	tmp.inputField.onEndEdit:RemoveAllListeners()
	tmp.inputField.onEndEdit:AddListener(function (content)
			if self.nameInput_InputField_onEndEdit then
				self:nameInput_InputField_onEndEdit(self.nameInput,content)
			end
		end)
	tmp.inputField.onValueChanged:RemoveAllListeners()
	tmp.inputField.onValueChanged:AddListener(function (content)
			if self.nameInput_InputField_onValueChanged then
				self:nameInput_InputField_onValueChanged(self.nameInput,content)
			end
		end)


end

---@private
function LoginRealNamePanel:InitGenerate__5(Root, data)
--[[
	PanelBg/IdCardInput
--]]
	local tmp = Root:Find("PanelBg/IdCardInput").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.idCardInput = tmp

	tmp.inputField = tmp:GetComponent(TypeInfo.InputField)
	tmp.inputField.onEndEdit:RemoveAllListeners()
	tmp.inputField.onEndEdit:AddListener(function (content)
			if self.idCardInput_InputField_onEndEdit then
				self:idCardInput_InputField_onEndEdit(self.idCardInput,content)
			end
		end)
	tmp.inputField.onValueChanged:RemoveAllListeners()
	tmp.inputField.onValueChanged:AddListener(function (content)
			if self.idCardInput_InputField_onValueChanged then
				self:idCardInput_InputField_onValueChanged(self.idCardInput,content)
			end
		end)


end

---@private
function LoginRealNamePanel:InitGenerate__6(Root, data)
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
		UIMgr:SendUiUseMessage("LoginRealNamePanel_okBtn")
			if self.okBtn_ScaleButton_onClick then
				self:okBtn_ScaleButton_onClick(self.okBtn)
			end
		end)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function LoginRealNamePanel:SetLocalizedText(Root)

    local locObj_LoginRealNamePanel_MsgTxt = Root:Find("PanelBg/MsgTxt")
    if locObj_LoginRealNamePanel_MsgTxt then
        locObj_LoginRealNamePanel_MsgTxt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.LoginRealNamePanel_MsgTxt
    end

    local locObj_LoginRealNamePanel_Placeholder = Root:Find("PanelBg/NameInput/Placeholder")
    if locObj_LoginRealNamePanel_Placeholder then
        locObj_LoginRealNamePanel_Placeholder.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.LoginRealNamePanel_Placeholder
    end

    local locObj_LoginRealNamePanel_It_Placeholder = Root:Find("PanelBg/IdCardInput/Placeholder")
    if locObj_LoginRealNamePanel_It_Placeholder then
        locObj_LoginRealNamePanel_It_Placeholder.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.LoginRealNamePanel_It_Placeholder
    end

    local locObj_LoginRealNamePanel_Text = Root:Find("PanelBg/OkBtn/Text")
    if locObj_LoginRealNamePanel_Text then
        locObj_LoginRealNamePanel_Text.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.LoginRealNamePanel_Text
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return LoginRealNamePanel