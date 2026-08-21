---@class WeeklyBossChangePlanPanel_Generate_weeklyBossTagBox
---@field public gameObject UnityEngine.GameObject
---@field public weeklyBossTagBox WeeklyBossTagBox

---@class WeeklyBossChangePlanPanel_Generate_cancelBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class WeeklyBossChangePlanPanel_Generate_okBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class WeeklyBossChangePlanPanel_Generate_bg
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class WeeklyBossChangePlanPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public bg WeeklyBossChangePlanPanel_Generate_bg
---@field public okBtn WeeklyBossChangePlanPanel_Generate_okBtn
---@field public cancelBtn WeeklyBossChangePlanPanel_Generate_cancelBtn
---@field public tagBoxList UnityEngine.GameObject
---@field public weeklyBossTagBox WeeklyBossChangePlanPanel_Generate_weeklyBossTagBox
local WeeklyBossChangePlanPanel = class("WeeklyBossChangePlanPanel", require("WndBase"))

function WeeklyBossChangePlanPanel:ctor(data)
end

---@private
function WeeklyBossChangePlanPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("WeeklyBossChangePlanPanel")

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
function WeeklyBossChangePlanPanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function WeeklyBossChangePlanPanel:InitGenerate__2(Root, data)
--[[
	Bg
--]]
	local tmp = Root:Find("Bg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.bg = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("WeeklyBossChangePlanPanel_bg")
			if self.bg_Button_onClick then
				self:bg_Button_onClick(self.bg)
			end
		end)


end

---@private
function WeeklyBossChangePlanPanel:InitGenerate__3(Root, data)
--[[
	Bg/OkBtn
--]]
	local tmp = Root:Find("Bg/OkBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.okBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("WeeklyBossChangePlanPanel_okBtn")
			if self.okBtn_ScaleButton_onClick then
				self:okBtn_ScaleButton_onClick(self.okBtn)
			end
		end)


end

---@private
function WeeklyBossChangePlanPanel:InitGenerate__4(Root, data)
--[[
	Bg/CancelBtn
--]]
	local tmp = Root:Find("Bg/CancelBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.cancelBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("WeeklyBossChangePlanPanel_cancelBtn")
			if self.cancelBtn_ScaleButton_onClick then
				self:cancelBtn_ScaleButton_onClick(self.cancelBtn)
			end
		end)


end

---@private
function WeeklyBossChangePlanPanel:InitGenerate__5(Root, data)
--[[
	Bg/TagBoxList
--]]
	local tmp = Root:Find("Bg/TagBoxList").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.tagBoxList = tmp


end

---@private
function WeeklyBossChangePlanPanel:InitGenerate__6(Root, data)
--[[
	Bg/TagBoxList/WeeklyBossTagBox
--]]
	local tmp = Root:Find("Bg/TagBoxList/WeeklyBossTagBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.weeklyBossTagBox = tmp

	tmp.weeklyBossTagBox = tmp:AddComponentLua("WeeklyBossTagBox", data)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function WeeklyBossChangePlanPanel:SetLocalizedText(Root)

    local locObj_WeeklyBossChangePlanPanel_TitleTxt = Root:Find("Bg/TitleTxt")
    if locObj_WeeklyBossChangePlanPanel_TitleTxt then
        locObj_WeeklyBossChangePlanPanel_TitleTxt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.WeeklyBossChangePlanPanel_TitleTxt
    end

    local locObj_WeeklyBossChangePlanPanel_txt = Root:Find("Bg/OkBtn/txt")
    if locObj_WeeklyBossChangePlanPanel_txt then
        locObj_WeeklyBossChangePlanPanel_txt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.WeeklyBossChangePlanPanel_txt
    end

    local locObj_WeeklyBossChangePlanPanel_Cn_txt = Root:Find("Bg/CancelBtn/txt")
    if locObj_WeeklyBossChangePlanPanel_Cn_txt then
        locObj_WeeklyBossChangePlanPanel_Cn_txt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.WeeklyBossChangePlanPanel_Cn_txt
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return WeeklyBossChangePlanPanel