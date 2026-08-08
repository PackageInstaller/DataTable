---@class InterludeLoadingPanel_Generate_precent
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class InterludeLoadingPanel_Generate_tips
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class InterludeLoadingPanel_Generate_progress
---@field public gameObject UnityEngine.GameObject
---@field public slider UnityEngine.UI.Slider

---@class InterludeLoadingPanel_Generate_bgList
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform

---@class InterludeLoadingPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public rectTransform UnityEngine.RectTransform
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public bgList InterludeLoadingPanel_Generate_bgList
---@field public progress InterludeLoadingPanel_Generate_progress
---@field public tips InterludeLoadingPanel_Generate_tips
---@field public galo UnityEngine.GameObject
---@field public precent InterludeLoadingPanel_Generate_precent
local InterludeLoadingPanel = class("InterludeLoadingPanel", require("WndBase"))

function InterludeLoadingPanel:ctor(data)
end

---@private
function InterludeLoadingPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("InterludeLoadingPanel")

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
function InterludeLoadingPanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.rectTransform = Root:GetComponent(TypeInfo.RectTransform)

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function InterludeLoadingPanel:InitGenerate__2(Root, data)
--[[
	bgList
--]]
	local tmp = Root:Find("bgList").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.bgList = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)


end

---@private
function InterludeLoadingPanel:InitGenerate__3(Root, data)
--[[
	Progress
--]]
	local tmp = Root:Find("Progress").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.progress = tmp

	tmp.slider = tmp:GetComponent(TypeInfo.Slider)
	tmp.slider.onValueChanged:RemoveAllListeners()
	tmp.slider.onValueChanged:AddListener(function (value)
			if self.progress_Slider_onValueChanged then
				self:progress_Slider_onValueChanged(self.progress,value)
			end
		end)


end

---@private
function InterludeLoadingPanel:InitGenerate__4(Root, data)
--[[
	Progress/tips
--]]
	local tmp = Root:Find("Progress/tips").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.tips = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function InterludeLoadingPanel:InitGenerate__5(Root, data)
--[[
	galo
--]]
	local tmp = Root:Find("galo").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.galo = tmp


end

---@private
function InterludeLoadingPanel:InitGenerate__6(Root, data)
--[[
	loading_numberbox/precent
--]]
	local tmp = Root:Find("loading_numberbox/precent").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.precent = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function InterludeLoadingPanel:SetLocalizedText(Root)

    local locObj_InterludeLoadingPanel_txt = Root:Find("update/txt")
    if locObj_InterludeLoadingPanel_txt then
        locObj_InterludeLoadingPanel_txt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.InterludeLoadingPanel_txt
    end

    local locObj_InterludeLoadingPanel_updatePercent = Root:Find("update/updatePercent")
    if locObj_InterludeLoadingPanel_updatePercent then
        locObj_InterludeLoadingPanel_updatePercent.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.InterludeLoadingPanel_updatePercent
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return InterludeLoadingPanel