---@class LevelUpgradeToast_Generate_newTicketNum
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class LevelUpgradeToast_Generate_oldTicketNum
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class LevelUpgradeToast_Generate_ticketIcon
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class LevelUpgradeToast_Generate_level
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class LevelUpgradeToast_Generate_effectLoop
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform

---@class LevelUpgradeToast_Generate_effectStart
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform

---@class LevelUpgradeToast_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public animOverCallBack AnimOverCallBack
---@field public closeBg UnityEngine.GameObject
---@field public effectStart LevelUpgradeToast_Generate_effectStart
---@field public effectLoop LevelUpgradeToast_Generate_effectLoop
---@field public level LevelUpgradeToast_Generate_level
---@field public ticketIcon LevelUpgradeToast_Generate_ticketIcon
---@field public oldTicketNum LevelUpgradeToast_Generate_oldTicketNum
---@field public newTicketNum LevelUpgradeToast_Generate_newTicketNum
local LevelUpgradeToast = class("LevelUpgradeToast", require("ToastBase"))

function LevelUpgradeToast:ctor(data)
end

---@private
function LevelUpgradeToast:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("LevelUpgradeToast")

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
function LevelUpgradeToast:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function LevelUpgradeToast:InitGenerate__2(Root, data)
--[[
	closeBg
--]]
	local tmp = Root:Find("closeBg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.closeBg = tmp


end

---@private
function LevelUpgradeToast:InitGenerate__3(Root, data)
--[[
	EffectStart
--]]
	local tmp = Root:Find("EffectStart").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.effectStart = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)


end

---@private
function LevelUpgradeToast:InitGenerate__4(Root, data)
--[[
	EffectLoop
--]]
	local tmp = Root:Find("EffectLoop").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.effectLoop = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)


end

---@private
function LevelUpgradeToast:InitGenerate__5(Root, data)
--[[
	level
--]]
	local tmp = Root:Find("level").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.level = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function LevelUpgradeToast:InitGenerate__6(Root, data)
--[[
	gotTicketBg/TicketIcon
--]]
	local tmp = Root:Find("gotTicketBg/TicketIcon").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.ticketIcon = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function LevelUpgradeToast:InitGenerate__7(Root, data)
--[[
	gotTicketBg/oldTicketNum
--]]
	local tmp = Root:Find("gotTicketBg/oldTicketNum").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.oldTicketNum = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function LevelUpgradeToast:InitGenerate__8(Root, data)
--[[
	gotTicketBg/newTicketNum
--]]
	local tmp = Root:Find("gotTicketBg/newTicketNum").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.newTicketNum = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function LevelUpgradeToast:SetLocalizedText(Root)

    local locObj_LevelUpgradeToast_desc = Root:Find("desc")
    if locObj_LevelUpgradeToast_desc then
        locObj_LevelUpgradeToast_desc.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.LevelUpgradeToast_desc
    end

    local locObj_LevelUpgradeToast_TicketTitle = Root:Find("gotTicketBg/TicketTitle")
    if locObj_LevelUpgradeToast_TicketTitle then
        locObj_LevelUpgradeToast_TicketTitle.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.LevelUpgradeToast_TicketTitle
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return LevelUpgradeToast