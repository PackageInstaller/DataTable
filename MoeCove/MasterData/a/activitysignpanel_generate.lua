---@class ActivitySignPanel_Generate_customMsgPanel
---@field public gameObject UnityEngine.GameObject
---@field public customMsgPanel CustomMsgPanel

---@class ActivitySignPanel_Generate_signNode_customBox2
---@field public gameObject UnityEngine.GameObject
---@field public customBox CustomBox

---@class ActivitySignPanel_Generate_signNode_customBox1
---@field public gameObject UnityEngine.GameObject
---@field public customBox CustomBox

---@class ActivitySignPanel_Generate_signNode_dayText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class ActivitySignPanel_Generate_signNode_index
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class ActivitySignPanel_Generate_signNode
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public scaleButton ScaleButton
---@field public canvasGroup UnityEngine.CanvasGroup
---@field public sel UnityEngine.GameObject
---@field public index ActivitySignPanel_Generate_signNode_index
---@field public dayText ActivitySignPanel_Generate_signNode_dayText
---@field public customBox1 ActivitySignPanel_Generate_signNode_customBox1
---@field public customBox2 ActivitySignPanel_Generate_signNode_customBox2
---@field public getMask UnityEngine.GameObject
---@field public mark UnityEngine.GameObject
---@field public tip UnityEngine.GameObject

---@class ActivitySignPanel_Generate_content
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform

---@class ActivitySignPanel_Generate_contentView
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform

---@class ActivitySignPanel_Generate_text
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class ActivitySignPanel_Generate_time
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class ActivitySignPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public rectTransform UnityEngine.RectTransform
---@field public time ActivitySignPanel_Generate_time
---@field public text ActivitySignPanel_Generate_text
---@field public contentView ActivitySignPanel_Generate_contentView
---@field public content ActivitySignPanel_Generate_content
---@field public signNode ActivitySignPanel_Generate_signNode
---@field public customMsgPanel ActivitySignPanel_Generate_customMsgPanel
local ActivitySignPanel = class("ActivitySignPanel", require("WndBase"))

function ActivitySignPanel:ctor(data)
end

---@private
function ActivitySignPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("ActivitySignPanel")

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

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function ActivitySignPanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.rectTransform = Root:GetComponent(TypeInfo.RectTransform)


end

---@private
function ActivitySignPanel:InitGenerate__2(Root, data)
--[[
	infoView/TimeBg/Time
--]]
	local tmp = Root:Find("infoView/TimeBg/Time").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.time = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function ActivitySignPanel:InitGenerate__3(Root, data)
--[[
	infoView/dicText/Text
--]]
	local tmp = Root:Find("infoView/dicText/Text").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.text = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function ActivitySignPanel:InitGenerate__4(Root, data)
--[[
	contentView
--]]
	local tmp = Root:Find("contentView").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.contentView = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)


end

---@private
function ActivitySignPanel:InitGenerate__5(Root, data)
--[[
	contentView/Scroll View/Viewport/Content
--]]
	local tmp = Root:Find("contentView/Scroll View/Viewport/Content").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.content = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)


end

---@private
function ActivitySignPanel:InitGenerate__6(Root, data)
--[[
	contentView/Scroll View/Viewport/Content/SignNode
--]]
	local tmp = Root:Find("contentView/Scroll View/Viewport/Content/SignNode").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.signNode = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("ActivitySignPanel_signNode")
			if self.signNode_ScaleButton_onClick then
				self:signNode_ScaleButton_onClick(self.signNode)
			end
		end)

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function ActivitySignPanel:InitGenerate__7(Root, data)
--[[
	contentView/Scroll View/Viewport/Content/SignNode/Sel
--]]
	local tmp = Root:Find("contentView/Scroll View/Viewport/Content/SignNode/Sel").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.signNode.sel = tmp


end

---@private
function ActivitySignPanel:InitGenerate__8(Root, data)
--[[
	contentView/Scroll View/Viewport/Content/SignNode/Index
--]]
	local tmp = Root:Find("contentView/Scroll View/Viewport/Content/SignNode/Index").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.signNode.index = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function ActivitySignPanel:InitGenerate__9(Root, data)
--[[
	contentView/Scroll View/Viewport/Content/SignNode/DayText
--]]
	local tmp = Root:Find("contentView/Scroll View/Viewport/Content/SignNode/DayText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.signNode.dayText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function ActivitySignPanel:InitGenerate__10(Root, data)
--[[
	contentView/Scroll View/Viewport/Content/SignNode/CustomBox1
--]]
	local tmp = Root:Find("contentView/Scroll View/Viewport/Content/SignNode/CustomBox1").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.signNode.customBox1 = tmp

	tmp.customBox = tmp:AddComponentLua("CustomBox", data)


end

---@private
function ActivitySignPanel:InitGenerate__11(Root, data)
--[[
	contentView/Scroll View/Viewport/Content/SignNode/CustomBox2
--]]
	local tmp = Root:Find("contentView/Scroll View/Viewport/Content/SignNode/CustomBox2").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.signNode.customBox2 = tmp

	tmp.customBox = tmp:AddComponentLua("CustomBox", data)


end

---@private
function ActivitySignPanel:InitGenerate__12(Root, data)
--[[
	contentView/Scroll View/Viewport/Content/SignNode/GetMask
--]]
	local tmp = Root:Find("contentView/Scroll View/Viewport/Content/SignNode/GetMask").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.signNode.getMask = tmp


end

---@private
function ActivitySignPanel:InitGenerate__13(Root, data)
--[[
	contentView/Scroll View/Viewport/Content/SignNode/Mark
--]]
	local tmp = Root:Find("contentView/Scroll View/Viewport/Content/SignNode/Mark").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.signNode.mark = tmp


end

---@private
function ActivitySignPanel:InitGenerate__14(Root, data)
--[[
	contentView/Scroll View/Viewport/Content/SignNode/Tip
--]]
	local tmp = Root:Find("contentView/Scroll View/Viewport/Content/SignNode/Tip").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.signNode.tip = tmp


end

---@private
function ActivitySignPanel:InitGenerate__15(Root, data)
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


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function ActivitySignPanel:SetLocalizedText(Root)

    local locObj_ActivitySignPanel_nameText = Root:Find("infoView/nameText")
    if locObj_ActivitySignPanel_nameText then
        locObj_ActivitySignPanel_nameText.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.ActivitySignPanel_nameText
    end

    local locObj_ActivitySignPanel_Text = Root:Find("infoView/TimeBg/Text")
    if locObj_ActivitySignPanel_Text then
        locObj_ActivitySignPanel_Text.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.ActivitySignPanel_Text
    end

    local locObj_ActivitySignPanel_Se_Text = Root:Find("contentView/Scroll View/Viewport/Content/SignNode/DayText")
    if locObj_ActivitySignPanel_Se_Text then
        locObj_ActivitySignPanel_Se_Text.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.ActivitySignPanel_Se_Text
    end

    local locObj_ActivitySignPanel_Text2 = Root:Find("contentView/Scroll View/Viewport/Content/SignNode/Tip/Text (2)")
    if locObj_ActivitySignPanel_Text2 then
        locObj_ActivitySignPanel_Text2.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.ActivitySignPanel_Text2
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return ActivitySignPanel