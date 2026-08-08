---@class UserGuidePanel_Generate_clickMask
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class UserGuidePanel_Generate_skipStepBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class UserGuidePanel_Generate_arrow
---@field public gameObject UnityEngine.GameObject
---@field public animation UnityEngine.Animation

---@class UserGuidePanel_Generate_tipsSmallText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class UserGuidePanel_Generate_tipsSmallBox
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform

---@class UserGuidePanel_Generate_tipsBigText
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public text TMPro.TextMeshProUGUI

---@class UserGuidePanel_Generate_charSpine
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public image UnityEngine.UI.Image

---@class UserGuidePanel_Generate_tipsBigBox
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform

---@class UserGuidePanel_Generate_tipsBg
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public canvasGroup UnityEngine.CanvasGroup

---@class UserGuidePanel_Generate_everywhereBtn
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button
---@field public pointerListener PointerListener

---@class UserGuidePanel_Generate_sliderFinger
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public animation UnityEngine.Animation

---@class UserGuidePanel_Generate_boxBtn
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public image UnityEngine.UI.Image
---@field public uIRaycastClick UIRaycastClick
---@field public dragListener DragListener

---@class UserGuidePanel_Generate_haloBtn
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public image UnityEngine.UI.Image
---@field public uIRaycastClick UIRaycastClick

---@class UserGuidePanel_Generate_transparentAreaBox
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public image UnityEngine.UI.Image

---@class UserGuidePanel_Generate_transparentAreaHole
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public image UnityEngine.UI.Image

---@class UserGuidePanel_Generate_guideMask
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform

---@class UserGuidePanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public guideMask UserGuidePanel_Generate_guideMask
---@field public transparentAreaRoot UnityEngine.GameObject
---@field public transparentAreaHole UserGuidePanel_Generate_transparentAreaHole
---@field public transparentAreaBox UserGuidePanel_Generate_transparentAreaBox
---@field public maskBg UnityEngine.GameObject
---@field public haloBtn UserGuidePanel_Generate_haloBtn
---@field public boxBtn UserGuidePanel_Generate_boxBtn
---@field public sliderFinger UserGuidePanel_Generate_sliderFinger
---@field public everywhereBtn UserGuidePanel_Generate_everywhereBtn
---@field public tipsBg UserGuidePanel_Generate_tipsBg
---@field public tipsBigBox UserGuidePanel_Generate_tipsBigBox
---@field public charSpine UserGuidePanel_Generate_charSpine
---@field public tipsBigText UserGuidePanel_Generate_tipsBigText
---@field public tipsSmallBox UserGuidePanel_Generate_tipsSmallBox
---@field public tipsSmallText UserGuidePanel_Generate_tipsSmallText
---@field public arrowLine UnityEngine.GameObject
---@field public arrow UserGuidePanel_Generate_arrow
---@field public skipStepBtn UserGuidePanel_Generate_skipStepBtn
---@field public clickMask UserGuidePanel_Generate_clickMask
local UserGuidePanel = class("UserGuidePanel", require("CommonBase"))

function UserGuidePanel:ctor(data)
end

---@private
function UserGuidePanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("UserGuidePanel")

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
	self:InitGenerate__16(Root,data)
	self:InitGenerate__17(Root,data)
	self:InitGenerate__18(Root,data)
	self:InitGenerate__19(Root,data)
	self:InitGenerate__20(Root,data)

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function UserGuidePanel:InitGenerate__1(Root, data)
--[[
	Root
--]]


end

---@private
function UserGuidePanel:InitGenerate__2(Root, data)
--[[
	GuideMask
--]]
	local tmp = Root:Find("GuideMask").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.guideMask = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)


end

---@private
function UserGuidePanel:InitGenerate__3(Root, data)
--[[
	GuideMask/TransparentAreaRoot
--]]
	local tmp = Root:Find("GuideMask/TransparentAreaRoot").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.transparentAreaRoot = tmp


end

---@private
function UserGuidePanel:InitGenerate__4(Root, data)
--[[
	GuideMask/TransparentAreaHole
--]]
	local tmp = Root:Find("GuideMask/TransparentAreaHole").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.transparentAreaHole = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function UserGuidePanel:InitGenerate__5(Root, data)
--[[
	GuideMask/TransparentAreaBox
--]]
	local tmp = Root:Find("GuideMask/TransparentAreaBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.transparentAreaBox = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function UserGuidePanel:InitGenerate__6(Root, data)
--[[
	GuideMask/MaskBg
--]]
	local tmp = Root:Find("GuideMask/MaskBg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.maskBg = tmp


end

---@private
function UserGuidePanel:InitGenerate__7(Root, data)
--[[
	GuideMask/HaloBtn
--]]
	local tmp = Root:Find("GuideMask/HaloBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.haloBtn = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)

	tmp.image = tmp:GetComponent(TypeInfo.Image)

	tmp.uIRaycastClick = tmp:GetComponent(TypeInfo.UIRaycastClick)


end

---@private
function UserGuidePanel:InitGenerate__8(Root, data)
--[[
	GuideMask/BoxBtn
--]]
	local tmp = Root:Find("GuideMask/BoxBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.boxBtn = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)

	tmp.image = tmp:GetComponent(TypeInfo.Image)

	tmp.uIRaycastClick = tmp:GetComponent(TypeInfo.UIRaycastClick)

	tmp.dragListener = tmp:GetComponent(TypeInfo.DragListener)


end

---@private
function UserGuidePanel:InitGenerate__9(Root, data)
--[[
	GuideMask/SliderFinger
--]]
	local tmp = Root:Find("GuideMask/SliderFinger").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.sliderFinger = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)

	tmp.animation = tmp:GetComponent(TypeInfo.Animation)


end

---@private
function UserGuidePanel:InitGenerate__10(Root, data)
--[[
	GuideMask/EverywhereBtn
--]]
	local tmp = Root:Find("GuideMask/EverywhereBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.everywhereBtn = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("UserGuidePanel_everywhereBtn")
			if self.everywhereBtn_Button_onClick then
				self:everywhereBtn_Button_onClick(self.everywhereBtn)
			end
		end)

	tmp.pointerListener = tmp:GetComponent(TypeInfo.PointerListener)


end

---@private
function UserGuidePanel:InitGenerate__11(Root, data)
--[[
	TipsBg
--]]
	local tmp = Root:Find("TipsBg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.tipsBg = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function UserGuidePanel:InitGenerate__12(Root, data)
--[[
	TipsBg/TipsBigBox
--]]
	local tmp = Root:Find("TipsBg/TipsBigBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.tipsBigBox = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)


end

---@private
function UserGuidePanel:InitGenerate__13(Root, data)
--[[
	TipsBg/TipsBigBox/RoleMask/CharSpine
--]]
	local tmp = Root:Find("TipsBg/TipsBigBox/RoleMask/CharSpine").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.charSpine = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function UserGuidePanel:InitGenerate__14(Root, data)
--[[
	TipsBg/TipsBigBox/TipsBigText
--]]
	local tmp = Root:Find("TipsBg/TipsBigBox/TipsBigText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.tipsBigText = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function UserGuidePanel:InitGenerate__15(Root, data)
--[[
	TipsBg/TipsSmallBox
--]]
	local tmp = Root:Find("TipsBg/TipsSmallBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.tipsSmallBox = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)


end

---@private
function UserGuidePanel:InitGenerate__16(Root, data)
--[[
	TipsBg/TipsSmallBox/TipsSmallText
--]]
	local tmp = Root:Find("TipsBg/TipsSmallBox/TipsSmallText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.tipsSmallText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function UserGuidePanel:InitGenerate__17(Root, data)
--[[
	ArrowLine
--]]
	local tmp = Root:Find("ArrowLine").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.arrowLine = tmp


end

---@private
function UserGuidePanel:InitGenerate__18(Root, data)
--[[
	ArrowLine/Arrow
--]]
	local tmp = Root:Find("ArrowLine/Arrow").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.arrow = tmp

	tmp.animation = tmp:GetComponent(TypeInfo.Animation)


end

---@private
function UserGuidePanel:InitGenerate__19(Root, data)
--[[
	SkipStepBtn
--]]
	local tmp = Root:Find("SkipStepBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.skipStepBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("UserGuidePanel_skipStepBtn")
			if self.skipStepBtn_ScaleButton_onClick then
				self:skipStepBtn_ScaleButton_onClick(self.skipStepBtn)
			end
		end)


end

---@private
function UserGuidePanel:InitGenerate__20(Root, data)
--[[
	ClickMask
--]]
	local tmp = Root:Find("ClickMask").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.clickMask = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("UserGuidePanel_clickMask")
			if self.clickMask_Button_onClick then
				self:clickMask_Button_onClick(self.clickMask)
			end
		end)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function UserGuidePanel:SetLocalizedText(Root)

    local locObj_UserGuidePanel_SkipStepTxt = Root:Find("SkipStepBtn/SkipStepTxt")
    if locObj_UserGuidePanel_SkipStepTxt then
        locObj_UserGuidePanel_SkipStepTxt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.UserGuidePanel_SkipStepTxt
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return UserGuidePanel