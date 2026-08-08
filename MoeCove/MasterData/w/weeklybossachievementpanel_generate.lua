---@class WeeklyBossAchievementPanel_Generate_customMsgPanel
---@field public gameObject UnityEngine.GameObject
---@field public customMsgPanel CustomMsgPanel

---@class WeeklyBossAchievementPanel_Generate_customBox
---@field public gameObject UnityEngine.GameObject
---@field public customBox CustomBox

---@class WeeklyBossAchievementPanel_Generate_historyDiffTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class WeeklyBossAchievementPanel_Generate_historyScoreTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class WeeklyBossAchievementPanel_Generate_oneClickDisable
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class WeeklyBossAchievementPanel_Generate_oneClickBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class WeeklyBossAchievementPanel_Generate_bossBox_bossIcon
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class WeeklyBossAchievementPanel_Generate_bossBox
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton
---@field public bossIcon WeeklyBossAchievementPanel_Generate_bossBox_bossIcon
---@field public isSelect UnityEngine.GameObject
---@field public notOpen UnityEngine.GameObject
---@field public redPoint UnityEngine.GameObject

---@class WeeklyBossAchievementPanel_Generate_rewardBox_taskDesc
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class WeeklyBossAchievementPanel_Generate_rewardBox_taskType
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class WeeklyBossAchievementPanel_Generate_rewardBox_progressing
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class WeeklyBossAchievementPanel_Generate_rewardBox_frame
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class WeeklyBossAchievementPanel_Generate_rewardBox_taskOkBtn
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class WeeklyBossAchievementPanel_Generate_rewardBox_taskGetBtn
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class WeeklyBossAchievementPanel_Generate_rewardBox_text
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class WeeklyBossAchievementPanel_Generate_rewardBox
---@field public gameObject UnityEngine.GameObject
---@field public canvasGroup UnityEngine.CanvasGroup
---@field public taskInBtn UnityEngine.GameObject
---@field public text WeeklyBossAchievementPanel_Generate_rewardBox_text
---@field public taskGetBtn WeeklyBossAchievementPanel_Generate_rewardBox_taskGetBtn
---@field public taskOkBtn WeeklyBossAchievementPanel_Generate_rewardBox_taskOkBtn
---@field public frame WeeklyBossAchievementPanel_Generate_rewardBox_frame
---@field public progressing WeeklyBossAchievementPanel_Generate_rewardBox_progressing
---@field public progressFull UnityEngine.GameObject
---@field public taskType WeeklyBossAchievementPanel_Generate_rewardBox_taskType
---@field public taskDesc WeeklyBossAchievementPanel_Generate_rewardBox_taskDesc
---@field public rewardList UnityEngine.GameObject
---@field public mask UnityEngine.GameObject

---@class WeeklyBossAchievementPanel_Generate_mask
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class WeeklyBossAchievementPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public mask WeeklyBossAchievementPanel_Generate_mask
---@field public content UnityEngine.GameObject
---@field public rewardBox WeeklyBossAchievementPanel_Generate_rewardBox
---@field public bossContent UnityEngine.GameObject
---@field public bossBox WeeklyBossAchievementPanel_Generate_bossBox
---@field public oneClickBtn WeeklyBossAchievementPanel_Generate_oneClickBtn
---@field public oneClickDisable WeeklyBossAchievementPanel_Generate_oneClickDisable
---@field public historyScoreTxt WeeklyBossAchievementPanel_Generate_historyScoreTxt
---@field public historyDiffTxt WeeklyBossAchievementPanel_Generate_historyDiffTxt
---@field public customBox WeeklyBossAchievementPanel_Generate_customBox
---@field public customMsgPanel WeeklyBossAchievementPanel_Generate_customMsgPanel
local WeeklyBossAchievementPanel = class("WeeklyBossAchievementPanel", require("WndBase"))

function WeeklyBossAchievementPanel:ctor(data)
end

---@private
function WeeklyBossAchievementPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("WeeklyBossAchievementPanel")

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
	self:InitGenerate__18(Root,data)
	self:InitGenerate__19(Root,data)
	self:InitGenerate__20(Root,data)
	self:InitGenerate__21(Root,data)
	self:InitGenerate__22(Root,data)
	self:InitGenerate__23(Root,data)
	self:InitGenerate__24(Root,data)
	self:InitGenerate__25(Root,data)
	self:InitGenerate__26(Root,data)
	self:InitGenerate__27(Root,data)

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function WeeklyBossAchievementPanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function WeeklyBossAchievementPanel:InitGenerate__2(Root, data)
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
		UIMgr:SendUiUseMessage("WeeklyBossAchievementPanel_mask")
			if self.mask_Button_onClick then
				self:mask_Button_onClick(self.mask)
			end
		end)


end

---@private
function WeeklyBossAchievementPanel:InitGenerate__3(Root, data)
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
function WeeklyBossAchievementPanel:InitGenerate__4(Root, data)
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
function WeeklyBossAchievementPanel:InitGenerate__5(Root, data)
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
function WeeklyBossAchievementPanel:InitGenerate__6(Root, data)
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
function WeeklyBossAchievementPanel:InitGenerate__7(Root, data)
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
function WeeklyBossAchievementPanel:InitGenerate__8(Root, data)
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
function WeeklyBossAchievementPanel:InitGenerate__9(Root, data)
--[[
	BoxBg/RewardBoxList/Viewport/Content/RewardBox/Frame
--]]
	local tmp = Root:Find("BoxBg/RewardBoxList/Viewport/Content/RewardBox/Frame").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rewardBox.frame = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function WeeklyBossAchievementPanel:InitGenerate__10(Root, data)
--[[
	BoxBg/RewardBoxList/Viewport/Content/RewardBox/Frame/Progressing
--]]
	local tmp = Root:Find("BoxBg/RewardBoxList/Viewport/Content/RewardBox/Frame/Progressing").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rewardBox.progressing = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function WeeklyBossAchievementPanel:InitGenerate__11(Root, data)
--[[
	BoxBg/RewardBoxList/Viewport/Content/RewardBox/Frame/ProgressFull
--]]
	local tmp = Root:Find("BoxBg/RewardBoxList/Viewport/Content/RewardBox/Frame/ProgressFull").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rewardBox.progressFull = tmp


end

---@private
function WeeklyBossAchievementPanel:InitGenerate__12(Root, data)
--[[
	BoxBg/RewardBoxList/Viewport/Content/RewardBox/TaskType
--]]
	local tmp = Root:Find("BoxBg/RewardBoxList/Viewport/Content/RewardBox/TaskType").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rewardBox.taskType = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function WeeklyBossAchievementPanel:InitGenerate__13(Root, data)
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
function WeeklyBossAchievementPanel:InitGenerate__14(Root, data)
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
function WeeklyBossAchievementPanel:InitGenerate__15(Root, data)
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
function WeeklyBossAchievementPanel:InitGenerate__16(Root, data)
--[[
	BoxBg/BossList/Viewport/BossContent
--]]
	local tmp = Root:Find("BoxBg/BossList/Viewport/BossContent").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.bossContent = tmp


end

---@private
function WeeklyBossAchievementPanel:InitGenerate__17(Root, data)
--[[
	BoxBg/BossList/Viewport/BossContent/BossBox
--]]
	local tmp = Root:Find("BoxBg/BossList/Viewport/BossContent/BossBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.bossBox = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)


end

---@private
function WeeklyBossAchievementPanel:InitGenerate__18(Root, data)
--[[
	BoxBg/BossList/Viewport/BossContent/BossBox/Mask/BossIcon
--]]
	local tmp = Root:Find("BoxBg/BossList/Viewport/BossContent/BossBox/Mask/BossIcon").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.bossBox.bossIcon = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function WeeklyBossAchievementPanel:InitGenerate__19(Root, data)
--[[
	BoxBg/BossList/Viewport/BossContent/BossBox/IsSelect
--]]
	local tmp = Root:Find("BoxBg/BossList/Viewport/BossContent/BossBox/IsSelect").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.bossBox.isSelect = tmp


end

---@private
function WeeklyBossAchievementPanel:InitGenerate__20(Root, data)
--[[
	BoxBg/BossList/Viewport/BossContent/BossBox/NotOpen
--]]
	local tmp = Root:Find("BoxBg/BossList/Viewport/BossContent/BossBox/NotOpen").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.bossBox.notOpen = tmp


end

---@private
function WeeklyBossAchievementPanel:InitGenerate__21(Root, data)
--[[
	BoxBg/BossList/Viewport/BossContent/BossBox/RedPoint
--]]
	local tmp = Root:Find("BoxBg/BossList/Viewport/BossContent/BossBox/RedPoint").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.bossBox.redPoint = tmp


end

---@private
function WeeklyBossAchievementPanel:InitGenerate__22(Root, data)
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
		UIMgr:SendUiUseMessage("WeeklyBossAchievementPanel_oneClickBtn")
			if self.oneClickBtn_ScaleButton_onClick then
				self:oneClickBtn_ScaleButton_onClick(self.oneClickBtn)
			end
		end)


end

---@private
function WeeklyBossAchievementPanel:InitGenerate__23(Root, data)
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
function WeeklyBossAchievementPanel:InitGenerate__24(Root, data)
--[[
	BoxBg/DifficultyAndScoreBg/HistoryScoreTxt
--]]
	local tmp = Root:Find("BoxBg/DifficultyAndScoreBg/HistoryScoreTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.historyScoreTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function WeeklyBossAchievementPanel:InitGenerate__25(Root, data)
--[[
	BoxBg/DifficultyAndScoreBg/HistoryDiffTitle/HistoryDiffTxt
--]]
	local tmp = Root:Find("BoxBg/DifficultyAndScoreBg/HistoryDiffTitle/HistoryDiffTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.historyDiffTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function WeeklyBossAchievementPanel:InitGenerate__26(Root, data)
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
function WeeklyBossAchievementPanel:InitGenerate__27(Root, data)
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

function WeeklyBossAchievementPanel:SetLocalizedText(Root)

    local locObj_WeeklyBossAchievementPanel_TitleTxt = Root:Find("BoxBg/TitleBg/TitleTxt")
    if locObj_WeeklyBossAchievementPanel_TitleTxt then
        locObj_WeeklyBossAchievementPanel_TitleTxt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.WeeklyBossAchievementPanel_TitleTxt
    end

    local locObj_WeeklyBossAchievementPanel_Text = Root:Find("BoxBg/RewardBoxList/Viewport/Content/RewardBox/TaskGetBtn/Text")
    if locObj_WeeklyBossAchievementPanel_Text then
        locObj_WeeklyBossAchievementPanel_Text.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.WeeklyBossAchievementPanel_Text
    end

    local locObj_WeeklyBossAchievementPanel_Tn_Text = Root:Find("BoxBg/RewardBoxList/Viewport/Content/RewardBox/TaskOkBtn/Text")
    if locObj_WeeklyBossAchievementPanel_Tn_Text then
        locObj_WeeklyBossAchievementPanel_Tn_Text.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.WeeklyBossAchievementPanel_Tn_Text
    end

    local locObj_WeeklyBossAchievementPanel_HistoryScoreTitle = Root:Find("BoxBg/DifficultyAndScoreBg/HistoryScoreTxt/HistoryScoreTitle")
    if locObj_WeeklyBossAchievementPanel_HistoryScoreTitle then
        locObj_WeeklyBossAchievementPanel_HistoryScoreTitle.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.WeeklyBossAchievementPanel_HistoryScoreTitle
    end

    local locObj_WeeklyBossAchievementPanel_HistoryDiffTitle = Root:Find("BoxBg/DifficultyAndScoreBg/HistoryDiffTitle")
    if locObj_WeeklyBossAchievementPanel_HistoryDiffTitle then
        locObj_WeeklyBossAchievementPanel_HistoryDiffTitle.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.WeeklyBossAchievementPanel_HistoryDiffTitle
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return WeeklyBossAchievementPanel