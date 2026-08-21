---@class SSRTipsPanel_Generate_mask
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class SSRTipsPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public mask SSRTipsPanel_Generate_mask
---@field public ui_Effect_ChouKaZhenYing UnityEngine.GameObject
---@field public biao4 UnityEngine.GameObject
---@field public biao5 UnityEngine.GameObject
---@field public biao6 UnityEngine.GameObject
---@field public biao1 UnityEngine.GameObject
---@field public biao8 UnityEngine.GameObject
---@field public biao7 UnityEngine.GameObject
---@field public biao2 UnityEngine.GameObject
---@field public biao3 UnityEngine.GameObject
local SSRTipsPanel = class("SSRTipsPanel", require("WndBase"))

function SSRTipsPanel:ctor(data)
end

---@private
function SSRTipsPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("SSRTipsPanel")

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

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function SSRTipsPanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function SSRTipsPanel:InitGenerate__2(Root, data)
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
		UIMgr:SendUiUseMessage("SSRTipsPanel_mask")
			if self.mask_Button_onClick then
				self:mask_Button_onClick(self.mask)
			end
		end)


end

---@private
function SSRTipsPanel:InitGenerate__3(Root, data)
--[[
	Ui_Effect_ChouKaZhenYing
--]]
	local tmp = Root:Find("Ui_Effect_ChouKaZhenYing").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.ui_Effect_ChouKaZhenYing = tmp


end

---@private
function SSRTipsPanel:InitGenerate__4(Root, data)
--[[
	Ui_Effect_ChouKaZhenYing/Effect/Biao4
--]]
	local tmp = Root:Find("Ui_Effect_ChouKaZhenYing/Effect/Biao4").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.biao4 = tmp


end

---@private
function SSRTipsPanel:InitGenerate__5(Root, data)
--[[
	Ui_Effect_ChouKaZhenYing/Effect/Biao5
--]]
	local tmp = Root:Find("Ui_Effect_ChouKaZhenYing/Effect/Biao5").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.biao5 = tmp


end

---@private
function SSRTipsPanel:InitGenerate__6(Root, data)
--[[
	Ui_Effect_ChouKaZhenYing/Effect/Biao6
--]]
	local tmp = Root:Find("Ui_Effect_ChouKaZhenYing/Effect/Biao6").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.biao6 = tmp


end

---@private
function SSRTipsPanel:InitGenerate__7(Root, data)
--[[
	Ui_Effect_ChouKaZhenYing/Effect/Biao1
--]]
	local tmp = Root:Find("Ui_Effect_ChouKaZhenYing/Effect/Biao1").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.biao1 = tmp


end

---@private
function SSRTipsPanel:InitGenerate__8(Root, data)
--[[
	Ui_Effect_ChouKaZhenYing/Effect/Biao8
--]]
	local tmp = Root:Find("Ui_Effect_ChouKaZhenYing/Effect/Biao8").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.biao8 = tmp


end

---@private
function SSRTipsPanel:InitGenerate__9(Root, data)
--[[
	Ui_Effect_ChouKaZhenYing/Effect/Biao7
--]]
	local tmp = Root:Find("Ui_Effect_ChouKaZhenYing/Effect/Biao7").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.biao7 = tmp


end

---@private
function SSRTipsPanel:InitGenerate__10(Root, data)
--[[
	Ui_Effect_ChouKaZhenYing/Effect/Biao2
--]]
	local tmp = Root:Find("Ui_Effect_ChouKaZhenYing/Effect/Biao2").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.biao2 = tmp


end

---@private
function SSRTipsPanel:InitGenerate__11(Root, data)
--[[
	Ui_Effect_ChouKaZhenYing/Effect/Biao3
--]]
	local tmp = Root:Find("Ui_Effect_ChouKaZhenYing/Effect/Biao3").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.biao3 = tmp


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function SSRTipsPanel:SetLocalizedText(Root)

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return SSRTipsPanel