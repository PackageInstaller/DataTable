---@class WeatherForecastPanel_Generate_closeBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class WeatherForecastPanel_Generate_timeText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class WeatherForecastPanel_Generate_dialogueText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class WeatherForecastPanel_Generate_spineRoot
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform

---@class WeatherForecastPanel_Generate_reportRoot
---@field public gameObject UnityEngine.GameObject
---@field public canvasGroup UnityEngine.CanvasGroup

---@class WeatherForecastPanel_Generate_videoRoot
---@field public gameObject UnityEngine.GameObject
---@field public animOverCallBack AnimOverCallBack

---@class WeatherForecastPanel_Generate_autoRoot
---@field public gameObject UnityEngine.GameObject
---@field public autoAdjustCanvasRoot AutoAdjustCanvasRoot

---@class WeatherForecastPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public autoRoot WeatherForecastPanel_Generate_autoRoot
---@field public videoRoot WeatherForecastPanel_Generate_videoRoot
---@field public reportRoot WeatherForecastPanel_Generate_reportRoot
---@field public spineRoot WeatherForecastPanel_Generate_spineRoot
---@field public dialogueText WeatherForecastPanel_Generate_dialogueText
---@field public timeText WeatherForecastPanel_Generate_timeText
---@field public closeBtn WeatherForecastPanel_Generate_closeBtn
local WeatherForecastPanel = class("WeatherForecastPanel", require("WndBase"))

function WeatherForecastPanel:ctor(data)
end

---@private
function WeatherForecastPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("WeatherForecastPanel")

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

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function WeatherForecastPanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function WeatherForecastPanel:InitGenerate__2(Root, data)
--[[
	autoRoot
--]]
	local tmp = Root:Find("autoRoot").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.autoRoot = tmp

	tmp.autoAdjustCanvasRoot = tmp:GetComponent(TypeInfo.AutoAdjustCanvasRoot)


end

---@private
function WeatherForecastPanel:InitGenerate__3(Root, data)
--[[
	autoRoot/content/videoRoot
--]]
	local tmp = Root:Find("autoRoot/content/videoRoot").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.videoRoot = tmp

	tmp.animOverCallBack = tmp:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function WeatherForecastPanel:InitGenerate__4(Root, data)
--[[
	autoRoot/content/reportRoot
--]]
	local tmp = Root:Find("autoRoot/content/reportRoot").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.reportRoot = tmp

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function WeatherForecastPanel:InitGenerate__5(Root, data)
--[[
	autoRoot/content/reportRoot/spineRoot
--]]
	local tmp = Root:Find("autoRoot/content/reportRoot/spineRoot").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.spineRoot = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)


end

---@private
function WeatherForecastPanel:InitGenerate__6(Root, data)
--[[
	autoRoot/content/reportRoot/dialogueRoot/dialogueText
--]]
	local tmp = Root:Find("autoRoot/content/reportRoot/dialogueRoot/dialogueText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.dialogueText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function WeatherForecastPanel:InitGenerate__7(Root, data)
--[[
	autoRoot/content/reportRoot/liveRoot/bgImage/timeText
--]]
	local tmp = Root:Find("autoRoot/content/reportRoot/liveRoot/bgImage/timeText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.timeText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function WeatherForecastPanel:InitGenerate__8(Root, data)
--[[
	autoRoot/closeBtn
--]]
	local tmp = Root:Find("autoRoot/closeBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.closeBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("WeatherForecastPanel_closeBtn")
			if self.closeBtn_ScaleButton_onClick then
				self:closeBtn_ScaleButton_onClick(self.closeBtn)
			end
		end)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function WeatherForecastPanel:SetLocalizedText(Root)

    local locObj_WeatherForecastPanel_titleText = Root:Find("autoRoot/content/videoRoot/titleText")
    if locObj_WeatherForecastPanel_titleText then
        locObj_WeatherForecastPanel_titleText.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.WeatherForecastPanel_titleText
    end

    local locObj_WeatherForecastPanel_liveText = Root:Find("autoRoot/content/videoRoot/liveText")
    if locObj_WeatherForecastPanel_liveText then
        locObj_WeatherForecastPanel_liveText.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.WeatherForecastPanel_liveText
    end

    local locObj_WeatherForecastPanel_lt_liveText = Root:Find("autoRoot/content/reportRoot/liveRoot/liveText")
    if locObj_WeatherForecastPanel_lt_liveText then
        locObj_WeatherForecastPanel_lt_liveText.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.WeatherForecastPanel_lt_liveText
    end

    local locObj_WeatherForecastPanel_newsText = Root:Find("autoRoot/content/reportRoot/liveRoot/newsText")
    if locObj_WeatherForecastPanel_newsText then
        locObj_WeatherForecastPanel_newsText.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.WeatherForecastPanel_newsText
    end

    local locObj_WeatherForecastPanel_Text = Root:Find("autoRoot/content/reportRoot/liveRoot/Text")
    if locObj_WeatherForecastPanel_Text then
        locObj_WeatherForecastPanel_Text.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.WeatherForecastPanel_Text
    end

    local locObj_WeatherForecastPanel_tt_Text = Root:Find("autoRoot/content/reportRoot/tagRoot/Text")
    if locObj_WeatherForecastPanel_tt_Text then
        locObj_WeatherForecastPanel_tt_Text.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.WeatherForecastPanel_tt_Text
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return WeatherForecastPanel