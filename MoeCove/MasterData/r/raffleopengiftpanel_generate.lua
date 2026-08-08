---@class RaffleOpenGiftPanel_Generate_whiteLight
---@field public gameObject UnityEngine.GameObject
---@field public canvasGroup UnityEngine.CanvasGroup

---@class RaffleOpenGiftPanel_Generate_skipBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class RaffleOpenGiftPanel_Generate_clickBoxBtn
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class RaffleOpenGiftPanel_Generate_gloveAndArrow
---@field public gameObject UnityEngine.GameObject
---@field public skeletonAnimation Spine.Unity.SkeletonAnimation

---@class RaffleOpenGiftPanel_Generate_box
---@field public gameObject UnityEngine.GameObject
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack

---@class RaffleOpenGiftPanel_Generate_background
---@field public gameObject UnityEngine.GameObject
---@field public skeletonAnimation Spine.Unity.SkeletonAnimation

---@class RaffleOpenGiftPanel_Generate_mark
---@field public gameObject UnityEngine.GameObject
---@field public skeletonAnimation Spine.Unity.SkeletonAnimation

---@class RaffleOpenGiftPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public mark RaffleOpenGiftPanel_Generate_mark
---@field public background RaffleOpenGiftPanel_Generate_background
---@field public box RaffleOpenGiftPanel_Generate_box
---@field public gloveAndArrow RaffleOpenGiftPanel_Generate_gloveAndArrow
---@field public clickBoxBtn RaffleOpenGiftPanel_Generate_clickBoxBtn
---@field public skipBtn RaffleOpenGiftPanel_Generate_skipBtn
---@field public ui_Effect_ChouKa_1 UnityEngine.GameObject
---@field public ui_Effect_ChouKa_2 UnityEngine.GameObject
---@field public ui_Effect_ChouKa_3 UnityEngine.GameObject
---@field public whiteLight RaffleOpenGiftPanel_Generate_whiteLight
local RaffleOpenGiftPanel = class("RaffleOpenGiftPanel", require("WndBase"))

function RaffleOpenGiftPanel:ctor(data)
end

---@private
function RaffleOpenGiftPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("RaffleOpenGiftPanel")

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

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function RaffleOpenGiftPanel:InitGenerate__1(Root, data)
--[[
	Mark
--]]
	local tmp = Root:Find("Mark").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.mark = tmp

	tmp.skeletonAnimation = tmp:GetComponent(TypeInfo.SkeletonAnimation)


end

---@private
function RaffleOpenGiftPanel:InitGenerate__2(Root, data)
--[[
	Background
--]]
	local tmp = Root:Find("Background").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.background = tmp

	tmp.skeletonAnimation = tmp:GetComponent(TypeInfo.SkeletonAnimation)


end

---@private
function RaffleOpenGiftPanel:InitGenerate__3(Root, data)
--[[
	Box
--]]
	local tmp = Root:Find("Box").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.box = tmp

	tmp.animator = tmp:GetComponent(TypeInfo.Animator)

	tmp.animOverCallBack = tmp:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function RaffleOpenGiftPanel:InitGenerate__4(Root, data)
--[[
	GloveAndArrow
--]]
	local tmp = Root:Find("GloveAndArrow").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.gloveAndArrow = tmp

	tmp.skeletonAnimation = tmp:GetComponent(TypeInfo.SkeletonAnimation)


end

---@private
function RaffleOpenGiftPanel:InitGenerate__5(Root, data)
--[[
	ClickBoxBtn
--]]
	local tmp = Root:Find("ClickBoxBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.clickBoxBtn = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("RaffleOpenGiftPanel_clickBoxBtn")
			if self.clickBoxBtn_Button_onClick then
				self:clickBoxBtn_Button_onClick(self.clickBoxBtn)
			end
		end)


end

---@private
function RaffleOpenGiftPanel:InitGenerate__6(Root, data)
--[[
	Canvas/SkipBtn
--]]
	local tmp = Root:Find("Canvas/SkipBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.skipBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("RaffleOpenGiftPanel_skipBtn")
			if self.skipBtn_ScaleButton_onClick then
				self:skipBtn_ScaleButton_onClick(self.skipBtn)
			end
		end)


end

---@private
function RaffleOpenGiftPanel:InitGenerate__7(Root, data)
--[[
	Canvas/Effect/Ui_Effect_ChouKa_1
--]]
	local tmp = Root:Find("Canvas/Effect/Ui_Effect_ChouKa_1").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.ui_Effect_ChouKa_1 = tmp


end

---@private
function RaffleOpenGiftPanel:InitGenerate__8(Root, data)
--[[
	Canvas/Effect/Ui_Effect_ChouKa_2
--]]
	local tmp = Root:Find("Canvas/Effect/Ui_Effect_ChouKa_2").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.ui_Effect_ChouKa_2 = tmp


end

---@private
function RaffleOpenGiftPanel:InitGenerate__9(Root, data)
--[[
	Canvas/Effect/Ui_Effect_ChouKa_3
--]]
	local tmp = Root:Find("Canvas/Effect/Ui_Effect_ChouKa_3").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.ui_Effect_ChouKa_3 = tmp


end

---@private
function RaffleOpenGiftPanel:InitGenerate__10(Root, data)
--[[
	Canvas/WhiteLight
--]]
	local tmp = Root:Find("Canvas/WhiteLight").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.whiteLight = tmp

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function RaffleOpenGiftPanel:SetLocalizedText(Root)

    local locObj_RaffleOpenGiftPanel_SkipText = Root:Find("Canvas/SkipBtn/SkipText")
    if locObj_RaffleOpenGiftPanel_SkipText then
        locObj_RaffleOpenGiftPanel_SkipText.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.RaffleOpenGiftPanel_SkipText
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return RaffleOpenGiftPanel