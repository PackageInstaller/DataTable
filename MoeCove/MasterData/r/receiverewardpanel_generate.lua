---@class ReceiveRewardPanel_Generate_autoRoot
---@field public gameObject UnityEngine.GameObject
---@field public autoAdjustCanvasRoot AutoAdjustCanvasRoot

---@class ReceiveRewardPanel_Generate_customMsgPanel
---@field public gameObject UnityEngine.GameObject
---@field public customMsgPanel CustomMsgPanel

---@class ReceiveRewardPanel_Generate_customBox
---@field public gameObject UnityEngine.GameObject
---@field public customBox CustomBox

---@class ReceiveRewardPanel_Generate_content
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public gridLayoutGroup UnityEngine.UI.GridLayoutGroup

---@class ReceiveRewardPanel_Generate_scrollView
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public scrollRect UnityEngine.UI.ScrollRect

---@class ReceiveRewardPanel_Generate_blueBg
---@field public gameObject UnityEngine.GameObject
---@field public canvasGroup UnityEngine.CanvasGroup

---@class ReceiveRewardPanel_Generate_mask
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class ReceiveRewardPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public canvasGroup UnityEngine.CanvasGroup
---@field public mask ReceiveRewardPanel_Generate_mask
---@field public blueBg ReceiveRewardPanel_Generate_blueBg
---@field public scrollView ReceiveRewardPanel_Generate_scrollView
---@field public content ReceiveRewardPanel_Generate_content
---@field public tipsText UnityEngine.GameObject
---@field public customBox ReceiveRewardPanel_Generate_customBox
---@field public customMsgPanel ReceiveRewardPanel_Generate_customMsgPanel
---@field public autoRoot ReceiveRewardPanel_Generate_autoRoot
local ReceiveRewardPanel = class("ReceiveRewardPanel", require("WndBase"))

function ReceiveRewardPanel:ctor(data)
end

---@private
function ReceiveRewardPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("ReceiveRewardPanel")

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
function ReceiveRewardPanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)

	self.canvasGroup = Root:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function ReceiveRewardPanel:InitGenerate__2(Root, data)
--[[
	Mask
--]]
	local tmp = Root:Find("Mask").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.mask = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("ReceiveRewardPanel_mask")
			if self.mask_Button_onClick then
				self:mask_Button_onClick(self.mask)
			end
		end)


end

---@private
function ReceiveRewardPanel:InitGenerate__3(Root, data)
--[[
	Bg/BlueBg
--]]
	local tmp = Root:Find("Bg/BlueBg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.blueBg = tmp

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function ReceiveRewardPanel:InitGenerate__4(Root, data)
--[[
	Bg/BlueBg/ScrollView
--]]
	local tmp = Root:Find("Bg/BlueBg/ScrollView").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.scrollView = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)

	tmp.scrollRect = tmp:GetComponent(TypeInfo.ScrollRect)


end

---@private
function ReceiveRewardPanel:InitGenerate__5(Root, data)
--[[
	Bg/BlueBg/ScrollView/Viewport/Content
--]]
	local tmp = Root:Find("Bg/BlueBg/ScrollView/Viewport/Content").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.content = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)

	tmp.gridLayoutGroup = tmp:GetComponent(TypeInfo.GridLayoutGroup)


end

---@private
function ReceiveRewardPanel:InitGenerate__6(Root, data)
--[[
	TipsText
--]]
	local tmp = Root:Find("TipsText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.tipsText = tmp


end

---@private
function ReceiveRewardPanel:InitGenerate__7(Root, data)
--[[
	CustomBox
--]]
	local tmp = Root:Find("CustomBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.customBox = tmp

	tmp.customBox = tmp:AddComponentLua("CustomBox", data)


end

---@private
function ReceiveRewardPanel:InitGenerate__8(Root, data)
--[[
	CustomMsgPanel
--]]
	local tmp = Root:Find("CustomMsgPanel").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.customMsgPanel = tmp

	tmp.customMsgPanel = tmp:AddComponentLua("CustomMsgPanel", data)


end

---@private
function ReceiveRewardPanel:InitGenerate__9(Root, data)
--[[
	autoRoot
--]]
	local tmp = Root:Find("autoRoot").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.autoRoot = tmp

	tmp.autoAdjustCanvasRoot = tmp:GetComponent(TypeInfo.AutoAdjustCanvasRoot)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function ReceiveRewardPanel:SetLocalizedText(Root)

    local locObj_ReceiveRewardPanel_TipsText = Root:Find("TipsText")
    if locObj_ReceiveRewardPanel_TipsText then
        locObj_ReceiveRewardPanel_TipsText.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.ReceiveRewardPanel_TipsText
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return ReceiveRewardPanel