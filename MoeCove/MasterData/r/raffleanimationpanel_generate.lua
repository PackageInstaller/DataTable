---@class RaffleAnimationPanel_Generate_blackScreen
---@field public gameObject UnityEngine.GameObject
---@field public canvasGroup UnityEngine.CanvasGroup

---@class RaffleAnimationPanel_Generate_writeScreen
---@field public gameObject UnityEngine.GameObject
---@field public canvasGroup UnityEngine.CanvasGroup

---@class RaffleAnimationPanel_Generate_touchEtaBtn
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class RaffleAnimationPanel_Generate_clickTipsRoot
---@field public gameObject UnityEngine.GameObject
---@field public animator UnityEngine.Animator

---@class RaffleAnimationPanel_Generate_skipBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton
---@field public canvasGroup UnityEngine.CanvasGroup

---@class RaffleAnimationPanel_Generate_mask
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class RaffleAnimationPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public mask RaffleAnimationPanel_Generate_mask
---@field public skipBtn RaffleAnimationPanel_Generate_skipBtn
---@field public clickTipsRoot RaffleAnimationPanel_Generate_clickTipsRoot
---@field public touchEtaBtn RaffleAnimationPanel_Generate_touchEtaBtn
---@field public writeScreen RaffleAnimationPanel_Generate_writeScreen
---@field public blackScreen RaffleAnimationPanel_Generate_blackScreen
local RaffleAnimationPanel = class("RaffleAnimationPanel", require("WndBase"))

function RaffleAnimationPanel:ctor(data)
end

---@private
function RaffleAnimationPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("RaffleAnimationPanel")

	local Root = self.transform 
	local tmp

	self:InitGenerate__1(Root,data)
	self:InitGenerate__2(Root,data)
	self:InitGenerate__3(Root,data)
	self:InitGenerate__4(Root,data)
	self:InitGenerate__5(Root,data)
	self:InitGenerate__6(Root,data)
	self:InitGenerate__7(Root,data)

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function RaffleAnimationPanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function RaffleAnimationPanel:InitGenerate__2(Root, data)
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
		UIMgr:SendUiUseMessage("RaffleAnimationPanel_mask")
			if self.mask_Button_onClick then
				self:mask_Button_onClick(self.mask)
			end
		end)


end

---@private
function RaffleAnimationPanel:InitGenerate__3(Root, data)
--[[
	AdjustRoot/SkipBtn
--]]
	local tmp = Root:Find("AdjustRoot/SkipBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.skipBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("RaffleAnimationPanel_skipBtn")
			if self.skipBtn_ScaleButton_onClick then
				self:skipBtn_ScaleButton_onClick(self.skipBtn)
			end
		end)

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function RaffleAnimationPanel:InitGenerate__4(Root, data)
--[[
	ClickTipsRoot
--]]
	local tmp = Root:Find("ClickTipsRoot").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.clickTipsRoot = tmp

	tmp.animator = tmp:GetComponent(TypeInfo.Animator)


end

---@private
function RaffleAnimationPanel:InitGenerate__5(Root, data)
--[[
	TouchEtaBtn
--]]
	local tmp = Root:Find("TouchEtaBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.touchEtaBtn = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("RaffleAnimationPanel_touchEtaBtn")
			if self.touchEtaBtn_Button_onClick then
				self:touchEtaBtn_Button_onClick(self.touchEtaBtn)
			end
		end)


end

---@private
function RaffleAnimationPanel:InitGenerate__6(Root, data)
--[[
	WriteScreen
--]]
	local tmp = Root:Find("WriteScreen").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.writeScreen = tmp

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function RaffleAnimationPanel:InitGenerate__7(Root, data)
--[[
	BlackScreen
--]]
	local tmp = Root:Find("BlackScreen").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.blackScreen = tmp

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function RaffleAnimationPanel:SetLocalizedText(Root)

    local locObj_RaffleAnimationPanel_SkipTxt = Root:Find("AdjustRoot/SkipBtn/SkipTxt")
    if locObj_RaffleAnimationPanel_SkipTxt then
        locObj_RaffleAnimationPanel_SkipTxt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.RaffleAnimationPanel_SkipTxt
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return RaffleAnimationPanel