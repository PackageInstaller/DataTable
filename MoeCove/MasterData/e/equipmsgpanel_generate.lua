---@class EquipMsgPanel_Generate_msgText
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public text TMPro.TextMeshProUGUI

---@class EquipMsgPanel_Generate_titleText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class EquipMsgPanel_Generate_closeBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class EquipMsgPanel_Generate_maskImg
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class EquipMsgPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public rectTransform UnityEngine.RectTransform
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public maskImg EquipMsgPanel_Generate_maskImg
---@field public closeBtn EquipMsgPanel_Generate_closeBtn
---@field public titleText EquipMsgPanel_Generate_titleText
---@field public msgText EquipMsgPanel_Generate_msgText
local EquipMsgPanel = class("EquipMsgPanel", require("WndBase"))

function EquipMsgPanel:ctor(data)
end

---@private
function EquipMsgPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("EquipMsgPanel")

	local Root = self.transform 
	local tmp

	self:InitGenerate__1(Root,data)
	self:InitGenerate__2(Root,data)
	self:InitGenerate__3(Root,data)
	self:InitGenerate__4(Root,data)
	self:InitGenerate__5(Root,data)

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function EquipMsgPanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.rectTransform = Root:GetComponent(TypeInfo.RectTransform)

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function EquipMsgPanel:InitGenerate__2(Root, data)
--[[
	maskImg
--]]
	local tmp = Root:Find("maskImg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.maskImg = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("EquipMsgPanel_maskImg")
			if self.maskImg_Button_onClick then
				self:maskImg_Button_onClick(self.maskImg)
			end
		end)


end

---@private
function EquipMsgPanel:InitGenerate__3(Root, data)
--[[
	PanelBg/TitleBg/CloseBtn
--]]
	local tmp = Root:Find("PanelBg/TitleBg/CloseBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.closeBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("EquipMsgPanel_closeBtn")
			if self.closeBtn_ScaleButton_onClick then
				self:closeBtn_ScaleButton_onClick(self.closeBtn)
			end
		end)


end

---@private
function EquipMsgPanel:InitGenerate__4(Root, data)
--[[
	PanelBg/TitleBg/TitleText
--]]
	local tmp = Root:Find("PanelBg/TitleBg/TitleText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.titleText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function EquipMsgPanel:InitGenerate__5(Root, data)
--[[
	PanelBg/MsgText
--]]
	local tmp = Root:Find("PanelBg/MsgText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.msgText = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function EquipMsgPanel:SetLocalizedText(Root)

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return EquipMsgPanel