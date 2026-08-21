---@class WeeklyBossPlanPanel_Generate_weeklyBossTagBox
---@field public gameObject UnityEngine.GameObject
---@field public weeklyBossTagBox WeeklyBossTagBox

---@class WeeklyBossPlanPanel_Generate_nowPtcTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class WeeklyBossPlanPanel_Generate_closeBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class WeeklyBossPlanPanel_Generate_mask
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class WeeklyBossPlanPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public mask WeeklyBossPlanPanel_Generate_mask
---@field public closeBtn WeeklyBossPlanPanel_Generate_closeBtn
---@field public nowPtcTxt WeeklyBossPlanPanel_Generate_nowPtcTxt
---@field public tagBoxList UnityEngine.GameObject
---@field public weeklyBossTagBox WeeklyBossPlanPanel_Generate_weeklyBossTagBox
local WeeklyBossPlanPanel = class("WeeklyBossPlanPanel", require("WndBase"))

function WeeklyBossPlanPanel:ctor(data)
end

---@private
function WeeklyBossPlanPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("WeeklyBossPlanPanel")

	local Root = self.transform 
	local tmp

	self:InitGenerate__1(Root,data)
	self:InitGenerate__2(Root,data)
	self:InitGenerate__3(Root,data)
	self:InitGenerate__4(Root,data)
	self:InitGenerate__5(Root,data)
	self:InitGenerate__6(Root,data)

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function WeeklyBossPlanPanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function WeeklyBossPlanPanel:InitGenerate__2(Root, data)
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
		UIMgr:SendUiUseMessage("WeeklyBossPlanPanel_mask")
			if self.mask_Button_onClick then
				self:mask_Button_onClick(self.mask)
			end
		end)


end

---@private
function WeeklyBossPlanPanel:InitGenerate__3(Root, data)
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
		UIMgr:SendUiUseMessage("WeeklyBossPlanPanel_closeBtn")
			if self.closeBtn_ScaleButton_onClick then
				self:closeBtn_ScaleButton_onClick(self.closeBtn)
			end
		end)


end

---@private
function WeeklyBossPlanPanel:InitGenerate__4(Root, data)
--[[
	BoxBg/NowPtcTxt
--]]
	local tmp = Root:Find("BoxBg/NowPtcTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.nowPtcTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function WeeklyBossPlanPanel:InitGenerate__5(Root, data)
--[[
	BoxBg/ScrollView/Viewport/TagBoxList
--]]
	local tmp = Root:Find("BoxBg/ScrollView/Viewport/TagBoxList").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.tagBoxList = tmp


end

---@private
function WeeklyBossPlanPanel:InitGenerate__6(Root, data)
--[[
	BoxBg/ScrollView/Viewport/TagBoxList/WeeklyBossTagBox
--]]
	local tmp = Root:Find("BoxBg/ScrollView/Viewport/TagBoxList/WeeklyBossTagBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.weeklyBossTagBox = tmp

	tmp.weeklyBossTagBox = tmp:AddComponentLua("WeeklyBossTagBox", data)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function WeeklyBossPlanPanel:SetLocalizedText(Root)

    local locObj_WeeklyBossPlanPanel_TitleTxt = Root:Find("BoxBg/TitleBg/TitleTxt")
    if locObj_WeeklyBossPlanPanel_TitleTxt then
        locObj_WeeklyBossPlanPanel_TitleTxt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.WeeklyBossPlanPanel_TitleTxt
    end

    local locObj_WeeklyBossPlanPanel_PtcTitleTxt = Root:Find("BoxBg/PtcTitleTxt")
    if locObj_WeeklyBossPlanPanel_PtcTitleTxt then
        locObj_WeeklyBossPlanPanel_PtcTitleTxt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.WeeklyBossPlanPanel_PtcTitleTxt
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return WeeklyBossPlanPanel