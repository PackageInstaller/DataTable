---@class SimulatedLevelPanel_Generate_userGuidePanel
---@field public gameObject UnityEngine.GameObject
---@field public userGuidePanel UserGuidePanel

---@class SimulatedLevelPanel_Generate_customMsgPanel
---@field public gameObject UnityEngine.GameObject
---@field public customMsgPanel CustomMsgPanel

---@class SimulatedLevelPanel_Generate_customBackPanel
---@field public gameObject UnityEngine.GameObject
---@field public customBackPanel CustomBackPanel

---@class SimulatedLevelPanel_Generate_levelBox_addNumTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class SimulatedLevelPanel_Generate_levelBox_levelNum
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class SimulatedLevelPanel_Generate_levelBox_levelDiffEng
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class SimulatedLevelPanel_Generate_levelBox_roleIcon
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class SimulatedLevelPanel_Generate_levelBox_boxBg
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public image UnityEngine.UI.Image

---@class SimulatedLevelPanel_Generate_levelBox
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton
---@field public canvasGroup UnityEngine.CanvasGroup
---@field public boxBg SimulatedLevelPanel_Generate_levelBox_boxBg
---@field public roleIcon SimulatedLevelPanel_Generate_levelBox_roleIcon
---@field public levelDiffEng SimulatedLevelPanel_Generate_levelBox_levelDiffEng
---@field public levelNum SimulatedLevelPanel_Generate_levelBox_levelNum
---@field public addNumTxt SimulatedLevelPanel_Generate_levelBox_addNumTxt
---@field public isClear UnityEngine.GameObject

---@class SimulatedLevelPanel_Generate_tipsTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class SimulatedLevelPanel_Generate_tipsBg
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform

---@class SimulatedLevelPanel_Generate_finishBtnEng
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class SimulatedLevelPanel_Generate_finishBtnTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class SimulatedLevelPanel_Generate_finishBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class SimulatedLevelPanel_Generate_goBtnEng
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class SimulatedLevelPanel_Generate_goBtnTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class SimulatedLevelPanel_Generate_goBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class SimulatedLevelPanel_Generate_quickTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class SimulatedLevelPanel_Generate_historyTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class SimulatedLevelPanel_Generate_customBox
---@field public gameObject UnityEngine.GameObject
---@field public customBox CustomBox

---@class SimulatedLevelPanel_Generate_progressBox
---@field public gameObject UnityEngine.GameObject
---@field public isActive UnityEngine.GameObject

---@class SimulatedLevelPanel_Generate_previewRewardBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class SimulatedLevelPanel_Generate_resetTimeTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class SimulatedLevelPanel_Generate_resetTitleTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class SimulatedLevelPanel_Generate_floorCountTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class SimulatedLevelPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public floorCountTxt SimulatedLevelPanel_Generate_floorCountTxt
---@field public resetTitleTxt SimulatedLevelPanel_Generate_resetTitleTxt
---@field public resetTimeTxt SimulatedLevelPanel_Generate_resetTimeTxt
---@field public previewRewardBtn SimulatedLevelPanel_Generate_previewRewardBtn
---@field public levelBoxList UnityEngine.GameObject
---@field public progressList UnityEngine.GameObject
---@field public progressBox SimulatedLevelPanel_Generate_progressBox
---@field public rewardList UnityEngine.GameObject
---@field public customBox SimulatedLevelPanel_Generate_customBox
---@field public historyTxt SimulatedLevelPanel_Generate_historyTxt
---@field public quickTxt SimulatedLevelPanel_Generate_quickTxt
---@field public goBtn SimulatedLevelPanel_Generate_goBtn
---@field public goBtnTxt SimulatedLevelPanel_Generate_goBtnTxt
---@field public goBtnEng SimulatedLevelPanel_Generate_goBtnEng
---@field public finishBtn SimulatedLevelPanel_Generate_finishBtn
---@field public finishBtnTxt SimulatedLevelPanel_Generate_finishBtnTxt
---@field public finishBtnEng SimulatedLevelPanel_Generate_finishBtnEng
---@field public tipsBg SimulatedLevelPanel_Generate_tipsBg
---@field public tipsTxt SimulatedLevelPanel_Generate_tipsTxt
---@field public levelBox SimulatedLevelPanel_Generate_levelBox
---@field public customBackPanel SimulatedLevelPanel_Generate_customBackPanel
---@field public customMsgPanel SimulatedLevelPanel_Generate_customMsgPanel
---@field public userGuidePanel SimulatedLevelPanel_Generate_userGuidePanel
local SimulatedLevelPanel = class("SimulatedLevelPanel", require("WndBase"))

function SimulatedLevelPanel:ctor(data)
end

---@private
function SimulatedLevelPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("SimulatedLevelPanel")

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

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function SimulatedLevelPanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function SimulatedLevelPanel:InitGenerate__2(Root, data)
--[[
	TitleArea/FloorCountBg/FloorCountTxt
--]]
	local tmp = Root:Find("TitleArea/FloorCountBg/FloorCountTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.floorCountTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function SimulatedLevelPanel:InitGenerate__3(Root, data)
--[[
	TitleArea/ResetTimeBg/ResetTitleTxt
--]]
	local tmp = Root:Find("TitleArea/ResetTimeBg/ResetTitleTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.resetTitleTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function SimulatedLevelPanel:InitGenerate__4(Root, data)
--[[
	TitleArea/ResetTimeBg/ResetTimeTxt
--]]
	local tmp = Root:Find("TitleArea/ResetTimeBg/ResetTimeTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.resetTimeTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function SimulatedLevelPanel:InitGenerate__5(Root, data)
--[[
	PreviewRewardBtn
--]]
	local tmp = Root:Find("PreviewRewardBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.previewRewardBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("SimulatedLevelPanel_previewRewardBtn")
			if self.previewRewardBtn_ScaleButton_onClick then
				self:previewRewardBtn_ScaleButton_onClick(self.previewRewardBtn)
			end
		end)


end

---@private
function SimulatedLevelPanel:InitGenerate__6(Root, data)
--[[
	LevelBoxList
--]]
	local tmp = Root:Find("LevelBoxList").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.levelBoxList = tmp


end

---@private
function SimulatedLevelPanel:InitGenerate__7(Root, data)
--[[
	LevelInfoBg/ProgressList
--]]
	local tmp = Root:Find("LevelInfoBg/ProgressList").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.progressList = tmp


end

---@private
function SimulatedLevelPanel:InitGenerate__8(Root, data)
--[[
	LevelInfoBg/ProgressList/ProgressBox
--]]
	local tmp = Root:Find("LevelInfoBg/ProgressList/ProgressBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.progressBox = tmp


end

---@private
function SimulatedLevelPanel:InitGenerate__9(Root, data)
--[[
	LevelInfoBg/ProgressList/ProgressBox/IsActive
--]]
	local tmp = Root:Find("LevelInfoBg/ProgressList/ProgressBox/IsActive").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.progressBox.isActive = tmp


end

---@private
function SimulatedLevelPanel:InitGenerate__10(Root, data)
--[[
	LevelInfoBg/LevelReward/Scroll View/Viewport/RewardList
--]]
	local tmp = Root:Find("LevelInfoBg/LevelReward/Scroll View/Viewport/RewardList").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rewardList = tmp


end

---@private
function SimulatedLevelPanel:InitGenerate__11(Root, data)
--[[
	LevelInfoBg/LevelReward/Scroll View/Viewport/RewardList/CustomBox
--]]
	local tmp = Root:Find("LevelInfoBg/LevelReward/Scroll View/Viewport/RewardList/CustomBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.customBox = tmp

	tmp.customBox = tmp:AddComponentLua("CustomBox", data)


end

---@private
function SimulatedLevelPanel:InitGenerate__12(Root, data)
--[[
	LevelBtnInfo/HistoryInfoBg/HistoryTxt
--]]
	local tmp = Root:Find("LevelBtnInfo/HistoryInfoBg/HistoryTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.historyTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function SimulatedLevelPanel:InitGenerate__13(Root, data)
--[[
	LevelBtnInfo/HistoryInfoBg/QuickTxt
--]]
	local tmp = Root:Find("LevelBtnInfo/HistoryInfoBg/QuickTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.quickTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function SimulatedLevelPanel:InitGenerate__14(Root, data)
--[[
	LevelBtnInfo/GoBtn
--]]
	local tmp = Root:Find("LevelBtnInfo/GoBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.goBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("SimulatedLevelPanel_goBtn")
			if self.goBtn_ScaleButton_onClick then
				self:goBtn_ScaleButton_onClick(self.goBtn)
			end
		end)


end

---@private
function SimulatedLevelPanel:InitGenerate__15(Root, data)
--[[
	LevelBtnInfo/GoBtn/GoBtnTxt
--]]
	local tmp = Root:Find("LevelBtnInfo/GoBtn/GoBtnTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.goBtnTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function SimulatedLevelPanel:InitGenerate__16(Root, data)
--[[
	LevelBtnInfo/GoBtn/GoBtnEng
--]]
	local tmp = Root:Find("LevelBtnInfo/GoBtn/GoBtnEng").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.goBtnEng = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function SimulatedLevelPanel:InitGenerate__17(Root, data)
--[[
	LevelBtnInfo/FinishBtn
--]]
	local tmp = Root:Find("LevelBtnInfo/FinishBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.finishBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("SimulatedLevelPanel_finishBtn")
			if self.finishBtn_ScaleButton_onClick then
				self:finishBtn_ScaleButton_onClick(self.finishBtn)
			end
		end)


end

---@private
function SimulatedLevelPanel:InitGenerate__18(Root, data)
--[[
	LevelBtnInfo/FinishBtn/FinishBtnTxt
--]]
	local tmp = Root:Find("LevelBtnInfo/FinishBtn/FinishBtnTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.finishBtnTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function SimulatedLevelPanel:InitGenerate__19(Root, data)
--[[
	LevelBtnInfo/FinishBtn/FinishBtnEng
--]]
	local tmp = Root:Find("LevelBtnInfo/FinishBtn/FinishBtnEng").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.finishBtnEng = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function SimulatedLevelPanel:InitGenerate__20(Root, data)
--[[
	LevelBtnInfo/TipsBg
--]]
	local tmp = Root:Find("LevelBtnInfo/TipsBg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.tipsBg = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)


end

---@private
function SimulatedLevelPanel:InitGenerate__21(Root, data)
--[[
	LevelBtnInfo/TipsBg/TipsTxt
--]]
	local tmp = Root:Find("LevelBtnInfo/TipsBg/TipsTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.tipsTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function SimulatedLevelPanel:InitGenerate__22(Root, data)
--[[
	LevelBox
--]]
	local tmp = Root:Find("LevelBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.levelBox = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function SimulatedLevelPanel:InitGenerate__23(Root, data)
--[[
	LevelBox/BoxBg
--]]
	local tmp = Root:Find("LevelBox/BoxBg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.levelBox.boxBg = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function SimulatedLevelPanel:InitGenerate__24(Root, data)
--[[
	LevelBox/BoxBg/RoleMask/RoleIcon
--]]
	local tmp = Root:Find("LevelBox/BoxBg/RoleMask/RoleIcon").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.levelBox.roleIcon = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function SimulatedLevelPanel:InitGenerate__25(Root, data)
--[[
	LevelBox/BoxBg/BottomCover/LevelDiffEng
--]]
	local tmp = Root:Find("LevelBox/BoxBg/BottomCover/LevelDiffEng").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.levelBox.levelDiffEng = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function SimulatedLevelPanel:InitGenerate__26(Root, data)
--[[
	LevelBox/BoxBg/BottomCover/LevelNum
--]]
	local tmp = Root:Find("LevelBox/BoxBg/BottomCover/LevelNum").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.levelBox.levelNum = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function SimulatedLevelPanel:InitGenerate__27(Root, data)
--[[
	LevelBox/BoxBg/BottomCover/BottomTxtBg/AddNumTxt
--]]
	local tmp = Root:Find("LevelBox/BoxBg/BottomCover/BottomTxtBg/AddNumTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.levelBox.addNumTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function SimulatedLevelPanel:InitGenerate__28(Root, data)
--[[
	LevelBox/BoxBg/IsClear
--]]
	local tmp = Root:Find("LevelBox/BoxBg/IsClear").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.levelBox.isClear = tmp


end

---@private
function SimulatedLevelPanel:InitGenerate__29(Root, data)
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
function SimulatedLevelPanel:InitGenerate__30(Root, data)
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

---@private
function SimulatedLevelPanel:InitGenerate__31(Root, data)
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

function SimulatedLevelPanel:SetLocalizedText(Root)

    local locObj_SimulatedLevelPanel_PreviewRewardTxt = Root:Find("PreviewRewardBtn/PreviewRewardTxt")
    if locObj_SimulatedLevelPanel_PreviewRewardTxt then
        locObj_SimulatedLevelPanel_PreviewRewardTxt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.SimulatedLevelPanel_PreviewRewardTxt
    end

    local locObj_SimulatedLevelPanel_FloorRewardTitle = Root:Find("LevelInfoBg/FloorRewardTitle")
    if locObj_SimulatedLevelPanel_FloorRewardTitle then
        locObj_SimulatedLevelPanel_FloorRewardTitle.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.SimulatedLevelPanel_FloorRewardTitle
    end

    local locObj_SimulatedLevelPanel_FloorProgressTitle = Root:Find("LevelInfoBg/FloorProgressTitle")
    if locObj_SimulatedLevelPanel_FloorProgressTitle then
        locObj_SimulatedLevelPanel_FloorProgressTitle.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.SimulatedLevelPanel_FloorProgressTitle
    end

    local locObj_SimulatedLevelPanel_HistoryTitleTxt = Root:Find("LevelBtnInfo/HistoryInfoBg/HistoryTitleTxt")
    if locObj_SimulatedLevelPanel_HistoryTitleTxt then
        locObj_SimulatedLevelPanel_HistoryTitleTxt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.SimulatedLevelPanel_HistoryTitleTxt
    end

    local locObj_SimulatedLevelPanel_QuickTitleTxt = Root:Find("LevelBtnInfo/HistoryInfoBg/QuickTitleTxt")
    if locObj_SimulatedLevelPanel_QuickTitleTxt then
        locObj_SimulatedLevelPanel_QuickTitleTxt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.SimulatedLevelPanel_QuickTitleTxt
    end

    local locObj_SimulatedLevelPanel_ClearTxt = Root:Find("LevelBox/BoxBg/BottomCover/BottomTxtBg/ClearTxt")
    if locObj_SimulatedLevelPanel_ClearTxt then
        locObj_SimulatedLevelPanel_ClearTxt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.SimulatedLevelPanel_ClearTxt
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return SimulatedLevelPanel