---@class TipsMsgBox_Generate_type1_tipsTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class TipsMsgBox_Generate_type1_tipsBg
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform

---@class TipsMsgBox_Generate_type1
---@field public gameObject UnityEngine.GameObject
---@field public canvasGroup UnityEngine.CanvasGroup
---@field public tipsBg TipsMsgBox_Generate_type1_tipsBg
---@field public tipsTxt TipsMsgBox_Generate_type1_tipsTxt

---@class TipsMsgBox_Generate_closeMask
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image
---@field public pointerListener PointerListener

---@class TipsMsgBox_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public closeMask TipsMsgBox_Generate_closeMask
---@field public type1 TipsMsgBox_Generate_type1
local TipsMsgBox = class("TipsMsgBox", require("CommonBase"))

function TipsMsgBox:ctor(data)
end

---@private
function TipsMsgBox:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("TipsMsgBox")

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
function TipsMsgBox:InitGenerate__1(Root, data)
--[[
	Root
--]]


end

---@private
function TipsMsgBox:InitGenerate__2(Root, data)
--[[
	CloseMask
--]]
	local tmp = Root:Find("CloseMask").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.closeMask = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)

	tmp.pointerListener = tmp:GetComponent(TypeInfo.PointerListener)


end

---@private
function TipsMsgBox:InitGenerate__3(Root, data)
--[[
	Type1
--]]
	local tmp = Root:Find("Type1").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.type1 = tmp

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function TipsMsgBox:InitGenerate__4(Root, data)
--[[
	Type1/TipsBg
--]]
	local tmp = Root:Find("Type1/TipsBg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.type1.tipsBg = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)


end

---@private
function TipsMsgBox:InitGenerate__5(Root, data)
--[[
	Type1/TipsBg/TipsTxt
--]]
	local tmp = Root:Find("Type1/TipsBg/TipsTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.type1.tipsTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function TipsMsgBox:SetLocalizedText(Root)

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return TipsMsgBox