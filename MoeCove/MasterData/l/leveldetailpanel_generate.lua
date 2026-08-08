---@class LevelDetailPanel_Generate_achBox_achievementDesc
---@field public gameObject UnityEngine.GameObject
---@field public text UnityEngine.UI.Text

---@class LevelDetailPanel_Generate_achBox
---@field public gameObject UnityEngine.GameObject
---@field public isComplete UnityEngine.GameObject
---@field public achievementDesc LevelDetailPanel_Generate_achBox_achievementDesc

---@class LevelDetailPanel_Generate_achievementToggle
---@field public gameObject UnityEngine.GameObject
---@field public toggle UnityEngine.UI.Toggle

---@class LevelDetailPanel_Generate_enemyToggle
---@field public gameObject UnityEngine.GameObject
---@field public toggle UnityEngine.UI.Toggle

---@class LevelDetailPanel_Generate_closeBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class LevelDetailPanel_Generate_closeBgBtn
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class LevelDetailPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public closeBgBtn LevelDetailPanel_Generate_closeBgBtn
---@field public closeBtn LevelDetailPanel_Generate_closeBtn
---@field public enemyToggle LevelDetailPanel_Generate_enemyToggle
---@field public achievementToggle LevelDetailPanel_Generate_achievementToggle
---@field public enemyData UnityEngine.GameObject
---@field public headIcon UnityEngine.GameObject
---@field public nameText UnityEngine.GameObject
---@field public typeText UnityEngine.GameObject
---@field public actionText UnityEngine.GameObject
---@field public skillList UnityEngine.GameObject
---@field public skillBox UnityEngine.GameObject
---@field public achievementData UnityEngine.GameObject
---@field public achievementList UnityEngine.GameObject
---@field public achBox LevelDetailPanel_Generate_achBox
local LevelDetailPanel = class("LevelDetailPanel", require("WndBase"))

function LevelDetailPanel:ctor(data)
end

---@private
function LevelDetailPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("LevelDetailPanel")

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
function LevelDetailPanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function LevelDetailPanel:InitGenerate__2(Root, data)
--[[
	CloseBgBtn
--]]
	local tmp = Root:Find("CloseBgBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.closeBgBtn = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("LevelDetailPanel_closeBgBtn")
			if self.closeBgBtn_Button_onClick then
				self:closeBgBtn_Button_onClick(self.closeBgBtn)
			end
		end)


end

---@private
function LevelDetailPanel:InitGenerate__3(Root, data)
--[[
	DetailBg/CloseBtn
--]]
	local tmp = Root:Find("DetailBg/CloseBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.closeBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("LevelDetailPanel_closeBtn")
			if self.closeBtn_ScaleButton_onClick then
				self:closeBtn_ScaleButton_onClick(self.closeBtn)
			end
		end)


end

---@private
function LevelDetailPanel:InitGenerate__4(Root, data)
--[[
	DetailBg/EnemyToggle
--]]
	local tmp = Root:Find("DetailBg/EnemyToggle").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.enemyToggle = tmp

	tmp.toggle = tmp:GetComponent(TypeInfo.Toggle)
	tmp.toggle.onValueChanged:RemoveAllListeners()
	tmp.toggle.onValueChanged:AddListener(function (isOn)
			if self.enemyToggle_Toggle_onValueChanged then
				self:enemyToggle_Toggle_onValueChanged(self.enemyToggle,isOn)
			end
		end)


end

---@private
function LevelDetailPanel:InitGenerate__5(Root, data)
--[[
	DetailBg/AchievementToggle
--]]
	local tmp = Root:Find("DetailBg/AchievementToggle").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.achievementToggle = tmp

	tmp.toggle = tmp:GetComponent(TypeInfo.Toggle)
	tmp.toggle.onValueChanged:RemoveAllListeners()
	tmp.toggle.onValueChanged:AddListener(function (isOn)
			if self.achievementToggle_Toggle_onValueChanged then
				self:achievementToggle_Toggle_onValueChanged(self.achievementToggle,isOn)
			end
		end)


end

---@private
function LevelDetailPanel:InitGenerate__6(Root, data)
--[[
	DetailBg/EnemyData
--]]
	local tmp = Root:Find("DetailBg/EnemyData").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.enemyData = tmp


end

---@private
function LevelDetailPanel:InitGenerate__7(Root, data)
--[[
	DetailBg/EnemyData/HeadIcon
--]]
	local tmp = Root:Find("DetailBg/EnemyData/HeadIcon").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.headIcon = tmp


end

---@private
function LevelDetailPanel:InitGenerate__8(Root, data)
--[[
	DetailBg/EnemyData/NameText
--]]
	local tmp = Root:Find("DetailBg/EnemyData/NameText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.nameText = tmp


end

---@private
function LevelDetailPanel:InitGenerate__9(Root, data)
--[[
	DetailBg/EnemyData/TypeText
--]]
	local tmp = Root:Find("DetailBg/EnemyData/TypeText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.typeText = tmp


end

---@private
function LevelDetailPanel:InitGenerate__10(Root, data)
--[[
	DetailBg/EnemyData/ActionText
--]]
	local tmp = Root:Find("DetailBg/EnemyData/ActionText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.actionText = tmp


end

---@private
function LevelDetailPanel:InitGenerate__11(Root, data)
--[[
	DetailBg/EnemyData/SkillList
--]]
	local tmp = Root:Find("DetailBg/EnemyData/SkillList").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.skillList = tmp


end

---@private
function LevelDetailPanel:InitGenerate__12(Root, data)
--[[
	DetailBg/EnemyData/SkillList/SkillBox
--]]
	local tmp = Root:Find("DetailBg/EnemyData/SkillList/SkillBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.skillBox = tmp


end

---@private
function LevelDetailPanel:InitGenerate__13(Root, data)
--[[
	DetailBg/AchievementData
--]]
	local tmp = Root:Find("DetailBg/AchievementData").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.achievementData = tmp


end

---@private
function LevelDetailPanel:InitGenerate__14(Root, data)
--[[
	DetailBg/AchievementData/AchievementList
--]]
	local tmp = Root:Find("DetailBg/AchievementData/AchievementList").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.achievementList = tmp


end

---@private
function LevelDetailPanel:InitGenerate__15(Root, data)
--[[
	DetailBg/AchievementData/AchievementList/AchBox
--]]
	local tmp = Root:Find("DetailBg/AchievementData/AchievementList/AchBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.achBox = tmp


end

---@private
function LevelDetailPanel:InitGenerate__16(Root, data)
--[[
	DetailBg/AchievementData/AchievementList/AchBox/IsComplete
--]]
	local tmp = Root:Find("DetailBg/AchievementData/AchievementList/AchBox/IsComplete").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.achBox.isComplete = tmp


end

---@private
function LevelDetailPanel:InitGenerate__17(Root, data)
--[[
	DetailBg/AchievementData/AchievementList/AchBox/AchievementDesc
--]]
	local tmp = Root:Find("DetailBg/AchievementData/AchievementList/AchBox/AchievementDesc").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.achBox.achievementDesc = tmp

	tmp.text = tmp:GetComponent(TypeInfo.Text)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function LevelDetailPanel:SetLocalizedText(Root)

    local locObj_LevelDetailPanel_EnemyToggleText = Root:Find("DetailBg/EnemyToggle/EnemyToggleText")
    if locObj_LevelDetailPanel_EnemyToggleText then
        locObj_LevelDetailPanel_EnemyToggleText.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.LevelDetailPanel_EnemyToggleText
    end

    local locObj_LevelDetailPanel_AchievementToggleText = Root:Find("DetailBg/AchievementToggle/AchievementToggleText")
    if locObj_LevelDetailPanel_AchievementToggleText then
        locObj_LevelDetailPanel_AchievementToggleText.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.LevelDetailPanel_AchievementToggleText
    end

    local locObj_LevelDetailPanel_TitleText = Root:Find("DetailBg/EnemyData/DescTitle/TitleText")
    if locObj_LevelDetailPanel_TitleText then
        locObj_LevelDetailPanel_TitleText.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.LevelDetailPanel_TitleText
    end

    local locObj_LevelDetailPanel_Se_TitleText = Root:Find("DetailBg/EnemyData/SkillTitle/TitleText")
    if locObj_LevelDetailPanel_Se_TitleText then
        locObj_LevelDetailPanel_Se_TitleText.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.LevelDetailPanel_Se_TitleText
    end

    local locObj_LevelDetailPanel_Ne_TitleText = Root:Find("DetailBg/EnemyData/NormalEnemyTitle/TitleText")
    if locObj_LevelDetailPanel_Ne_TitleText then
        locObj_LevelDetailPanel_Ne_TitleText.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.LevelDetailPanel_Ne_TitleText
    end

    local locObj_LevelDetailPanel_Be_TitleText = Root:Find("DetailBg/EnemyData/BossEnemyTitle/TitleText")
    if locObj_LevelDetailPanel_Be_TitleText then
        locObj_LevelDetailPanel_Be_TitleText.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.LevelDetailPanel_Be_TitleText
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return LevelDetailPanel