---@class UIQuickSwitchPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
local UIQuickSwitchPanel = class("UIQuickSwitchPanel", require("WndBase"))

function UIQuickSwitchPanel:ctor(data)
end

---@private
function UIQuickSwitchPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("UIQuickSwitchPanel")

	local Root = self.transform 
	local tmp

	self:InitGenerate__1(Root,data)

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function UIQuickSwitchPanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function UIQuickSwitchPanel:SetLocalizedText(Root)

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return UIQuickSwitchPanel