---@class StoryLogPanel_Generate_logBox_worsText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.RubyTextMeshProUGUI

---@class StoryLogPanel_Generate_logBox_voiceBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class StoryLogPanel_Generate_logBox_nameText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.RubyTextMeshProUGUI

---@class StoryLogPanel_Generate_logBox
---@field public gameObject UnityEngine.GameObject
---@field public nameText StoryLogPanel_Generate_logBox_nameText
---@field public voiceBtn StoryLogPanel_Generate_logBox_voiceBtn
---@field public selectNow UnityEngine.GameObject
---@field public worsText StoryLogPanel_Generate_logBox_worsText

---@class StoryLogPanel_Generate_conent
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform

---@class StoryLogPanel_Generate_logPanel
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform

---@class StoryLogPanel_Generate_closeBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class StoryLogPanel_Generate_bg
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class StoryLogPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public animator UnityEngine.Animator
---@field public canvasGroup UnityEngine.CanvasGroup
---@field public animOverCallBack AnimOverCallBack
---@field public bg StoryLogPanel_Generate_bg
---@field public closeBtn StoryLogPanel_Generate_closeBtn
---@field public logPanel StoryLogPanel_Generate_logPanel
---@field public conent StoryLogPanel_Generate_conent
---@field public logBox StoryLogPanel_Generate_logBox
local StoryLogPanel = class("StoryLogPanel", require("WndBase"))

function StoryLogPanel:ctor(data)
end

---@private
function StoryLogPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("StoryLogPanel")

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

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function StoryLogPanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.canvasGroup = Root:GetComponent(TypeInfo.CanvasGroup)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function StoryLogPanel:InitGenerate__2(Root, data)
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
		UIMgr:SendUiUseMessage("StoryLogPanel_bg")
			if self.bg_Button_onClick then
				self:bg_Button_onClick(self.bg)
			end
		end)


end

---@private
function StoryLogPanel:InitGenerate__3(Root, data)
--[[
	Bg/CloseBtn
--]]
	local tmp = Root:Find("Bg/CloseBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.closeBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("StoryLogPanel_closeBtn")
			if self.closeBtn_ScaleButton_onClick then
				self:closeBtn_ScaleButton_onClick(self.closeBtn)
			end
		end)


end

---@private
function StoryLogPanel:InitGenerate__4(Root, data)
--[[
	LogPanel
--]]
	local tmp = Root:Find("LogPanel").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.logPanel = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)


end

---@private
function StoryLogPanel:InitGenerate__5(Root, data)
--[[
	LogPanel/Viewport/Conent
--]]
	local tmp = Root:Find("LogPanel/Viewport/Conent").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.conent = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)


end

---@private
function StoryLogPanel:InitGenerate__6(Root, data)
--[[
	LogPanel/Viewport/Conent/LogBox
--]]
	local tmp = Root:Find("LogPanel/Viewport/Conent/LogBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.logBox = tmp


end

---@private
function StoryLogPanel:InitGenerate__7(Root, data)
--[[
	LogPanel/Viewport/Conent/LogBox/NameText
--]]
	local tmp = Root:Find("LogPanel/Viewport/Conent/LogBox/NameText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.logBox.nameText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.RubyTextMeshProUGUI)


end

---@private
function StoryLogPanel:InitGenerate__8(Root, data)
--[[
	LogPanel/Viewport/Conent/LogBox/NameText/VoiceBtn
--]]
	local tmp = Root:Find("LogPanel/Viewport/Conent/LogBox/NameText/VoiceBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.logBox.voiceBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)


end

---@private
function StoryLogPanel:InitGenerate__9(Root, data)
--[[
	LogPanel/Viewport/Conent/LogBox/NameText/SelectNow
--]]
	local tmp = Root:Find("LogPanel/Viewport/Conent/LogBox/NameText/SelectNow").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.logBox.selectNow = tmp


end

---@private
function StoryLogPanel:InitGenerate__10(Root, data)
--[[
	LogPanel/Viewport/Conent/LogBox/WorsText
--]]
	local tmp = Root:Find("LogPanel/Viewport/Conent/LogBox/WorsText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.logBox.worsText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.RubyTextMeshProUGUI)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function StoryLogPanel:SetLocalizedText(Root)

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return StoryLogPanel