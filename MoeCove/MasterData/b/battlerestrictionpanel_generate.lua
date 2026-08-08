---@class BattleRestrictionPanel_Generate_closeBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class BattleRestrictionPanel_Generate_mask
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class BattleRestrictionPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public mask BattleRestrictionPanel_Generate_mask
---@field public closeBtn BattleRestrictionPanel_Generate_closeBtn
local BattleRestrictionPanel = class("BattleRestrictionPanel", require("WndBase"))

function BattleRestrictionPanel:ctor(data)
end

---@private
function BattleRestrictionPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("BattleRestrictionPanel")

	local Root = self.transform 
	local tmp

	self:InitGenerate__1(Root,data)
	self:InitGenerate__2(Root,data)
	self:InitGenerate__3(Root,data)

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function BattleRestrictionPanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function BattleRestrictionPanel:InitGenerate__2(Root, data)
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
		UIMgr:SendUiUseMessage("BattleRestrictionPanel_mask")
			if self.mask_Button_onClick then
				self:mask_Button_onClick(self.mask)
			end
		end)


end

---@private
function BattleRestrictionPanel:InitGenerate__3(Root, data)
--[[
	BoxBg/titleBg/CloseBtn
--]]
	local tmp = Root:Find("BoxBg/titleBg/CloseBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.closeBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("BattleRestrictionPanel_closeBtn")
			if self.closeBtn_ScaleButton_onClick then
				self:closeBtn_ScaleButton_onClick(self.closeBtn)
			end
		end)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function BattleRestrictionPanel:SetLocalizedText(Root)

    local locObj_BattleRestrictionPanel_TitleText = Root:Find("BoxBg/titleBg/BoxTitleBg/TitleText")
    if locObj_BattleRestrictionPanel_TitleText then
        locObj_BattleRestrictionPanel_TitleText.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.BattleRestrictionPanel_TitleText
    end

    local locObj_BattleRestrictionPanel_TipText = Root:Find("BoxBg/TipText")
    if locObj_BattleRestrictionPanel_TipText then
        locObj_BattleRestrictionPanel_TipText.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.BattleRestrictionPanel_TipText
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return BattleRestrictionPanel