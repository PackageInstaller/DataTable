---@class WeeklyBossRewardPanel_Generate_customMsgPanel
---@field public gameObject UnityEngine.GameObject
---@field public customMsgPanel CustomMsgPanel

---@class WeeklyBossRewardPanel_Generate_customBox
---@field public gameObject UnityEngine.GameObject
---@field public customBox CustomBox

---@class WeeklyBossRewardPanel_Generate_allScoreTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class WeeklyBossRewardPanel_Generate_oneClickDisable
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class WeeklyBossRewardPanel_Generate_oneClickBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class WeeklyBossRewardPanel_Generate_rewardBox_taskDesc
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class WeeklyBossRewardPanel_Generate_rewardBox_taskOkBtn
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class WeeklyBossRewardPanel_Generate_rewardBox_taskGetBtn
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class WeeklyBossRewardPanel_Generate_rewardBox_text
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class WeeklyBossRewardPanel_Generate_rewardBox
---@field public gameObject UnityEngine.GameObject
---@field public canvasGroup UnityEngine.CanvasGroup
---@field public taskInBtn UnityEngine.GameObject
---@field public text WeeklyBossRewardPanel_Generate_rewardBox_text
---@field public taskGetBtn WeeklyBossRewardPanel_Generate_rewardBox_taskGetBtn
---@field public taskOkBtn WeeklyBossRewardPanel_Generate_rewardBox_taskOkBtn
---@field public taskDesc WeeklyBossRewardPanel_Generate_rewardBox_taskDesc
---@field public rewardList UnityEngine.GameObject
---@field public mask UnityEngine.GameObject

---@class WeeklyBossRewardPanel_Generate_closeBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class WeeklyBossRewardPanel_Generate_mask
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class WeeklyBossRewardPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public mask WeeklyBossRewardPanel_Generate_mask
---@field public closeBtn WeeklyBossRewardPanel_Generate_closeBtn
---@field public content UnityEngine.GameObject
---@field public rewardBox WeeklyBossRewardPanel_Generate_rewardBox
---@field public oneClickBtn WeeklyBossRewardPanel_Generate_oneClickBtn
---@field public oneClickDisable WeeklyBossRewardPanel_Generate_oneClickDisable
---@field public allScoreTxt WeeklyBossRewardPanel_Generate_allScoreTxt
---@field public customBox WeeklyBossRewardPanel_Generate_customBox
---@field public customMsgPanel WeeklyBossRewardPanel_Generate_customMsgPanel
local WeeklyBossRewardPanel = class("WeeklyBossRewardPanel", require("WndBase"))

function WeeklyBossRewardPanel:ctor(data)
end

---@private
function WeeklyBossRewardPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("WeeklyBossRewardPanel")

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
	self:InitGenerate__17(Root,data)

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function WeeklyBossRewardPanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function WeeklyBossRewardPanel:InitGenerate__2(Root, data)
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
		UIMgr:SendUiUseMessage("WeeklyBossRewardPanel_mask")
			if self.mask_Button_onClick then
				self:mask_Button_onClick(self.mask)
			end
		end)


end

---@private
function WeeklyBossRewardPanel:InitGenerate__3(Root, data)
--[[
	BoxBg/CloseBtn
--]]
	local tmp = Root:Find("BoxBg/CloseBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.closeBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("WeeklyBossRewardPanel_closeBtn")
			if self.closeBtn_ScaleButton_onClick then
				self:closeBtn_ScaleButton_onClick(self.closeBtn)
			end
		end)


end

---@private
function WeeklyBossRewardPanel:InitGenerate__4(Root, data)
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
function WeeklyBossRewardPanel:InitGenerate__5(Root, data)
--[[
	BoxBg/RewardBoxList/Viewport/Content/RewardBox
--]]
	local tmp = Root:Find("BoxBg/RewardBoxList/Viewport/Content/RewardBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rewardBox = tmp

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function WeeklyBossRewardPanel:InitGenerate__6(Root, data)
--[[
	BoxBg/RewardBoxList/Viewport/Content/RewardBox/TaskInBtn
--]]
	local tmp = Root:Find("BoxBg/RewardBoxList/Viewport/Content/RewardBox/TaskInBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rewardBox.taskInBtn = tmp


end

---@private
function WeeklyBossRewardPanel:InitGenerate__7(Root, data)
--[[
	BoxBg/RewardBoxList/Viewport/Content/RewardBox/TaskInBtn/Text
--]]
	local tmp = Root:Find("BoxBg/RewardBoxList/Viewport/Content/RewardBox/TaskInBtn/Text").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rewardBox.text = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function WeeklyBossRewardPanel:InitGenerate__8(Root, data)
--[[
	BoxBg/RewardBoxList/Viewport/Content/RewardBox/TaskGetBtn
--]]
	local tmp = Root:Find("BoxBg/RewardBoxList/Viewport/Content/RewardBox/TaskGetBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rewardBox.taskGetBtn = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)


end

---@private
function WeeklyBossRewardPanel:InitGenerate__9(Root, data)
--[[
	BoxBg/RewardBoxList/Viewport/Content/RewardBox/TaskOkBtn
--]]
	local tmp = Root:Find("BoxBg/RewardBoxList/Viewport/Content/RewardBox/TaskOkBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rewardBox.taskOkBtn = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)


end

---@private
function WeeklyBossRewardPanel:InitGenerate__10(Root, data)
--[[
	BoxBg/RewardBoxList/Viewport/Content/RewardBox/TaskDesc
--]]
	local tmp = Root:Find("BoxBg/RewardBoxList/Viewport/Content/RewardBox/TaskDesc").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rewardBox.taskDesc = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function WeeklyBossRewardPanel:InitGenerate__11(Root, data)
--[[
	BoxBg/RewardBoxList/Viewport/Content/RewardBox/RewardList
--]]
	local tmp = Root:Find("BoxBg/RewardBoxList/Viewport/Content/RewardBox/RewardList").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rewardBox.rewardList = tmp


end

---@private
function WeeklyBossRewardPanel:InitGenerate__12(Root, data)
--[[
	BoxBg/RewardBoxList/Viewport/Content/RewardBox/mask
--]]
	local tmp = Root:Find("BoxBg/RewardBoxList/Viewport/Content/RewardBox/mask").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rewardBox.mask = tmp


end

---@private
function WeeklyBossRewardPanel:InitGenerate__13(Root, data)
--[[
	BoxBg/OneClickBtn
--]]
	local tmp = Root:Find("BoxBg/OneClickBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.oneClickBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("WeeklyBossRewardPanel_oneClickBtn")
			if self.oneClickBtn_ScaleButton_onClick then
				self:oneClickBtn_ScaleButton_onClick(self.oneClickBtn)
			end
		end)


end

---@private
function WeeklyBossRewardPanel:InitGenerate__14(Root, data)
--[[
	BoxBg/OneClickDisable
--]]
	local tmp = Root:Find("BoxBg/OneClickDisable").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.oneClickDisable = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)


end

---@private
function WeeklyBossRewardPanel:InitGenerate__15(Root, data)
--[[
	BoxBg/AllScoreBg/AllScoreTxt
--]]
	local tmp = Root:Find("BoxBg/AllScoreBg/AllScoreTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.allScoreTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function WeeklyBossRewardPanel:InitGenerate__16(Root, data)
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
function WeeklyBossRewardPanel:InitGenerate__17(Root, data)
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

function WeeklyBossRewardPanel:SetLocalizedText(Root)

    local locObj_WeeklyBossRewardPanel_TitleTxt = Root:Find("BoxBg/TitleBg/TitleTxt")
    if locObj_WeeklyBossRewardPanel_TitleTxt then
        locObj_WeeklyBossRewardPanel_TitleTxt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.WeeklyBossRewardPanel_TitleTxt
    end

    local locObj_WeeklyBossRewardPanel_Text = Root:Find("BoxBg/RewardBoxList/Viewport/Content/RewardBox/TaskGetBtn/Text")
    if locObj_WeeklyBossRewardPanel_Text then
        locObj_WeeklyBossRewardPanel_Text.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.WeeklyBossRewardPanel_Text
    end

    local locObj_WeeklyBossRewardPanel_Tn_Text = Root:Find("BoxBg/RewardBoxList/Viewport/Content/RewardBox/TaskOkBtn/Text")
    if locObj_WeeklyBossRewardPanel_Tn_Text then
        locObj_WeeklyBossRewardPanel_Tn_Text.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.WeeklyBossRewardPanel_Tn_Text
    end

    local locObj_WeeklyBossRewardPanel_txt = Root:Find("BoxBg/OneClickBtn/txt")
    if locObj_WeeklyBossRewardPanel_txt then
        locObj_WeeklyBossRewardPanel_txt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.WeeklyBossRewardPanel_txt
    end

    local locObj_WeeklyBossRewardPanel_txt = Root:Find("BoxBg/OneClickDisable/txt")
    if locObj_WeeklyBossRewardPanel_txt then
        locObj_WeeklyBossRewardPanel_txt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.WeeklyBossRewardPanel_txt
    end

    local locObj_WeeklyBossRewardPanel_AllScoreTitle = Root:Find("BoxBg/AllScoreBg/AllScoreTitle")
    if locObj_WeeklyBossRewardPanel_AllScoreTitle then
        locObj_WeeklyBossRewardPanel_AllScoreTitle.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.WeeklyBossRewardPanel_AllScoreTitle
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return WeeklyBossRewardPanel