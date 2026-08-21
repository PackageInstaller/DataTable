---@class UISwitchPanel_Generate_ef2_effect
---@field public gameObject UnityEngine.GameObject
---@field public particleSystem UnityEngine.ParticleSystem

---@class UISwitchPanel_Generate_ef2
---@field public gameObject UnityEngine.GameObject
---@field public effect UISwitchPanel_Generate_ef2_effect

---@class UISwitchPanel_Generate_ef1_effect
---@field public gameObject UnityEngine.GameObject
---@field public particleSystem UnityEngine.ParticleSystem

---@class UISwitchPanel_Generate_ef1
---@field public gameObject UnityEngine.GameObject
---@field public effect UISwitchPanel_Generate_ef1_effect

---@class UISwitchPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public mask UnityEngine.GameObject
---@field public ef1 UISwitchPanel_Generate_ef1
---@field public ef2 UISwitchPanel_Generate_ef2
local UISwitchPanel = class("UISwitchPanel", require("WndBase"))

function UISwitchPanel:ctor(data)
end

---@private
function UISwitchPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("UISwitchPanel")

	local Root = self.transform 
	local tmp

	self:InitGenerate__1(Root,data)
	self:InitGenerate__2(Root,data)
	self:InitGenerate__3(Root,data)
	self:InitGenerate__4(Root,data)
	self:InitGenerate__5(Root,data)
	self:InitGenerate__6(Root,data)

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function UISwitchPanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function UISwitchPanel:InitGenerate__2(Root, data)
--[[
	Mask
--]]
	local tmp = Root:Find("Mask").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.mask = tmp


end

---@private
function UISwitchPanel:InitGenerate__3(Root, data)
--[[
	Ef1
--]]
	local tmp = Root:Find("Ef1").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.ef1 = tmp


end

---@private
function UISwitchPanel:InitGenerate__4(Root, data)
--[[
	Ef1/Effect
--]]
	local tmp = Root:Find("Ef1/Effect").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.ef1.effect = tmp

	tmp.particleSystem = tmp:GetComponent(TypeInfo.ParticleSystem)


end

---@private
function UISwitchPanel:InitGenerate__5(Root, data)
--[[
	Ef2
--]]
	local tmp = Root:Find("Ef2").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.ef2 = tmp


end

---@private
function UISwitchPanel:InitGenerate__6(Root, data)
--[[
	Ef2/Effect
--]]
	local tmp = Root:Find("Ef2/Effect").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.ef2.effect = tmp

	tmp.particleSystem = tmp:GetComponent(TypeInfo.ParticleSystem)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function UISwitchPanel:SetLocalizedText(Root)

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return UISwitchPanel