---@class EquipLevelPanel_Generate_msgTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class EquipLevelPanel_Generate_rankTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class EquipLevelPanel_Generate_mask
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class EquipLevelPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public mask EquipLevelPanel_Generate_mask
---@field public rankTxt EquipLevelPanel_Generate_rankTxt
---@field public msgTxt EquipLevelPanel_Generate_msgTxt
local EquipLevelPanel = class("EquipLevelPanel", require("WndBase"))

function EquipLevelPanel:ctor(data)
end

---@private
function EquipLevelPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("EquipLevelPanel")

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
function EquipLevelPanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function EquipLevelPanel:InitGenerate__2(Root, data)
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
		UIMgr:SendUiUseMessage("EquipLevelPanel_mask")
			if self.mask_Button_onClick then
				self:mask_Button_onClick(self.mask)
			end
		end)


end

---@private
function EquipLevelPanel:InitGenerate__3(Root, data)
--[[
	RankBg/RankTxt
--]]
	local tmp = Root:Find("RankBg/RankTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rankTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function EquipLevelPanel:InitGenerate__4(Root, data)
--[[
	MsgTxt
--]]
	local tmp = Root:Find("MsgTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.msgTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function EquipLevelPanel:SetLocalizedText(Root)

    local locObj_StarUpPanel_Tips = Root:Find("Tips")
    if locObj_StarUpPanel_Tips then
        locObj_StarUpPanel_Tips.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.StarUpPanel_Tips
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return EquipLevelPanel