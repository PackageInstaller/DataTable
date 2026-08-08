---@class ProsperityLevelUpPanel_Generate_levelTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class ProsperityLevelUpPanel_Generate_bg
---@field public gameObject UnityEngine.GameObject
---@field public canvasGroup UnityEngine.CanvasGroup

---@class ProsperityLevelUpPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public bg ProsperityLevelUpPanel_Generate_bg
---@field public levelTxt ProsperityLevelUpPanel_Generate_levelTxt
local ProsperityLevelUpPanel = class("ProsperityLevelUpPanel", require("WndBase"))

function ProsperityLevelUpPanel:ctor(data)
end

---@private
function ProsperityLevelUpPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("ProsperityLevelUpPanel")

	local Root = self.transform 
	local tmp

	self:InitGenerate__1(Root,data)
	self:InitGenerate__2(Root,data)
	self:InitGenerate__3(Root,data)

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function ProsperityLevelUpPanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function ProsperityLevelUpPanel:InitGenerate__2(Root, data)
--[[
	bg
--]]
	local tmp = Root:Find("bg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.bg = tmp

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function ProsperityLevelUpPanel:InitGenerate__3(Root, data)
--[[
	bg/LevelTxt
--]]
	local tmp = Root:Find("bg/LevelTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.levelTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function ProsperityLevelUpPanel:SetLocalizedText(Root)

    local locObj_ProsperityLevelUpPanel_Lt_LV = Root:Find("bg/LevelTxt/LV")
    if locObj_ProsperityLevelUpPanel_Lt_LV then
        locObj_ProsperityLevelUpPanel_Lt_LV.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.ProsperityLevelUpPanel_Lt_LV
    end

    local locObj_ProsperityLevelUpPanel_bg_UpTxt = Root:Find("bg/UpTxt")
    if locObj_ProsperityLevelUpPanel_bg_UpTxt then
        locObj_ProsperityLevelUpPanel_bg_UpTxt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.ProsperityLevelUpPanel_bg_UpTxt
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return ProsperityLevelUpPanel