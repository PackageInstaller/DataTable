---@class SimulatedSweepRewardPanel_Generate_customBox
---@field public gameObject UnityEngine.GameObject
---@field public customBox CustomBox

---@class SimulatedSweepRewardPanel_Generate_okBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class SimulatedSweepRewardPanel_Generate_expSlider
---@field public gameObject UnityEngine.GameObject
---@field public slider UnityEngine.UI.Slider

---@class SimulatedSweepRewardPanel_Generate_addExpText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class SimulatedSweepRewardPanel_Generate_nowExpText
---@field public gameObject UnityEngine.GameObject
---@field public text UnityEngine.UI.Text

---@class SimulatedSweepRewardPanel_Generate_levelText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class SimulatedSweepRewardPanel_Generate_levelNameText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class SimulatedSweepRewardPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public allRewardList UnityEngine.GameObject
---@field public levelNameText SimulatedSweepRewardPanel_Generate_levelNameText
---@field public levelText SimulatedSweepRewardPanel_Generate_levelText
---@field public nowExpText SimulatedSweepRewardPanel_Generate_nowExpText
---@field public addExpText SimulatedSweepRewardPanel_Generate_addExpText
---@field public expSlider SimulatedSweepRewardPanel_Generate_expSlider
---@field public okBtn SimulatedSweepRewardPanel_Generate_okBtn
---@field public customBox SimulatedSweepRewardPanel_Generate_customBox
local SimulatedSweepRewardPanel = class("SimulatedSweepRewardPanel", require("WndBase"))

function SimulatedSweepRewardPanel:ctor(data)
end

---@private
function SimulatedSweepRewardPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("SimulatedSweepRewardPanel")

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
function SimulatedSweepRewardPanel:InitGenerate__1(Root, data)
--[[
	SingleReward/ScrollView/Viewport/AllRewardList
--]]
	local tmp = Root:Find("SingleReward/ScrollView/Viewport/AllRewardList").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.allRewardList = tmp


end

---@private
function SimulatedSweepRewardPanel:InitGenerate__2(Root, data)
--[[
	ResultInfo/LevelNameBg/LevelNameText
--]]
	local tmp = Root:Find("ResultInfo/LevelNameBg/LevelNameText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.levelNameText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function SimulatedSweepRewardPanel:InitGenerate__3(Root, data)
--[[
	ResultInfo/UserLevelBg/LevelText
--]]
	local tmp = Root:Find("ResultInfo/UserLevelBg/LevelText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.levelText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function SimulatedSweepRewardPanel:InitGenerate__4(Root, data)
--[[
	ResultInfo/UserLevelBg/NowExpText
--]]
	local tmp = Root:Find("ResultInfo/UserLevelBg/NowExpText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.nowExpText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.Text)


end

---@private
function SimulatedSweepRewardPanel:InitGenerate__5(Root, data)
--[[
	ResultInfo/UserLevelBg/AddExpText
--]]
	local tmp = Root:Find("ResultInfo/UserLevelBg/AddExpText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.addExpText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function SimulatedSweepRewardPanel:InitGenerate__6(Root, data)
--[[
	ResultInfo/UserLevelBg/ExpSlider
--]]
	local tmp = Root:Find("ResultInfo/UserLevelBg/ExpSlider").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.expSlider = tmp

	tmp.slider = tmp:GetComponent(TypeInfo.Slider)


end

---@private
function SimulatedSweepRewardPanel:InitGenerate__7(Root, data)
--[[
	OkBtn
--]]
	local tmp = Root:Find("OkBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.okBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("SimulatedSweepRewardPanel_okBtn")
			if self.okBtn_ScaleButton_onClick then
				self:okBtn_ScaleButton_onClick(self.okBtn)
			end
		end)


end

---@private
function SimulatedSweepRewardPanel:InitGenerate__8(Root, data)
--[[
	CustomBox
--]]
	local tmp = Root:Find("CustomBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.customBox = tmp

	tmp.customBox = tmp:AddComponentLua("CustomBox", data)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function SimulatedSweepRewardPanel:SetLocalizedText(Root)

    local locObj_SimulatedSweepRewardPanel_SingleRewardTitle = Root:Find("SingleReward/SingleRewardTitleBg/SingleRewardTitle")
    if locObj_SimulatedSweepRewardPanel_SingleRewardTitle then
        locObj_SimulatedSweepRewardPanel_SingleRewardTitle.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.SimulatedSweepRewardPanel_SingleRewardTitle
    end

    local locObj_SimulatedSweepRewardPanel_LevelNameTitle = Root:Find("ResultInfo/LevelNameBg/LevelNameTitleBg/LevelNameTitle")
    if locObj_SimulatedSweepRewardPanel_LevelNameTitle then
        locObj_SimulatedSweepRewardPanel_LevelNameTitle.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.SimulatedSweepRewardPanel_LevelNameTitle
    end

    local locObj_SimulatedSweepRewardPanel_UserLevelTitle = Root:Find("ResultInfo/UserLevelBg/UserLevelTitleBg/UserLevelTitle")
    if locObj_SimulatedSweepRewardPanel_UserLevelTitle then
        locObj_SimulatedSweepRewardPanel_UserLevelTitle.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.SimulatedSweepRewardPanel_UserLevelTitle
    end

    local locObj_SimulatedSweepRewardPanel_LevelHeadText = Root:Find("ResultInfo/UserLevelBg/LevelText/LevelHeadText")
    if locObj_SimulatedSweepRewardPanel_LevelHeadText then
        locObj_SimulatedSweepRewardPanel_LevelHeadText.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.SimulatedSweepRewardPanel_LevelHeadText
    end

    local locObj_SimulatedSweepRewardPanel_RoleFavorabilityTitle = Root:Find("ResultInfo/RoleFavorabilityBg/RoleFavorabilityTitleBg/RoleFavorabilityTitle")
    if locObj_SimulatedSweepRewardPanel_RoleFavorabilityTitle then
        locObj_SimulatedSweepRewardPanel_RoleFavorabilityTitle.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.SimulatedSweepRewardPanel_RoleFavorabilityTitle
    end

    local locObj_SimulatedSweepRewardPanel_RoleFavorabilityText = Root:Find("ResultInfo/RoleFavorabilityBg/RoleFavorabilityTextBg/RoleFavorabilityText")
    if locObj_SimulatedSweepRewardPanel_RoleFavorabilityText then
        locObj_SimulatedSweepRewardPanel_RoleFavorabilityText.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.SimulatedSweepRewardPanel_RoleFavorabilityText
    end

    local locObj_SimulatedSweepRewardPanel_txt = Root:Find("OkBtn/txt")
    if locObj_SimulatedSweepRewardPanel_txt then
        locObj_SimulatedSweepRewardPanel_txt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.SimulatedSweepRewardPanel_txt
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return SimulatedSweepRewardPanel