---@class SimulatedInfoPanel_Generate_confirmBtn_txt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class SimulatedInfoPanel_Generate_confirmBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton
---@field public txt SimulatedInfoPanel_Generate_confirmBtn_txt

---@class SimulatedInfoPanel_Generate_strengthIcon
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class SimulatedInfoPanel_Generate_goStrengthText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class SimulatedInfoPanel_Generate_customBox
---@field public gameObject UnityEngine.GameObject
---@field public customBox CustomBox

---@class SimulatedInfoPanel_Generate_failureTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class SimulatedInfoPanel_Generate_victoryTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class SimulatedInfoPanel_Generate_buffTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class SimulatedInfoPanel_Generate_enemyInfoTitleTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class SimulatedInfoPanel_Generate_enemyInfoTitleBg
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class SimulatedInfoPanel_Generate_recommendLevelText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class SimulatedInfoPanel_Generate_recommendTitle
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class SimulatedInfoPanel_Generate_levelDescTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class SimulatedInfoPanel_Generate_levelNameTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class SimulatedInfoPanel_Generate_mask
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class SimulatedInfoPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public mask SimulatedInfoPanel_Generate_mask
---@field public levelNameTxt SimulatedInfoPanel_Generate_levelNameTxt
---@field public levelDescTxt SimulatedInfoPanel_Generate_levelDescTxt
---@field public recommendTitle SimulatedInfoPanel_Generate_recommendTitle
---@field public recommendLevelText SimulatedInfoPanel_Generate_recommendLevelText
---@field public enemyInfoTitleBg SimulatedInfoPanel_Generate_enemyInfoTitleBg
---@field public enemyInfoTitleTxt SimulatedInfoPanel_Generate_enemyInfoTitleTxt
---@field public buffTxt SimulatedInfoPanel_Generate_buffTxt
---@field public victoryTxt SimulatedInfoPanel_Generate_victoryTxt
---@field public failureTxt SimulatedInfoPanel_Generate_failureTxt
---@field public rewardBoxList UnityEngine.GameObject
---@field public customBox SimulatedInfoPanel_Generate_customBox
---@field public noReward UnityEngine.GameObject
---@field public goStrengthText SimulatedInfoPanel_Generate_goStrengthText
---@field public strengthIcon SimulatedInfoPanel_Generate_strengthIcon
---@field public confirmBtn SimulatedInfoPanel_Generate_confirmBtn
local SimulatedInfoPanel = class("SimulatedInfoPanel", require("WndBase"))

function SimulatedInfoPanel:ctor(data)
end

---@private
function SimulatedInfoPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("SimulatedInfoPanel")

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

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function SimulatedInfoPanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function SimulatedInfoPanel:InitGenerate__2(Root, data)
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
		UIMgr:SendUiUseMessage("SimulatedInfoPanel_mask")
			if self.mask_Button_onClick then
				self:mask_Button_onClick(self.mask)
			end
		end)


end

---@private
function SimulatedInfoPanel:InitGenerate__3(Root, data)
--[[
	BoxBg/LevelInfoBg/LevelNameTxt
--]]
	local tmp = Root:Find("BoxBg/LevelInfoBg/LevelNameTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.levelNameTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function SimulatedInfoPanel:InitGenerate__4(Root, data)
--[[
	BoxBg/LevelInfoBg/LevelDescTxt
--]]
	local tmp = Root:Find("BoxBg/LevelInfoBg/LevelDescTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.levelDescTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function SimulatedInfoPanel:InitGenerate__5(Root, data)
--[[
	BoxBg/LevelInfoBg/RecommendLevelBg/RecommendTitle
--]]
	local tmp = Root:Find("BoxBg/LevelInfoBg/RecommendLevelBg/RecommendTitle").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.recommendTitle = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function SimulatedInfoPanel:InitGenerate__6(Root, data)
--[[
	BoxBg/LevelInfoBg/RecommendLevelBg/RecommendTitle/RecommendLevelText
--]]
	local tmp = Root:Find("BoxBg/LevelInfoBg/RecommendLevelBg/RecommendTitle/RecommendLevelText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.recommendLevelText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function SimulatedInfoPanel:InitGenerate__7(Root, data)
--[[
	BoxBg/LevelInfoBg/EnemyInfoTitleBg
--]]
	local tmp = Root:Find("BoxBg/LevelInfoBg/EnemyInfoTitleBg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.enemyInfoTitleBg = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function SimulatedInfoPanel:InitGenerate__8(Root, data)
--[[
	BoxBg/LevelInfoBg/EnemyInfoTitleBg/EnemyInfoTitleTxt
--]]
	local tmp = Root:Find("BoxBg/LevelInfoBg/EnemyInfoTitleBg/EnemyInfoTitleTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.enemyInfoTitleTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function SimulatedInfoPanel:InitGenerate__9(Root, data)
--[[
	BoxBg/LevelInfoBg/BuffTxt
--]]
	local tmp = Root:Find("BoxBg/LevelInfoBg/BuffTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.buffTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function SimulatedInfoPanel:InitGenerate__10(Root, data)
--[[
	BoxBg/VictoryConditionsBg/VictoryTxt
--]]
	local tmp = Root:Find("BoxBg/VictoryConditionsBg/VictoryTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.victoryTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function SimulatedInfoPanel:InitGenerate__11(Root, data)
--[[
	BoxBg/FailureConditionsBg/FailureTxt
--]]
	local tmp = Root:Find("BoxBg/FailureConditionsBg/FailureTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.failureTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function SimulatedInfoPanel:InitGenerate__12(Root, data)
--[[
	BoxBg/RewardBoxList
--]]
	local tmp = Root:Find("BoxBg/RewardBoxList").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rewardBoxList = tmp


end

---@private
function SimulatedInfoPanel:InitGenerate__13(Root, data)
--[[
	BoxBg/RewardBoxList/CustomBox
--]]
	local tmp = Root:Find("BoxBg/RewardBoxList/CustomBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.customBox = tmp

	tmp.customBox = tmp:AddComponentLua("CustomBox", data)


end

---@private
function SimulatedInfoPanel:InitGenerate__14(Root, data)
--[[
	BoxBg/NoReward
--]]
	local tmp = Root:Find("BoxBg/NoReward").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.noReward = tmp


end

---@private
function SimulatedInfoPanel:InitGenerate__15(Root, data)
--[[
	BoxBg/NeedStrengthBg/GoStrengthText
--]]
	local tmp = Root:Find("BoxBg/NeedStrengthBg/GoStrengthText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.goStrengthText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function SimulatedInfoPanel:InitGenerate__16(Root, data)
--[[
	BoxBg/NeedStrengthBg/StrengthIcon
--]]
	local tmp = Root:Find("BoxBg/NeedStrengthBg/StrengthIcon").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.strengthIcon = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function SimulatedInfoPanel:InitGenerate__17(Root, data)
--[[
	BoxBg/ConfirmBtn
--]]
	local tmp = Root:Find("BoxBg/ConfirmBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.confirmBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("SimulatedInfoPanel_confirmBtn")
			if self.confirmBtn_ScaleButton_onClick then
				self:confirmBtn_ScaleButton_onClick(self.confirmBtn)
			end
		end)


end

---@private
function SimulatedInfoPanel:InitGenerate__18(Root, data)
--[[
	BoxBg/ConfirmBtn/txt
--]]
	local tmp = Root:Find("BoxBg/ConfirmBtn/txt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.confirmBtn.txt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function SimulatedInfoPanel:SetLocalizedText(Root)

    local locObj_SimulatedInfoPanel_LevelNameEng = Root:Find("BoxBg/LevelInfoBg/LevelNameTxt/LevelNameEng")
    if locObj_SimulatedInfoPanel_LevelNameEng then
        locObj_SimulatedInfoPanel_LevelNameEng.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.SimulatedInfoPanel_LevelNameEng
    end

    local locObj_SimulatedInfoPanel_VictoryTitle = Root:Find("BoxBg/VictoryConditionsBg/VictoryTitle")
    if locObj_SimulatedInfoPanel_VictoryTitle then
        locObj_SimulatedInfoPanel_VictoryTitle.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.SimulatedInfoPanel_VictoryTitle
    end

    local locObj_SimulatedInfoPanel_FailureTitle = Root:Find("BoxBg/FailureConditionsBg/FailureTitle")
    if locObj_SimulatedInfoPanel_FailureTitle then
        locObj_SimulatedInfoPanel_FailureTitle.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.SimulatedInfoPanel_FailureTitle
    end

    local locObj_SimulatedInfoPanel_TitleTxt = Root:Find("BoxBg/AwardTitleTxtBg/TitleTxt")
    if locObj_SimulatedInfoPanel_TitleTxt then
        locObj_SimulatedInfoPanel_TitleTxt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.SimulatedInfoPanel_TitleTxt
    end

    local locObj_SimulatedInfoPanel_TitleEngTxt = Root:Find("BoxBg/AwardTitleTxtBg/TitleEngTxt")
    if locObj_SimulatedInfoPanel_TitleEngTxt then
        locObj_SimulatedInfoPanel_TitleEngTxt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.SimulatedInfoPanel_TitleEngTxt
    end

    local locObj_SimulatedInfoPanel_NoRewardTxt = Root:Find("BoxBg/NoReward/NoRewardTxt")
    if locObj_SimulatedInfoPanel_NoRewardTxt then
        locObj_SimulatedInfoPanel_NoRewardTxt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.SimulatedInfoPanel_NoRewardTxt
    end

    local locObj_SimulatedInfoPanel_GoStrengthGesc = Root:Find("BoxBg/NeedStrengthBg/GoStrengthGesc")
    if locObj_SimulatedInfoPanel_GoStrengthGesc then
        locObj_SimulatedInfoPanel_GoStrengthGesc.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.SimulatedInfoPanel_GoStrengthGesc
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return SimulatedInfoPanel