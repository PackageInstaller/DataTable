---@class SkinViewPanel_Generate_customBackPanel
---@field public gameObject UnityEngine.GameObject
---@field public customBackPanel CustomBackPanel

---@class SkinViewPanel_Generate_sizeSlider
---@field public gameObject UnityEngine.GameObject
---@field public slider UnityEngine.UI.Slider

---@class SkinViewPanel_Generate_showCharacter_skinImg
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public image UnityEngine.UI.Image

---@class SkinViewPanel_Generate_showCharacter
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public canvasGroup UnityEngine.CanvasGroup
---@field public skinImg SkinViewPanel_Generate_showCharacter_skinImg
---@field public spineRoot UnityEngine.GameObject

---@class SkinViewPanel_Generate_posPoint
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform

---@class SkinViewPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public roleView UnityEngine.GameObject
---@field public posPoint SkinViewPanel_Generate_posPoint
---@field public showCharacter SkinViewPanel_Generate_showCharacter
---@field public sizeSlider SkinViewPanel_Generate_sizeSlider
---@field public customBackPanel SkinViewPanel_Generate_customBackPanel
local SkinViewPanel = class("SkinViewPanel", require("WndBase"))

function SkinViewPanel:ctor(data)
end

---@private
function SkinViewPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("SkinViewPanel")

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
function SkinViewPanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function SkinViewPanel:InitGenerate__2(Root, data)
--[[
	RoleView
--]]
	local tmp = Root:Find("RoleView").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.roleView = tmp


end

---@private
function SkinViewPanel:InitGenerate__3(Root, data)
--[[
	RoleView/Viewport/PosPoint
--]]
	local tmp = Root:Find("RoleView/Viewport/PosPoint").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.posPoint = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)


end

---@private
function SkinViewPanel:InitGenerate__4(Root, data)
--[[
	RoleView/Viewport/PosPoint/ShowCharacter
--]]
	local tmp = Root:Find("RoleView/Viewport/PosPoint/ShowCharacter").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.showCharacter = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function SkinViewPanel:InitGenerate__5(Root, data)
--[[
	RoleView/Viewport/PosPoint/ShowCharacter/SkinImg
--]]
	local tmp = Root:Find("RoleView/Viewport/PosPoint/ShowCharacter/SkinImg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.showCharacter.skinImg = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function SkinViewPanel:InitGenerate__6(Root, data)
--[[
	RoleView/Viewport/PosPoint/ShowCharacter/SpineRoot
--]]
	local tmp = Root:Find("RoleView/Viewport/PosPoint/ShowCharacter/SpineRoot").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.showCharacter.spineRoot = tmp


end

---@private
function SkinViewPanel:InitGenerate__7(Root, data)
--[[
	SliderPanel/SizeSlider
--]]
	local tmp = Root:Find("SliderPanel/SizeSlider").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.sizeSlider = tmp

	tmp.slider = tmp:GetComponent(TypeInfo.Slider)
	tmp.slider.onValueChanged:RemoveAllListeners()
	tmp.slider.onValueChanged:AddListener(function (value)
			if self.sizeSlider_Slider_onValueChanged then
				self:sizeSlider_Slider_onValueChanged(self.sizeSlider,value)
			end
		end)


end

---@private
function SkinViewPanel:InitGenerate__8(Root, data)
--[[
	CustomBackPanel
--]]
	local tmp = Root:Find("CustomBackPanel").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.customBackPanel = tmp

	tmp.customBackPanel = tmp:AddComponentLua("CustomBackPanel", data)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function SkinViewPanel:SetLocalizedText(Root)

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return SkinViewPanel