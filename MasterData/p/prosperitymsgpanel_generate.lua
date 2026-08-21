---@class ProsperityMsgPanel_Generate_todayValuetTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class ProsperityMsgPanel_Generate_closeBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class ProsperityMsgPanel_Generate_titleText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class ProsperityMsgPanel_Generate_mask
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class ProsperityMsgPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public mask ProsperityMsgPanel_Generate_mask
---@field public titleText ProsperityMsgPanel_Generate_titleText
---@field public closeBtn ProsperityMsgPanel_Generate_closeBtn
---@field public listView UnityEngine.GameObject
---@field public teachList UnityEngine.GameObject
---@field public todayValuetTxt ProsperityMsgPanel_Generate_todayValuetTxt
local ProsperityMsgPanel = class("ProsperityMsgPanel", require("WndBase"))

function ProsperityMsgPanel:ctor(data)
end

---@private
function ProsperityMsgPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("ProsperityMsgPanel")

	local Root = self.transform 
	local tmp

	self:InitGenerate__1(Root,data)
	self:InitGenerate__2(Root,data)
	self:InitGenerate__3(Root,data)
	self:InitGenerate__4(Root,data)
	self:InitGenerate__5(Root,data)
	self:InitGenerate__6(Root,data)
	self:InitGenerate__7(Root,data)

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function ProsperityMsgPanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function ProsperityMsgPanel:InitGenerate__2(Root, data)
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
		UIMgr:SendUiUseMessage("ProsperityMsgPanel_mask")
			if self.mask_Button_onClick then
				self:mask_Button_onClick(self.mask)
			end
		end)


end

---@private
function ProsperityMsgPanel:InitGenerate__3(Root, data)
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
function ProsperityMsgPanel:InitGenerate__4(Root, data)
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
		UIMgr:SendUiUseMessage("ProsperityMsgPanel_closeBtn")
			if self.closeBtn_ScaleButton_onClick then
				self:closeBtn_ScaleButton_onClick(self.closeBtn)
			end
		end)


end

---@private
function ProsperityMsgPanel:InitGenerate__5(Root, data)
--[[
	BoxBg/ListView
--]]
	local tmp = Root:Find("BoxBg/ListView").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.listView = tmp


end

---@private
function ProsperityMsgPanel:InitGenerate__6(Root, data)
--[[
	BoxBg/ListView/Scroll View/Viewport/TeachList
--]]
	local tmp = Root:Find("BoxBg/ListView/Scroll View/Viewport/TeachList").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.teachList = tmp


end

---@private
function ProsperityMsgPanel:InitGenerate__7(Root, data)
--[[
	BoxBg/ListView/Scroll View/Viewport/TeachList/RulesBox2/TodayBg/TodayValuetTxt
--]]
	local tmp = Root:Find("BoxBg/ListView/Scroll View/Viewport/TeachList/RulesBox2/TodayBg/TodayValuetTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.todayValuetTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function ProsperityMsgPanel:SetLocalizedText(Root)

    local locObj_ProsperityMsgPanel_TitleText2 = Root:Find("BoxBg/TitleSideBg/Titlebg/TitleText2")
    if locObj_ProsperityMsgPanel_TitleText2 then
        locObj_ProsperityMsgPanel_TitleText2.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.ProsperityMsgPanel_TitleText2
    end

    local locObj_ProsperityMsgPanel_TitleTxt1 = Root:Find("BoxBg/ListView/Scroll View/Viewport/TeachList/RulesBox1/TxtTitleBg/TitleTxt1")
    if locObj_ProsperityMsgPanel_TitleTxt1 then
        locObj_ProsperityMsgPanel_TitleTxt1.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.ProsperityMsgPanel_TitleTxt1
    end

    local locObj_ProsperityMsgPanel_RulesTxt = Root:Find("BoxBg/ListView/Scroll View/Viewport/TeachList/RulesBox1/RulesTxt")
    if locObj_ProsperityMsgPanel_RulesTxt then
        locObj_ProsperityMsgPanel_RulesTxt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.ProsperityMsgPanel_RulesTxt
    end

    local locObj_ProsperityMsgPanel_TitleTxt2 = Root:Find("BoxBg/ListView/Scroll View/Viewport/TeachList/RulesBox2/TxtTitleBg/TitleTxt2")
    if locObj_ProsperityMsgPanel_TitleTxt2 then
        locObj_ProsperityMsgPanel_TitleTxt2.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.ProsperityMsgPanel_TitleTxt2
    end

    local locObj_ProsperityMsgPanel_Todaytxt = Root:Find("BoxBg/ListView/Scroll View/Viewport/TeachList/RulesBox2/TodayBg/Todaytxt")
    if locObj_ProsperityMsgPanel_Todaytxt then
        locObj_ProsperityMsgPanel_Todaytxt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.ProsperityMsgPanel_Todaytxt
    end

    local locObj_ProsperityMsgPanel_R2_RulesTxt = Root:Find("BoxBg/ListView/Scroll View/Viewport/TeachList/RulesBox2/RulesTxt")
    if locObj_ProsperityMsgPanel_R2_RulesTxt then
        locObj_ProsperityMsgPanel_R2_RulesTxt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.ProsperityMsgPanel_R2_RulesTxt
    end

    local locObj_ProsperityMsgPanel_RulesTxt1 = Root:Find("BoxBg/ListView/Scroll View/Viewport/TeachList/RulesBox2/RulesTxt (1)")
    if locObj_ProsperityMsgPanel_RulesTxt1 then
        locObj_ProsperityMsgPanel_RulesTxt1.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.ProsperityMsgPanel_RulesTxt1
    end

    local locObj_ProsperityMsgPanel_RulesTxt2 = Root:Find("BoxBg/ListView/Scroll View/Viewport/TeachList/RulesBox2/RulesTxt (2)")
    if locObj_ProsperityMsgPanel_RulesTxt2 then
        locObj_ProsperityMsgPanel_RulesTxt2.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.ProsperityMsgPanel_RulesTxt2
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return ProsperityMsgPanel