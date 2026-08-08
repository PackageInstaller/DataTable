---@class UseCountPanel_Generate_okBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class UseCountPanel_Generate_cancelBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class UseCountPanel_Generate_minusBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class UseCountPanel_Generate_plusBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class UseCountPanel_Generate_countText
---@field public gameObject UnityEngine.GameObject
---@field public text UnityEngine.UI.Text

---@class UseCountPanel_Generate_closeBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class UseCountPanel_Generate_mask
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class UseCountPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public mask UseCountPanel_Generate_mask
---@field public closeBtn UseCountPanel_Generate_closeBtn
---@field public countText UseCountPanel_Generate_countText
---@field public plusBtn UseCountPanel_Generate_plusBtn
---@field public minusBtn UseCountPanel_Generate_minusBtn
---@field public cancelBtn UseCountPanel_Generate_cancelBtn
---@field public okBtn UseCountPanel_Generate_okBtn
local UseCountPanel = class("UseCountPanel", require("WndBase"))

function UseCountPanel:ctor(data)
end

---@private
function UseCountPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("UseCountPanel")

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

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function UseCountPanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function UseCountPanel:InitGenerate__2(Root, data)
--[[
	mask
--]]
	local tmp = Root:Find("mask").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.mask = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("UseCountPanel_mask")
			if self.mask_Button_onClick then
				self:mask_Button_onClick(self.mask)
			end
		end)


end

---@private
function UseCountPanel:InitGenerate__3(Root, data)
--[[
	PanelBg/Art/TitleBg/CloseBtn
--]]
	local tmp = Root:Find("PanelBg/Art/TitleBg/CloseBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.closeBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("UseCountPanel_closeBtn")
			if self.closeBtn_ScaleButton_onClick then
				self:closeBtn_ScaleButton_onClick(self.closeBtn)
			end
		end)


end

---@private
function UseCountPanel:InitGenerate__4(Root, data)
--[[
	PanelBg/CountBg/CountText
--]]
	local tmp = Root:Find("PanelBg/CountBg/CountText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.countText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.Text)


end

---@private
function UseCountPanel:InitGenerate__5(Root, data)
--[[
	PanelBg/PlusBtn
--]]
	local tmp = Root:Find("PanelBg/PlusBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.plusBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("UseCountPanel_plusBtn")
			if self.plusBtn_ScaleButton_onClick then
				self:plusBtn_ScaleButton_onClick(self.plusBtn)
			end
		end)


end

---@private
function UseCountPanel:InitGenerate__6(Root, data)
--[[
	PanelBg/MinusBtn
--]]
	local tmp = Root:Find("PanelBg/MinusBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.minusBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("UseCountPanel_minusBtn")
			if self.minusBtn_ScaleButton_onClick then
				self:minusBtn_ScaleButton_onClick(self.minusBtn)
			end
		end)


end

---@private
function UseCountPanel:InitGenerate__7(Root, data)
--[[
	PanelBg/CancelBtn
--]]
	local tmp = Root:Find("PanelBg/CancelBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.cancelBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("UseCountPanel_cancelBtn")
			if self.cancelBtn_ScaleButton_onClick then
				self:cancelBtn_ScaleButton_onClick(self.cancelBtn)
			end
		end)


end

---@private
function UseCountPanel:InitGenerate__8(Root, data)
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
		UIMgr:SendUiUseMessage("UseCountPanel_okBtn")
			if self.okBtn_ScaleButton_onClick then
				self:okBtn_ScaleButton_onClick(self.okBtn)
			end
		end)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function UseCountPanel:SetLocalizedText(Root)

    local locObj_UseCountPanel_TitleText = Root:Find("PanelBg/Art/TitleBg/TitleText")
    if locObj_UseCountPanel_TitleText then
        locObj_UseCountPanel_TitleText.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.UseCountPanel_TitleText
    end

    local locObj_UseCountPanel_TitleTxt = Root:Find("PanelBg/TitleTxt")
    if locObj_UseCountPanel_TitleTxt then
        locObj_UseCountPanel_TitleTxt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.UseCountPanel_TitleTxt
    end

    local locObj_UseCountPanel_TextTMP = Root:Find("PanelBg/CancelBtn/Text (TMP)")
    if locObj_UseCountPanel_TextTMP then
        locObj_UseCountPanel_TextTMP.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.UseCountPanel_TextTMP
    end

    local locObj_UseCountPanel_On_TextTMP = Root:Find("PanelBg/OkBtn/Text (TMP)")
    if locObj_UseCountPanel_On_TextTMP then
        locObj_UseCountPanel_On_TextTMP.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.UseCountPanel_On_TextTMP
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return UseCountPanel