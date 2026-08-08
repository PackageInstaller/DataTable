---@class As06BossPanel_Generate_userGuidePanel
---@field public gameObject UnityEngine.GameObject
---@field public userGuidePanel UserGuidePanel

---@class As06BossPanel_Generate_customBackPanel
---@field public gameObject UnityEngine.GameObject
---@field public customBackPanel CustomBackPanel

---@class As06BossPanel_Generate_quickBattleBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class As06BossPanel_Generate_challengeBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class As06BossPanel_Generate_score2
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class As06BossPanel_Generate_score1
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class As06BossPanel_Generate_bossName
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class As06BossPanel_Generate_bossDetailBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class As06BossPanel_Generate_resetTimeTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class As06BossPanel_Generate_bossImg
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class As06BossPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public bossImg As06BossPanel_Generate_bossImg
---@field public resetTimeTxt As06BossPanel_Generate_resetTimeTxt
---@field public bossDetailBtn As06BossPanel_Generate_bossDetailBtn
---@field public bossName As06BossPanel_Generate_bossName
---@field public score1 As06BossPanel_Generate_score1
---@field public score2 As06BossPanel_Generate_score2
---@field public challengeBtn As06BossPanel_Generate_challengeBtn
---@field public quickBattleBtn As06BossPanel_Generate_quickBattleBtn
---@field public customBackPanel As06BossPanel_Generate_customBackPanel
---@field public userGuidePanel As06BossPanel_Generate_userGuidePanel
local As06BossPanel = class("As06BossPanel", require("WndBase"))

function As06BossPanel:ctor(data)
end

---@private
function As06BossPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("As06BossPanel")

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

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function As06BossPanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function As06BossPanel:InitGenerate__2(Root, data)
--[[
	bg/BossImg
--]]
	local tmp = Root:Find("bg/BossImg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.bossImg = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function As06BossPanel:InitGenerate__3(Root, data)
--[[
	AdjustRoot/TopLeft/ResetTimeTxt
--]]
	local tmp = Root:Find("AdjustRoot/TopLeft/ResetTimeTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.resetTimeTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function As06BossPanel:InitGenerate__4(Root, data)
--[[
	AdjustRoot/RightMiddle/BossDetailBtn
--]]
	local tmp = Root:Find("AdjustRoot/RightMiddle/BossDetailBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.bossDetailBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("As06BossPanel_bossDetailBtn")
			if self.bossDetailBtn_ScaleButton_onClick then
				self:bossDetailBtn_ScaleButton_onClick(self.bossDetailBtn)
			end
		end)


end

---@private
function As06BossPanel:InitGenerate__5(Root, data)
--[[
	AdjustRoot/RightMiddle/BossName
--]]
	local tmp = Root:Find("AdjustRoot/RightMiddle/BossName").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.bossName = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function As06BossPanel:InitGenerate__6(Root, data)
--[[
	AdjustRoot/RightMiddle/Score1
--]]
	local tmp = Root:Find("AdjustRoot/RightMiddle/Score1").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.score1 = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function As06BossPanel:InitGenerate__7(Root, data)
--[[
	AdjustRoot/RightMiddle/Score2
--]]
	local tmp = Root:Find("AdjustRoot/RightMiddle/Score2").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.score2 = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function As06BossPanel:InitGenerate__8(Root, data)
--[[
	AdjustRoot/ChallengeBtn
--]]
	local tmp = Root:Find("AdjustRoot/ChallengeBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.challengeBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("As06BossPanel_challengeBtn")
			if self.challengeBtn_ScaleButton_onClick then
				self:challengeBtn_ScaleButton_onClick(self.challengeBtn)
			end
		end)


end

---@private
function As06BossPanel:InitGenerate__9(Root, data)
--[[
	AdjustRoot/QuickBattleBtn
--]]
	local tmp = Root:Find("AdjustRoot/QuickBattleBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.quickBattleBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("As06BossPanel_quickBattleBtn")
			if self.quickBattleBtn_ScaleButton_onClick then
				self:quickBattleBtn_ScaleButton_onClick(self.quickBattleBtn)
			end
		end)


end

---@private
function As06BossPanel:InitGenerate__10(Root, data)
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
function As06BossPanel:InitGenerate__11(Root, data)
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

function As06BossPanel:SetLocalizedText(Root)

    local locObj_As06BossPanel_Text1 = Root:Find("AdjustRoot/TopLeft/Text1")
    if locObj_As06BossPanel_Text1 then
        locObj_As06BossPanel_Text1.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.As06BossPanel_Text1
    end

    local locObj_As06BossPanel_Text2 = Root:Find("AdjustRoot/TopLeft/Text2")
    if locObj_As06BossPanel_Text2 then
        locObj_As06BossPanel_Text2.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.As06BossPanel_Text2
    end

    local locObj_As06BossPanel_Text = Root:Find("AdjustRoot/RightMiddle/BossDetailBtn/Text")
    if locObj_As06BossPanel_Text then
        locObj_As06BossPanel_Text.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.As06BossPanel_Text
    end

    local locObj_As06BossPanel_Re_Text1 = Root:Find("AdjustRoot/RightMiddle/Text1")
    if locObj_As06BossPanel_Re_Text1 then
        locObj_As06BossPanel_Re_Text1.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.As06BossPanel_Re_Text1
    end

    local locObj_As06BossPanel_Re_Text2 = Root:Find("AdjustRoot/RightMiddle/Text2")
    if locObj_As06BossPanel_Re_Text2 then
        locObj_As06BossPanel_Re_Text2.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.As06BossPanel_Re_Text2
    end

    local locObj_As06BossPanel_Text3 = Root:Find("AdjustRoot/RightMiddle/Text3")
    if locObj_As06BossPanel_Text3 then
        locObj_As06BossPanel_Text3.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.As06BossPanel_Text3
    end

    local locObj_As06BossPanel_Text4 = Root:Find("AdjustRoot/RightMiddle/Text4")
    if locObj_As06BossPanel_Text4 then
        locObj_As06BossPanel_Text4.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.As06BossPanel_Text4
    end

    local locObj_As06BossPanel_Text5 = Root:Find("AdjustRoot/RightMiddle/Text5")
    if locObj_As06BossPanel_Text5 then
        locObj_As06BossPanel_Text5.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.As06BossPanel_Text5
    end

    local locObj_As06BossPanel_Qn_Text2 = Root:Find("AdjustRoot/QuickBattleBtn/Text2")
    if locObj_As06BossPanel_Qn_Text2 then
        locObj_As06BossPanel_Qn_Text2.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.As06BossPanel_Qn_Text2
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return As06BossPanel