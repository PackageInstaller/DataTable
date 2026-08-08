---@class ProtoAgreementPart_Generate_registerAgreement_okBtn
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class ProtoAgreementPart_Generate_registerAgreement_agreementTitle
---@field public gameObject UnityEngine.GameObject
---@field public text UnityEngine.UI.Text

---@class ProtoAgreementPart_Generate_registerAgreement_agreeText
---@field public gameObject UnityEngine.GameObject
---@field public text UnityEngine.UI.Text

---@class ProtoAgreementPart_Generate_scrollView
---@field public gameObject UnityEngine.GameObject
---@field public scrollRect UnityEngine.UI.ScrollRect

---@class ProtoAgreementPart_Generate_registerAgreement
---@field public gameObject UnityEngine.GameObject
---@field public content UnityEngine.GameObject
---@field public agreeText ProtoAgreementPart_Generate_registerAgreement_agreeText
---@field public agreementTitle ProtoAgreementPart_Generate_registerAgreement_agreementTitle
---@field public okBtn ProtoAgreementPart_Generate_registerAgreement_okBtn

---@class ProtoAgreementPart_Generate_agreement2Btn
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class ProtoAgreementPart_Generate_agreement1Btn
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class ProtoAgreementPart_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public toggle UnityEngine.UI.Toggle
---@field public agreement1Btn ProtoAgreementPart_Generate_agreement1Btn
---@field public agreement2Btn ProtoAgreementPart_Generate_agreement2Btn
---@field public registerAgreement ProtoAgreementPart_Generate_registerAgreement
---@field public scrollView ProtoAgreementPart_Generate_scrollView
local ProtoAgreementPart = class("ProtoAgreementPart", require("LuaMonoBehavior"))

function ProtoAgreementPart:ctor(data)
end

---@private
function ProtoAgreementPart:InitGenerate(data)

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

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function ProtoAgreementPart:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.toggle = Root:GetComponent(TypeInfo.Toggle)
	self.toggle.onValueChanged:RemoveAllListeners()
	self.toggle.onValueChanged:AddListener(function (isOn)
			if self.toggle_Toggle_onValueChanged then
				self:toggle_Toggle_onValueChanged(self,isOn)
			end
		end)


end

---@private
function ProtoAgreementPart:InitGenerate__2(Root, data)
--[[
	agreement1Btn
--]]
	local tmp = Root:Find("agreement1Btn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.agreement1Btn = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("ProtoAgreementPart_agreement1Btn")
			if self.agreement1Btn_Button_onClick then
				self:agreement1Btn_Button_onClick(self.agreement1Btn)
			end
		end)


end

---@private
function ProtoAgreementPart:InitGenerate__3(Root, data)
--[[
	agreement2Btn
--]]
	local tmp = Root:Find("agreement2Btn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.agreement2Btn = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("ProtoAgreementPart_agreement2Btn")
			if self.agreement2Btn_Button_onClick then
				self:agreement2Btn_Button_onClick(self.agreement2Btn)
			end
		end)


end

---@private
function ProtoAgreementPart:InitGenerate__4(Root, data)
--[[
	RegisterAgreement
--]]
	local tmp = Root:Find("RegisterAgreement").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.registerAgreement = tmp


end

---@private
function ProtoAgreementPart:InitGenerate__5(Root, data)
--[[
	RegisterAgreement/ScrollView
--]]
	local tmp = Root:Find("RegisterAgreement/ScrollView").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.scrollView = tmp

	tmp.scrollRect = tmp:GetComponent(TypeInfo.ScrollRect)


end

---@private
function ProtoAgreementPart:InitGenerate__6(Root, data)
--[[
	RegisterAgreement/ScrollView/Viewport/Content
--]]
	local tmp = Root:Find("RegisterAgreement/ScrollView/Viewport/Content").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.registerAgreement.content = tmp


end

---@private
function ProtoAgreementPart:InitGenerate__7(Root, data)
--[[
	RegisterAgreement/ScrollView/Viewport/Content/agreeText
--]]
	local tmp = Root:Find("RegisterAgreement/ScrollView/Viewport/Content/agreeText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.registerAgreement.agreeText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.Text)


end

---@private
function ProtoAgreementPart:InitGenerate__8(Root, data)
--[[
	RegisterAgreement/agreementTitle
--]]
	local tmp = Root:Find("RegisterAgreement/agreementTitle").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.registerAgreement.agreementTitle = tmp

	tmp.text = tmp:GetComponent(TypeInfo.Text)


end

---@private
function ProtoAgreementPart:InitGenerate__9(Root, data)
--[[
	RegisterAgreement/okBtn
--]]
	local tmp = Root:Find("RegisterAgreement/okBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.registerAgreement.okBtn = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("ProtoAgreementPart_okBtn")
			if self.okBtn_Button_onClick then
				self:okBtn_Button_onClick(self.registerAgreement.okBtn)
			end
		end)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function ProtoAgreementPart:SetLocalizedText(Root)

    local locObj_ProtoAgreementCheck_Label = Root:Find("Label")
    if locObj_ProtoAgreementCheck_Label then
        locObj_ProtoAgreementCheck_Label.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.ProtoAgreementCheck_Label
    end

    local locObj_ProtoAgreementCheck_agreement1Btn = Root:Find("agreement1Btn")
    if locObj_ProtoAgreementCheck_agreement1Btn then
        locObj_ProtoAgreementCheck_agreement1Btn.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.ProtoAgreementCheck_agreement1Btn
    end

    local locObj_ProtoAgreementCheck_agreement2Btn = Root:Find("agreement2Btn")
    if locObj_ProtoAgreementCheck_agreement2Btn then
        locObj_ProtoAgreementCheck_agreement2Btn.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.ProtoAgreementCheck_agreement2Btn
    end

    local locObj_ProtoAgreementCheck_text = Root:Find("RegisterAgreement/okBtn/text")
    if locObj_ProtoAgreementCheck_text then
        locObj_ProtoAgreementCheck_text.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.ProtoAgreementCheck_text
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return ProtoAgreementPart