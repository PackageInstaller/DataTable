---@class WeeklyBossMainPanel_Generate_userGuidePanel
---@field public gameObject UnityEngine.GameObject
---@field public userGuidePanel UserGuidePanel

---@class WeeklyBossMainPanel_Generate_customBackPanel
---@field public gameObject UnityEngine.GameObject
---@field public customBackPanel CustomBackPanel

---@class WeeklyBossMainPanel_Generate_challengeBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class WeeklyBossMainPanel_Generate_nowMultiplierTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class WeeklyBossMainPanel_Generate_planningBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class WeeklyBossMainPanel_Generate_modeBox_modeTypeTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI
---@field public canvasGroup UnityEngine.CanvasGroup

---@class WeeklyBossMainPanel_Generate_modeBox
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton
---@field public isSelect UnityEngine.GameObject
---@field public modeTypeTxt WeeklyBossMainPanel_Generate_modeBox_modeTypeTxt
---@field public isLocked UnityEngine.GameObject

---@class WeeklyBossMainPanel_Generate_modeTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class WeeklyBossMainPanel_Generate_roleBox_shipTypeIcon
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class WeeklyBossMainPanel_Generate_roleBox_roleCutIcon
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class WeeklyBossMainPanel_Generate_roleBox
---@field public gameObject UnityEngine.GameObject
---@field public roleCutIcon WeeklyBossMainPanel_Generate_roleBox_roleCutIcon
---@field public shipTypeIcon WeeklyBossMainPanel_Generate_roleBox_shipTypeIcon

---@class WeeklyBossMainPanel_Generate_nowBossScoreTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class WeeklyBossMainPanel_Generate_bossName
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class WeeklyBossMainPanel_Generate_bossInfoBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class WeeklyBossMainPanel_Generate_achievementBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton
---@field public redPoint UnityEngine.GameObject

---@class WeeklyBossMainPanel_Generate_currentRewardsBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton
---@field public redPoint UnityEngine.GameObject

---@class WeeklyBossMainPanel_Generate_bossBox_maxScoreTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class WeeklyBossMainPanel_Generate_bossBox_scoreBg
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class WeeklyBossMainPanel_Generate_bossBox_nameTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class WeeklyBossMainPanel_Generate_bossBox_headIcon
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class WeeklyBossMainPanel_Generate_bossBox
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public button UnityEngine.UI.Button
---@field public headIcon WeeklyBossMainPanel_Generate_bossBox_headIcon
---@field public nameTxt WeeklyBossMainPanel_Generate_bossBox_nameTxt
---@field public scoreBg WeeklyBossMainPanel_Generate_bossBox_scoreBg
---@field public maxScoreTxt WeeklyBossMainPanel_Generate_bossBox_maxScoreTxt
---@field public isSelect UnityEngine.GameObject

---@class WeeklyBossMainPanel_Generate_resetTimeTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class WeeklyBossMainPanel_Generate_bossPicIcon
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image
---@field public canvasGroup UnityEngine.CanvasGroup

---@class WeeklyBossMainPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public bossPicIcon WeeklyBossMainPanel_Generate_bossPicIcon
---@field public resetTimeTxt WeeklyBossMainPanel_Generate_resetTimeTxt
---@field public bossBoxList UnityEngine.GameObject
---@field public bossBox WeeklyBossMainPanel_Generate_bossBox
---@field public currentRewardsBtn WeeklyBossMainPanel_Generate_currentRewardsBtn
---@field public achievementBtn WeeklyBossMainPanel_Generate_achievementBtn
---@field public bossInfoBtn WeeklyBossMainPanel_Generate_bossInfoBtn
---@field public bossName WeeklyBossMainPanel_Generate_bossName
---@field public nowBossScoreTxt WeeklyBossMainPanel_Generate_nowBossScoreTxt
---@field public buffRoleList UnityEngine.GameObject
---@field public roleBox WeeklyBossMainPanel_Generate_roleBox
---@field public modeTxt WeeklyBossMainPanel_Generate_modeTxt
---@field public modeBtnList UnityEngine.GameObject
---@field public modeBox WeeklyBossMainPanel_Generate_modeBox
---@field public planningBtn WeeklyBossMainPanel_Generate_planningBtn
---@field public nowMultiplierTxt WeeklyBossMainPanel_Generate_nowMultiplierTxt
---@field public challengeBtn WeeklyBossMainPanel_Generate_challengeBtn
---@field public effect_Ui_ZhouChangBoss_1 UnityEngine.GameObject
---@field public effect_Ui_ZhouChangBoss_2 UnityEngine.GameObject
---@field public customBackPanel WeeklyBossMainPanel_Generate_customBackPanel
---@field public userGuidePanel WeeklyBossMainPanel_Generate_userGuidePanel
local WeeklyBossMainPanel = class("WeeklyBossMainPanel", require("WndBase"))

function WeeklyBossMainPanel:ctor(data)
end

---@private
function WeeklyBossMainPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("WeeklyBossMainPanel")

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
	self:InitGenerate__28(Root,data)
	self:InitGenerate__29(Root,data)
	self:InitGenerate__30(Root,data)
	self:InitGenerate__31(Root,data)
	self:InitGenerate__32(Root,data)
	self:InitGenerate__33(Root,data)
	self:InitGenerate__34(Root,data)

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function WeeklyBossMainPanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function WeeklyBossMainPanel:InitGenerate__2(Root, data)
--[[
	BossPicIcon
--]]
	local tmp = Root:Find("BossPicIcon").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.bossPicIcon = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function WeeklyBossMainPanel:InitGenerate__3(Root, data)
--[[
	AdjustRoot/LeftArea/ResetTimeBg/ResetTimeTxt
--]]
	local tmp = Root:Find("AdjustRoot/LeftArea/ResetTimeBg/ResetTimeTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.resetTimeTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function WeeklyBossMainPanel:InitGenerate__4(Root, data)
--[[
	AdjustRoot/LeftArea/BossBoxArea/BossBoxList
--]]
	local tmp = Root:Find("AdjustRoot/LeftArea/BossBoxArea/BossBoxList").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.bossBoxList = tmp


end

---@private
function WeeklyBossMainPanel:InitGenerate__5(Root, data)
--[[
	AdjustRoot/LeftArea/BossBoxArea/BossBoxList/BossBox
--]]
	local tmp = Root:Find("AdjustRoot/LeftArea/BossBoxArea/BossBoxList/BossBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.bossBox = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)

	tmp.button = tmp:GetComponent(TypeInfo.Button)


end

---@private
function WeeklyBossMainPanel:InitGenerate__6(Root, data)
--[[
	AdjustRoot/LeftArea/BossBoxArea/BossBoxList/BossBox/HeadIcon
--]]
	local tmp = Root:Find("AdjustRoot/LeftArea/BossBoxArea/BossBoxList/BossBox/HeadIcon").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.bossBox.headIcon = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function WeeklyBossMainPanel:InitGenerate__7(Root, data)
--[[
	AdjustRoot/LeftArea/BossBoxArea/BossBoxList/BossBox/NameTxt
--]]
	local tmp = Root:Find("AdjustRoot/LeftArea/BossBoxArea/BossBoxList/BossBox/NameTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.bossBox.nameTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function WeeklyBossMainPanel:InitGenerate__8(Root, data)
--[[
	AdjustRoot/LeftArea/BossBoxArea/BossBoxList/BossBox/ScoreBg
--]]
	local tmp = Root:Find("AdjustRoot/LeftArea/BossBoxArea/BossBoxList/BossBox/ScoreBg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.bossBox.scoreBg = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function WeeklyBossMainPanel:InitGenerate__9(Root, data)
--[[
	AdjustRoot/LeftArea/BossBoxArea/BossBoxList/BossBox/ScoreBg/MaxScoreTxt
--]]
	local tmp = Root:Find("AdjustRoot/LeftArea/BossBoxArea/BossBoxList/BossBox/ScoreBg/MaxScoreTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.bossBox.maxScoreTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function WeeklyBossMainPanel:InitGenerate__10(Root, data)
--[[
	AdjustRoot/LeftArea/BossBoxArea/BossBoxList/BossBox/IsSelect
--]]
	local tmp = Root:Find("AdjustRoot/LeftArea/BossBoxArea/BossBoxList/BossBox/IsSelect").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.bossBox.isSelect = tmp


end

---@private
function WeeklyBossMainPanel:InitGenerate__11(Root, data)
--[[
	AdjustRoot/LeftArea/CurrentRewardsBtn
--]]
	local tmp = Root:Find("AdjustRoot/LeftArea/CurrentRewardsBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.currentRewardsBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("WeeklyBossMainPanel_currentRewardsBtn")
			if self.currentRewardsBtn_ScaleButton_onClick then
				self:currentRewardsBtn_ScaleButton_onClick(self.currentRewardsBtn)
			end
		end)


end

---@private
function WeeklyBossMainPanel:InitGenerate__12(Root, data)
--[[
	AdjustRoot/LeftArea/CurrentRewardsBtn/RedPoint
--]]
	local tmp = Root:Find("AdjustRoot/LeftArea/CurrentRewardsBtn/RedPoint").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.currentRewardsBtn.redPoint = tmp


end

---@private
function WeeklyBossMainPanel:InitGenerate__13(Root, data)
--[[
	AdjustRoot/LeftArea/AchievementBtn
--]]
	local tmp = Root:Find("AdjustRoot/LeftArea/AchievementBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.achievementBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("WeeklyBossMainPanel_achievementBtn")
			if self.achievementBtn_ScaleButton_onClick then
				self:achievementBtn_ScaleButton_onClick(self.achievementBtn)
			end
		end)


end

---@private
function WeeklyBossMainPanel:InitGenerate__14(Root, data)
--[[
	AdjustRoot/LeftArea/AchievementBtn/RedPoint
--]]
	local tmp = Root:Find("AdjustRoot/LeftArea/AchievementBtn/RedPoint").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.achievementBtn.redPoint = tmp


end

---@private
function WeeklyBossMainPanel:InitGenerate__15(Root, data)
--[[
	AdjustRoot/RightArea/BossInfoBg/BossInfoBtn
--]]
	local tmp = Root:Find("AdjustRoot/RightArea/BossInfoBg/BossInfoBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.bossInfoBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("WeeklyBossMainPanel_bossInfoBtn")
			if self.bossInfoBtn_ScaleButton_onClick then
				self:bossInfoBtn_ScaleButton_onClick(self.bossInfoBtn)
			end
		end)


end

---@private
function WeeklyBossMainPanel:InitGenerate__16(Root, data)
--[[
	AdjustRoot/RightArea/BossInfoBg/BossName
--]]
	local tmp = Root:Find("AdjustRoot/RightArea/BossInfoBg/BossName").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.bossName = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function WeeklyBossMainPanel:InitGenerate__17(Root, data)
--[[
	AdjustRoot/RightArea/BossInfoBg/NowBossScoreTxt
--]]
	local tmp = Root:Find("AdjustRoot/RightArea/BossInfoBg/NowBossScoreTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.nowBossScoreTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function WeeklyBossMainPanel:InitGenerate__18(Root, data)
--[[
	AdjustRoot/RightArea/BuffCharacterArea/ScrollView/Viewport/BuffRoleList
--]]
	local tmp = Root:Find("AdjustRoot/RightArea/BuffCharacterArea/ScrollView/Viewport/BuffRoleList").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.buffRoleList = tmp


end

---@private
function WeeklyBossMainPanel:InitGenerate__19(Root, data)
--[[
	AdjustRoot/RightArea/BuffCharacterArea/ScrollView/Viewport/BuffRoleList/RoleBox
--]]
	local tmp = Root:Find("AdjustRoot/RightArea/BuffCharacterArea/ScrollView/Viewport/BuffRoleList/RoleBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.roleBox = tmp


end

---@private
function WeeklyBossMainPanel:InitGenerate__20(Root, data)
--[[
	AdjustRoot/RightArea/BuffCharacterArea/ScrollView/Viewport/BuffRoleList/RoleBox/RoleIconMask/RoleCutIcon
--]]
	local tmp = Root:Find("AdjustRoot/RightArea/BuffCharacterArea/ScrollView/Viewport/BuffRoleList/RoleBox/RoleIconMask/RoleCutIcon").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.roleBox.roleCutIcon = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function WeeklyBossMainPanel:InitGenerate__21(Root, data)
--[[
	AdjustRoot/RightArea/BuffCharacterArea/ScrollView/Viewport/BuffRoleList/RoleBox/ShipTypebg/ShipTypeIcon
--]]
	local tmp = Root:Find("AdjustRoot/RightArea/BuffCharacterArea/ScrollView/Viewport/BuffRoleList/RoleBox/ShipTypebg/ShipTypeIcon").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.roleBox.shipTypeIcon = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function WeeklyBossMainPanel:InitGenerate__22(Root, data)
--[[
	AdjustRoot/RightArea/ModeArea/ModeTxt
--]]
	local tmp = Root:Find("AdjustRoot/RightArea/ModeArea/ModeTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.modeTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function WeeklyBossMainPanel:InitGenerate__23(Root, data)
--[[
	AdjustRoot/RightArea/ModeArea/ModeBtnList
--]]
	local tmp = Root:Find("AdjustRoot/RightArea/ModeArea/ModeBtnList").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.modeBtnList = tmp


end

---@private
function WeeklyBossMainPanel:InitGenerate__24(Root, data)
--[[
	AdjustRoot/RightArea/ModeArea/ModeBtnList/ModeBox
--]]
	local tmp = Root:Find("AdjustRoot/RightArea/ModeArea/ModeBtnList/ModeBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.modeBox = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)


end

---@private
function WeeklyBossMainPanel:InitGenerate__25(Root, data)
--[[
	AdjustRoot/RightArea/ModeArea/ModeBtnList/ModeBox/IsSelect
--]]
	local tmp = Root:Find("AdjustRoot/RightArea/ModeArea/ModeBtnList/ModeBox/IsSelect").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.modeBox.isSelect = tmp


end

---@private
function WeeklyBossMainPanel:InitGenerate__26(Root, data)
--[[
	AdjustRoot/RightArea/ModeArea/ModeBtnList/ModeBox/ModeTypeTxt
--]]
	local tmp = Root:Find("AdjustRoot/RightArea/ModeArea/ModeBtnList/ModeBox/ModeTypeTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.modeBox.modeTypeTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function WeeklyBossMainPanel:InitGenerate__27(Root, data)
--[[
	AdjustRoot/RightArea/ModeArea/ModeBtnList/ModeBox/IsLocked
--]]
	local tmp = Root:Find("AdjustRoot/RightArea/ModeArea/ModeBtnList/ModeBox/IsLocked").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.modeBox.isLocked = tmp


end

---@private
function WeeklyBossMainPanel:InitGenerate__28(Root, data)
--[[
	AdjustRoot/RightArea/PlanningBtn
--]]
	local tmp = Root:Find("AdjustRoot/RightArea/PlanningBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.planningBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("WeeklyBossMainPanel_planningBtn")
			if self.planningBtn_ScaleButton_onClick then
				self:planningBtn_ScaleButton_onClick(self.planningBtn)
			end
		end)


end

---@private
function WeeklyBossMainPanel:InitGenerate__29(Root, data)
--[[
	AdjustRoot/RightArea/PlanningBtn/NowMultiplierBg/NowMultiplierTxt
--]]
	local tmp = Root:Find("AdjustRoot/RightArea/PlanningBtn/NowMultiplierBg/NowMultiplierTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.nowMultiplierTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function WeeklyBossMainPanel:InitGenerate__30(Root, data)
--[[
	AdjustRoot/RightArea/ChallengeBtn
--]]
	local tmp = Root:Find("AdjustRoot/RightArea/ChallengeBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.challengeBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("WeeklyBossMainPanel_challengeBtn")
			if self.challengeBtn_ScaleButton_onClick then
				self:challengeBtn_ScaleButton_onClick(self.challengeBtn)
			end
		end)


end

---@private
function WeeklyBossMainPanel:InitGenerate__31(Root, data)
--[[
	EffectRoot/Effect_Ui_ZhouChangBoss_1
--]]
	local tmp = Root:Find("EffectRoot/Effect_Ui_ZhouChangBoss_1").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.effect_Ui_ZhouChangBoss_1 = tmp


end

---@private
function WeeklyBossMainPanel:InitGenerate__32(Root, data)
--[[
	EffectRoot/Effect_Ui_ZhouChangBoss_2
--]]
	local tmp = Root:Find("EffectRoot/Effect_Ui_ZhouChangBoss_2").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.effect_Ui_ZhouChangBoss_2 = tmp


end

---@private
function WeeklyBossMainPanel:InitGenerate__33(Root, data)
--[[
	CustomBackPanel
--]]
	local tmp = Root:Find("CustomBackPanel").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.customBackPanel = tmp

	tmp.customBackPanel = tmp:AddComponentLua("CustomBackPanel", data)


end

---@private
function WeeklyBossMainPanel:InitGenerate__34(Root, data)
--[[
	UserGuidePanel
--]]
	local tmp = Root:Find("UserGuidePanel").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.userGuidePanel = tmp

	tmp.userGuidePanel = tmp:AddComponentLua("UserGuidePanel", data)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function WeeklyBossMainPanel:SetLocalizedText(Root)

    local locObj_WeeklyBossMainPanel_Tg_TitleTxt = Root:Find("AdjustRoot/LeftArea/CurrentRewardsBtn/TitleBg/TitleTxt")
    if locObj_WeeklyBossMainPanel_Tg_TitleTxt then
        locObj_WeeklyBossMainPanel_Tg_TitleTxt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.WeeklyBossMainPanel_Tg_TitleTxt
    end

    local locObj_WeeklyBossMainPanel_An_Tg_TitleTxt = Root:Find("AdjustRoot/LeftArea/AchievementBtn/TitleBg/TitleTxt")
    if locObj_WeeklyBossMainPanel_An_Tg_TitleTxt then
        locObj_WeeklyBossMainPanel_An_Tg_TitleTxt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.WeeklyBossMainPanel_An_Tg_TitleTxt
    end

    local locObj_WeeklyBossMainPanel_InfoTxt = Root:Find("AdjustRoot/RightArea/BossInfoBg/BossInfoBtn/InfoTxt")
    if locObj_WeeklyBossMainPanel_InfoTxt then
        locObj_WeeklyBossMainPanel_InfoTxt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.WeeklyBossMainPanel_InfoTxt
    end

    local locObj_WeeklyBossMainPanel_TitleTxt = Root:Find("AdjustRoot/RightArea/BuffCharacterArea/TitleBg/TitleTxt")
    if locObj_WeeklyBossMainPanel_TitleTxt then
        locObj_WeeklyBossMainPanel_TitleTxt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.WeeklyBossMainPanel_TitleTxt
    end

    local locObj_WeeklyBossMainPanel_ModeTitle = Root:Find("AdjustRoot/RightArea/ModeArea/ModeTxt/ModeTitle")
    if locObj_WeeklyBossMainPanel_ModeTitle then
        locObj_WeeklyBossMainPanel_ModeTitle.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.WeeklyBossMainPanel_ModeTitle
    end

    local locObj_WeeklyBossMainPanel_PlanningTxt = Root:Find("AdjustRoot/RightArea/PlanningBtn/PlanningTxt")
    if locObj_WeeklyBossMainPanel_PlanningTxt then
        locObj_WeeklyBossMainPanel_PlanningTxt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.WeeklyBossMainPanel_PlanningTxt
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return WeeklyBossMainPanel