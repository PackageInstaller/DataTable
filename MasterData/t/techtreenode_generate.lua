---@class TechTreeNode_Generate_maxLvtext
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class TechTreeNode_Generate_lvtext
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class TechTreeNode_Generate_move
---@field public gameObject UnityEngine.GameObject
---@field public animation UnityEngine.Animation

---@class TechTreeNode_Generate_icon
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class TechTreeNode_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public scaleButton ScaleButton
---@field public normal UnityEngine.GameObject
---@field public icon TechTreeNode_Generate_icon
---@field public black UnityEngine.GameObject
---@field public lock UnityEngine.GameObject
---@field public move TechTreeNode_Generate_move
---@field public lvBg UnityEngine.GameObject
---@field public lvtext TechTreeNode_Generate_lvtext
---@field public maxLvtext TechTreeNode_Generate_maxLvtext
---@field public max UnityEngine.GameObject
---@field public sel UnityEngine.GameObject
---@field public activeEf UnityEngine.GameObject
local TechTreeNode = class("TechTreeNode", require("CommonBase"))

function TechTreeNode:ctor(data)
end

---@private
function TechTreeNode:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("TechTreeNode")

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

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function TechTreeNode:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.scaleButton = Root:GetComponent(TypeInfo.ScaleButton)
	self.scaleButton.onClick:RemoveAllListeners()
	self.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("TechTreeNode_scaleButton")
			if self.scaleButton_ScaleButton_onClick then
				self:scaleButton_ScaleButton_onClick(self)
			end
		end)


end

---@private
function TechTreeNode:InitGenerate__2(Root, data)
--[[
	Normal
--]]
	local tmp = Root:Find("Normal").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.normal = tmp


end

---@private
function TechTreeNode:InitGenerate__3(Root, data)
--[[
	Normal/Icon
--]]
	local tmp = Root:Find("Normal/Icon").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.icon = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function TechTreeNode:InitGenerate__4(Root, data)
--[[
	Black
--]]
	local tmp = Root:Find("Black").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.black = tmp


end

---@private
function TechTreeNode:InitGenerate__5(Root, data)
--[[
	Lock
--]]
	local tmp = Root:Find("Lock").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.lock = tmp


end

---@private
function TechTreeNode:InitGenerate__6(Root, data)
--[[
	Move
--]]
	local tmp = Root:Find("Move").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.move = tmp

	tmp.animation = tmp:GetComponent(TypeInfo.Animation)


end

---@private
function TechTreeNode:InitGenerate__7(Root, data)
--[[
	LvBg
--]]
	local tmp = Root:Find("LvBg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.lvBg = tmp


end

---@private
function TechTreeNode:InitGenerate__8(Root, data)
--[[
	LvBg/Lvtext
--]]
	local tmp = Root:Find("LvBg/Lvtext").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.lvtext = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function TechTreeNode:InitGenerate__9(Root, data)
--[[
	LvBg/MaxLvtext
--]]
	local tmp = Root:Find("LvBg/MaxLvtext").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.maxLvtext = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function TechTreeNode:InitGenerate__10(Root, data)
--[[
	Max
--]]
	local tmp = Root:Find("Max").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.max = tmp


end

---@private
function TechTreeNode:InitGenerate__11(Root, data)
--[[
	Sel
--]]
	local tmp = Root:Find("Sel").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.sel = tmp


end

---@private
function TechTreeNode:InitGenerate__12(Root, data)
--[[
	ActiveEf
--]]
	local tmp = Root:Find("ActiveEf").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.activeEf = tmp


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function TechTreeNode:SetLocalizedText(Root)

    local locObj_TechTreeNode_Text = Root:Find("LvBg/Text")
    if locObj_TechTreeNode_Text then
        locObj_TechTreeNode_Text.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.TechTreeNode_Text
    end

    local locObj_TechTreeNode_Text1 = Root:Find("Max/Text (1)")
    if locObj_TechTreeNode_Text1 then
        locObj_TechTreeNode_Text1.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.TechTreeNode_Text1
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return TechTreeNode