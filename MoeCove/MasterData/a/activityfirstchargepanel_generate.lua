---@class ActivityFirstChargePanel_Generate_box_desc
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class ActivityFirstChargePanel_Generate_box_customBox
---@field public gameObject UnityEngine.GameObject
---@field public customBox CustomBox

---@class ActivityFirstChargePanel_Generate_box
---@field public gameObject UnityEngine.GameObject
---@field public canvasGroup UnityEngine.CanvasGroup
---@field public customBox ActivityFirstChargePanel_Generate_box_customBox
---@field public desc ActivityFirstChargePanel_Generate_box_desc

---@class ActivityFirstChargePanel_Generate_middleDis
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform

---@class ActivityFirstChargePanel_Generate_doneBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class ActivityFirstChargePanel_Generate_goBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class ActivityFirstChargePanel_Generate_getBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class ActivityFirstChargePanel_Generate_btnGroup
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform

---@class ActivityFirstChargePanel_Generate_activityGoBtn
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public scaleButton ScaleButton

---@class ActivityFirstChargePanel_Generate_bg
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public image UnityEngine.UI.Image

---@class ActivityFirstChargePanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public rectTransform UnityEngine.RectTransform
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public bg ActivityFirstChargePanel_Generate_bg
---@field public closebtn UnityEngine.GameObject
---@field public activityGoBtn ActivityFirstChargePanel_Generate_activityGoBtn
---@field public btnGroup ActivityFirstChargePanel_Generate_btnGroup
---@field public getBtn ActivityFirstChargePanel_Generate_getBtn
---@field public redPoint UnityEngine.GameObject
---@field public goBtn ActivityFirstChargePanel_Generate_goBtn
---@field public doneBtn ActivityFirstChargePanel_Generate_doneBtn
---@field public middleDis ActivityFirstChargePanel_Generate_middleDis
---@field public box ActivityFirstChargePanel_Generate_box
local ActivityFirstChargePanel = class("ActivityFirstChargePanel", require("WndBase"))

function ActivityFirstChargePanel:ctor(data)
end

---@private
function ActivityFirstChargePanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("ActivityFirstChargePanel")

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

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function ActivityFirstChargePanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.rectTransform = Root:GetComponent(TypeInfo.RectTransform)

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function ActivityFirstChargePanel:InitGenerate__2(Root, data)
--[[
	bg
--]]
	local tmp = Root:Find("bg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.bg = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function ActivityFirstChargePanel:InitGenerate__3(Root, data)
--[[
	bg/closebtn
--]]
	local tmp = Root:Find("bg/closebtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.closebtn = tmp


end

---@private
function ActivityFirstChargePanel:InitGenerate__4(Root, data)
--[[
	bg/topic/activityGoBtn
--]]
	local tmp = Root:Find("bg/topic/activityGoBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.activityGoBtn = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("ActivityFirstChargePanel_activityGoBtn")
			if self.activityGoBtn_ScaleButton_onClick then
				self:activityGoBtn_ScaleButton_onClick(self.activityGoBtn)
			end
		end)


end

---@private
function ActivityFirstChargePanel:InitGenerate__5(Root, data)
--[[
	bg/bottom/btnGroup
--]]
	local tmp = Root:Find("bg/bottom/btnGroup").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.btnGroup = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)


end

---@private
function ActivityFirstChargePanel:InitGenerate__6(Root, data)
--[[
	bg/bottom/btnGroup/getBtn
--]]
	local tmp = Root:Find("bg/bottom/btnGroup/getBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.getBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("ActivityFirstChargePanel_getBtn")
			if self.getBtn_ScaleButton_onClick then
				self:getBtn_ScaleButton_onClick(self.getBtn)
			end
		end)


end

---@private
function ActivityFirstChargePanel:InitGenerate__7(Root, data)
--[[
	bg/bottom/btnGroup/getBtn/RedPoint
--]]
	local tmp = Root:Find("bg/bottom/btnGroup/getBtn/RedPoint").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.redPoint = tmp


end

---@private
function ActivityFirstChargePanel:InitGenerate__8(Root, data)
--[[
	bg/bottom/btnGroup/goBtn
--]]
	local tmp = Root:Find("bg/bottom/btnGroup/goBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.goBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("ActivityFirstChargePanel_goBtn")
			if self.goBtn_ScaleButton_onClick then
				self:goBtn_ScaleButton_onClick(self.goBtn)
			end
		end)


end

---@private
function ActivityFirstChargePanel:InitGenerate__9(Root, data)
--[[
	bg/bottom/btnGroup/doneBtn
--]]
	local tmp = Root:Find("bg/bottom/btnGroup/doneBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.doneBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("ActivityFirstChargePanel_doneBtn")
			if self.doneBtn_ScaleButton_onClick then
				self:doneBtn_ScaleButton_onClick(self.doneBtn)
			end
		end)


end

---@private
function ActivityFirstChargePanel:InitGenerate__10(Root, data)
--[[
	bg/bottom/middleDis
--]]
	local tmp = Root:Find("bg/bottom/middleDis").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.middleDis = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)


end

---@private
function ActivityFirstChargePanel:InitGenerate__11(Root, data)
--[[
	box
--]]
	local tmp = Root:Find("box").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.box = tmp

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function ActivityFirstChargePanel:InitGenerate__12(Root, data)
--[[
	box/CustomBox
--]]
	local tmp = Root:Find("box/CustomBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.box.customBox = tmp

	tmp.customBox = tmp:AddComponentLua("CustomBox", data)


end

---@private
function ActivityFirstChargePanel:InitGenerate__13(Root, data)
--[[
	box/desc
--]]
	local tmp = Root:Find("box/desc").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.box.desc = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function ActivityFirstChargePanel:SetLocalizedText(Root)

    local locObj_ActivityFirstChargePanel_shadow = Root:Find("bg/topic/title/shadow")
    if locObj_ActivityFirstChargePanel_shadow then
        locObj_ActivityFirstChargePanel_shadow.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.ActivityFirstChargePanel_shadow
    end

    local locObj_ActivityFirstChargePanel_title = Root:Find("bg/topic/title/shadow/title")
    if locObj_ActivityFirstChargePanel_title then
        locObj_ActivityFirstChargePanel_title.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.ActivityFirstChargePanel_title
    end

    local locObj_ActivityFirstChargePanel_Text = Root:Find("bg/topic/title/TimeBg/Text")
    if locObj_ActivityFirstChargePanel_Text then
        locObj_ActivityFirstChargePanel_Text.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.ActivityFirstChargePanel_Text
    end

    local locObj_ActivityFirstChargePanel_desc = Root:Find("bg/topic/desc")
    if locObj_ActivityFirstChargePanel_desc then
        locObj_ActivityFirstChargePanel_desc.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.ActivityFirstChargePanel_desc
    end

    local locObj_ActivityFirstChargePanel_TextTMP = Root:Find("bg/topic/activityGoBtn/Text (TMP)")
    if locObj_ActivityFirstChargePanel_TextTMP then
        locObj_ActivityFirstChargePanel_TextTMP.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.ActivityFirstChargePanel_TextTMP
    end

    local locObj_ActivityFirstChargePanel_gn_TextTMP = Root:Find("bg/bottom/btnGroup/getBtn/Text (TMP)")
    if locObj_ActivityFirstChargePanel_gn_TextTMP then
        locObj_ActivityFirstChargePanel_gn_TextTMP.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.ActivityFirstChargePanel_gn_TextTMP
    end

    local locObj_ActivityFirstChargePanel_bp_gn_TextTMP = Root:Find("bg/bottom/btnGroup/goBtn/Text (TMP)")
    if locObj_ActivityFirstChargePanel_bp_gn_TextTMP then
        locObj_ActivityFirstChargePanel_bp_gn_TextTMP.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.ActivityFirstChargePanel_bp_gn_TextTMP
    end

    local locObj_ActivityFirstChargePanel_dn_TextTMP = Root:Find("bg/bottom/btnGroup/doneBtn/Text (TMP)")
    if locObj_ActivityFirstChargePanel_dn_TextTMP then
        locObj_ActivityFirstChargePanel_dn_TextTMP.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.ActivityFirstChargePanel_dn_TextTMP
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return ActivityFirstChargePanel