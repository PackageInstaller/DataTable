---@class SimulatedRewardPanel_Generate_customMsgPanel
---@field public gameObject UnityEngine.GameObject
---@field public customMsgPanel CustomMsgPanel

---@class SimulatedRewardPanel_Generate_customBox
---@field public gameObject UnityEngine.GameObject
---@field public customBox CustomBox

---@class SimulatedRewardPanel_Generate_rewardBox_levelTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class SimulatedRewardPanel_Generate_rewardBox_levelTips
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class SimulatedRewardPanel_Generate_rewardBox_taskOkBtn
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class SimulatedRewardPanel_Generate_rewardBox_taskGetBtn
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class SimulatedRewardPanel_Generate_rewardBox_text
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class SimulatedRewardPanel_Generate_rewardBox
---@field public gameObject UnityEngine.GameObject
---@field public canvasGroup UnityEngine.CanvasGroup
---@field public taskInBtn UnityEngine.GameObject
---@field public text SimulatedRewardPanel_Generate_rewardBox_text
---@field public taskGetBtn SimulatedRewardPanel_Generate_rewardBox_taskGetBtn
---@field public taskOkBtn SimulatedRewardPanel_Generate_rewardBox_taskOkBtn
---@field public levelTips SimulatedRewardPanel_Generate_rewardBox_levelTips
---@field public levelTxt SimulatedRewardPanel_Generate_rewardBox_levelTxt
---@field public rewardList UnityEngine.GameObject
---@field public mask UnityEngine.GameObject

---@class SimulatedRewardPanel_Generate_closeBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class SimulatedRewardPanel_Generate_titleText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class SimulatedRewardPanel_Generate_mask
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class SimulatedRewardPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public mask SimulatedRewardPanel_Generate_mask
---@field public titleText SimulatedRewardPanel_Generate_titleText
---@field public closeBtn SimulatedRewardPanel_Generate_closeBtn
---@field public content UnityEngine.GameObject
---@field public rewardBox SimulatedRewardPanel_Generate_rewardBox
---@field public customBox SimulatedRewardPanel_Generate_customBox
---@field public customMsgPanel SimulatedRewardPanel_Generate_customMsgPanel
local SimulatedRewardPanel = class("SimulatedRewardPanel", require("WndBase"))

function SimulatedRewardPanel:ctor(data)
end

---@private
function SimulatedRewardPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("SimulatedRewardPanel")

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
	self:InitGenerate__12(Root,data)
	self:InitGenerate__13(Root,data)
	self:InitGenerate__14(Root,data)
	self:InitGenerate__15(Root,data)
	self:InitGenerate__16(Root,data)

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function SimulatedRewardPanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function SimulatedRewardPanel:InitGenerate__2(Root, data)
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
		UIMgr:SendUiUseMessage("SimulatedRewardPanel_mask")
			if self.mask_Button_onClick then
				self:mask_Button_onClick(self.mask)
			end
		end)


end

---@private
function SimulatedRewardPanel:InitGenerate__3(Root, data)
--[[
	BoxBg/TitleSideBg/Titlebg/TitleText
--]]
	local tmp = Root:Find("BoxBg/TitleSideBg/Titlebg/TitleText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.titleText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function SimulatedRewardPanel:InitGenerate__4(Root, data)
--[[
	BoxBg/TitleSideBg/CloseBtn
--]]
	local tmp = Root:Find("BoxBg/TitleSideBg/CloseBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.closeBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("SimulatedRewardPanel_closeBtn")
			if self.closeBtn_ScaleButton_onClick then
				self:closeBtn_ScaleButton_onClick(self.closeBtn)
			end
		end)


end

---@private
function SimulatedRewardPanel:InitGenerate__5(Root, data)
--[[
	BoxBg/RewardBoxList/Viewport/Content
--]]
	local tmp = Root:Find("BoxBg/RewardBoxList/Viewport/Content").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.content = tmp


end

---@private
function SimulatedRewardPanel:InitGenerate__6(Root, data)
--[[
	BoxBg/RewardBox
--]]
	local tmp = Root:Find("BoxBg/RewardBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rewardBox = tmp

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function SimulatedRewardPanel:InitGenerate__7(Root, data)
--[[
	BoxBg/RewardBox/TaskInBtn
--]]
	local tmp = Root:Find("BoxBg/RewardBox/TaskInBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rewardBox.taskInBtn = tmp


end

---@private
function SimulatedRewardPanel:InitGenerate__8(Root, data)
--[[
	BoxBg/RewardBox/TaskInBtn/Text
--]]
	local tmp = Root:Find("BoxBg/RewardBox/TaskInBtn/Text").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rewardBox.text = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function SimulatedRewardPanel:InitGenerate__9(Root, data)
--[[
	BoxBg/RewardBox/TaskGetBtn
--]]
	local tmp = Root:Find("BoxBg/RewardBox/TaskGetBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rewardBox.taskGetBtn = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)


end

---@private
function SimulatedRewardPanel:InitGenerate__10(Root, data)
--[[
	BoxBg/RewardBox/TaskOkBtn
--]]
	local tmp = Root:Find("BoxBg/RewardBox/TaskOkBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rewardBox.taskOkBtn = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)


end

---@private
function SimulatedRewardPanel:InitGenerate__11(Root, data)
--[[
	BoxBg/RewardBox/LevelTips
--]]
	local tmp = Root:Find("BoxBg/RewardBox/LevelTips").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rewardBox.levelTips = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function SimulatedRewardPanel:InitGenerate__12(Root, data)
--[[
	BoxBg/RewardBox/LevelTxt
--]]
	local tmp = Root:Find("BoxBg/RewardBox/LevelTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rewardBox.levelTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function SimulatedRewardPanel:InitGenerate__13(Root, data)
--[[
	BoxBg/RewardBox/RewardList
--]]
	local tmp = Root:Find("BoxBg/RewardBox/RewardList").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rewardBox.rewardList = tmp


end

---@private
function SimulatedRewardPanel:InitGenerate__14(Root, data)
--[[
	BoxBg/RewardBox/mask
--]]
	local tmp = Root:Find("BoxBg/RewardBox/mask").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rewardBox.mask = tmp


end

---@private
function SimulatedRewardPanel:InitGenerate__15(Root, data)
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

---@private
function SimulatedRewardPanel:InitGenerate__16(Root, data)
--[[
	CustomMsgPanel
--]]
	local tmp = Root:Find("CustomMsgPanel").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.customMsgPanel = tmp

	tmp.customMsgPanel = tmp:AddComponentLua("CustomMsgPanel", data)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function SimulatedRewardPanel:SetLocalizedText(Root)

    local locObj_SimulatedRewardPanel_TitleText2 = Root:Find("BoxBg/TitleSideBg/Titlebg/TitleText2")
    if locObj_SimulatedRewardPanel_TitleText2 then
        locObj_SimulatedRewardPanel_TitleText2.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.SimulatedRewardPanel_TitleText2
    end

    local locObj_SimulatedRewardPanel_Text = Root:Find("BoxBg/RewardBox/TaskGetBtn/Text")
    if locObj_SimulatedRewardPanel_Text then
        locObj_SimulatedRewardPanel_Text.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.SimulatedRewardPanel_Text
    end

    local locObj_SimulatedRewardPanel_Tn_Text = Root:Find("BoxBg/RewardBox/TaskOkBtn/Text")
    if locObj_SimulatedRewardPanel_Tn_Text then
        locObj_SimulatedRewardPanel_Tn_Text.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.SimulatedRewardPanel_Tn_Text
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return SimulatedRewardPanel