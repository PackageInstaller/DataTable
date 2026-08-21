---@class RulePanel__Generate_ruleText
---@field public gameObject UnityEngine.GameObject
---@field public text UnityEngine.UI.Text

---@class RulePanel__Generate_title
---@field public gameObject UnityEngine.GameObject
---@field public text UnityEngine.UI.Text

---@class RulePanel__Generate
---@field private gameObject UnityEngine.GameObject
---@field private transform UnityEngine.Transform
---@field private uiConfig table
---@field private button UnityEngine.UI.Button
---@field private uiAudio UIAudio
---@field private title RulePanel__Generate_title
---@field private ruleText RulePanel__Generate_ruleText
local RulePanel = class("RulePanel", require("MsgBoxBase"))

function RulePanel:ctor(data)
end

---@private
function RulePanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("RulePanel")

	local Root = self.transform 
	local tmp

	self:InitGenerate__1(Root,data)
	self:InitGenerate__2(Root,data)
	self:InitGenerate__3(Root,data)
	self:InitGenerate__4(Root,data)

	self:InitLogic(data)

end

---@private
function RulePanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.button = Root:GetComponent(TypeInfo.Button)
	self.uiAudio = Root:GetComponent(TypeInfo.UIAudio)
	self.button.onClick:RemoveAllListeners()
	self.button.onClick:AddListener(function ()
			if self.uiAudio.click then
				self:play2DSound(self.uiAudio.click, 1, 1)
			end
			if self.button_Button_onClick then
				self:button_Button_onClick(self)
			end
		end)


end

---@private
function RulePanel:InitGenerate__2(Root, data)
--[[
	BgClickClose
--]]
	local tmp = Root:Find("BgClickClose").gameObject

	tmp:AddComponentLua("BgClickClose", data)


end

---@private
function RulePanel:InitGenerate__3(Root, data)
--[[
	title
--]]
	local tmp = Root:Find("title").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.title = tmp

	tmp.text = tmp:GetComponent(TypeInfo.Text)


end

---@private
function RulePanel:InitGenerate__4(Root, data)
--[[
	Scroll View/Viewport/Content
--]]
	local tmp = Root:Find("Scroll View/Viewport/Content").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.ruleText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.Text)


end

return RulePanel