---@class CreateRolePanel_Generate_progressBar
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class CreateRolePanel_Generate_noNameBtn
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class CreateRolePanel_Generate_okBtn
---@field public gameObject UnityEngine.GameObject
---@field public clickLongPressListener ClickLongPressListener

---@class CreateRolePanel_Generate_randomNameBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class CreateRolePanel_Generate_nameField
---@field public gameObject UnityEngine.GameObject
---@field public inputField UnityEngine.UI.InputField

---@class CreateRolePanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public nameField CreateRolePanel_Generate_nameField
---@field public randomNameBtn CreateRolePanel_Generate_randomNameBtn
---@field public okBtn CreateRolePanel_Generate_okBtn
---@field public noNameBtn CreateRolePanel_Generate_noNameBtn
---@field public progressBar CreateRolePanel_Generate_progressBar
local CreateRolePanel = class("CreateRolePanel", require("WndBase"))

function CreateRolePanel:ctor(data)
end

---@private
function CreateRolePanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("CreateRolePanel")

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
function CreateRolePanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function CreateRolePanel:InitGenerate__2(Root, data)
--[[
	Bg/NameField
--]]
	local tmp = Root:Find("Bg/NameField").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.nameField = tmp

	tmp.inputField = tmp:GetComponent(TypeInfo.InputField)
	tmp.inputField.onEndEdit:RemoveAllListeners()
	tmp.inputField.onEndEdit:AddListener(function (content)
			if self.nameField_InputField_onEndEdit then
				self:nameField_InputField_onEndEdit(self.nameField,content)
			end
		end)
	tmp.inputField.onValueChanged:RemoveAllListeners()
	tmp.inputField.onValueChanged:AddListener(function (content)
			if self.nameField_InputField_onValueChanged then
				self:nameField_InputField_onValueChanged(self.nameField,content)
			end
		end)


end

---@private
function CreateRolePanel:InitGenerate__3(Root, data)
--[[
	Bg/RandomNameBtn
--]]
	local tmp = Root:Find("Bg/RandomNameBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.randomNameBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("CreateRolePanel_randomNameBtn")
			if self.randomNameBtn_ScaleButton_onClick then
				self:randomNameBtn_ScaleButton_onClick(self.randomNameBtn)
			end
		end)


end

---@private
function CreateRolePanel:InitGenerate__4(Root, data)
--[[
	Fingerprint/OkBtn
--]]
	local tmp = Root:Find("Fingerprint/OkBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.okBtn = tmp

	tmp.clickLongPressListener = tmp:GetComponent(TypeInfo.ClickLongPressListener)


end

---@private
function CreateRolePanel:InitGenerate__5(Root, data)
--[[
	Fingerprint/NoNameBtn
--]]
	local tmp = Root:Find("Fingerprint/NoNameBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.noNameBtn = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("CreateRolePanel_noNameBtn")
			if self.noNameBtn_Button_onClick then
				self:noNameBtn_Button_onClick(self.noNameBtn)
			end
		end)


end

---@private
function CreateRolePanel:InitGenerate__6(Root, data)
--[[
	Fingerprint/ProgressBg/ProgressBar
--]]
	local tmp = Root:Find("Fingerprint/ProgressBg/ProgressBar").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.progressBar = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function CreateRolePanel:SetLocalizedText(Root)

    local locObj_CreateRolePanel_Placeholder = Root:Find("Bg/NameField/Placeholder")
    if locObj_CreateRolePanel_Placeholder then
        locObj_CreateRolePanel_Placeholder.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.CreateRolePanel_Placeholder
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return CreateRolePanel