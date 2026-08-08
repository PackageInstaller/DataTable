---@class RechargePanel_Generate_shopBox
---@field public gameObject UnityEngine.GameObject
---@field public shopBox ShopBox

---@class RechargePanel_Generate_customBackPanel
---@field public gameObject UnityEngine.GameObject
---@field public customBackPanel CustomBackPanel

---@class RechargePanel_Generate_shopList
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public loopGridView SuperScrollView.LoopGridView

---@class RechargePanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public shopList RechargePanel_Generate_shopList
---@field public customBackPanel RechargePanel_Generate_customBackPanel
---@field public shopBox RechargePanel_Generate_shopBox
local RechargePanel = class("RechargePanel", require("WndBase"))

function RechargePanel:ctor(data)
end

---@private
function RechargePanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("RechargePanel")

	local Root = self.transform 
	local tmp

	self:InitGenerate__1(Root,data)
	self:InitGenerate__2(Root,data)
	self:InitGenerate__3(Root,data)
	self:InitGenerate__4(Root,data)

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function RechargePanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function RechargePanel:InitGenerate__2(Root, data)
--[[
	ViewPanel/shopList
--]]
	local tmp = Root:Find("ViewPanel/shopList").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.shopList = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)

	tmp.loopGridView = tmp:GetComponent(TypeInfo.LoopGridView)


end

---@private
function RechargePanel:InitGenerate__3(Root, data)
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

---@private
function RechargePanel:InitGenerate__4(Root, data)
--[[
	ShopBox
--]]
	local tmp = Root:Find("ShopBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.shopBox = tmp

	tmp.shopBox = tmp:AddComponentLua("ShopBox", data)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function RechargePanel:SetLocalizedText(Root)

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return RechargePanel