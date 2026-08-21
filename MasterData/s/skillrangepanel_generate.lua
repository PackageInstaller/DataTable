---@class SkillRangePanel_Generate_rangeBox
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class SkillRangePanel_Generate_bg
---@field public gameObject UnityEngine.GameObject
---@field public pointerListener PointerListener

---@class SkillRangePanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public bg SkillRangePanel_Generate_bg
---@field public skillRangeBox UnityEngine.GameObject
---@field public rangeBoxList UnityEngine.GameObject
---@field public rangeBox SkillRangePanel_Generate_rangeBox
local SkillRangePanel = class("SkillRangePanel", require("WndBase"))

function SkillRangePanel:ctor(data)
end

---@private
function SkillRangePanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("SkillRangePanel")

	local Root = self.transform 
	local tmp

	self:InitGenerate__1(Root,data)
	self:InitGenerate__2(Root,data)
	self:InitGenerate__3(Root,data)
	self:InitGenerate__4(Root,data)

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function SkillRangePanel:InitGenerate__1(Root, data)
--[[
	Bg
--]]
	local tmp = Root:Find("Bg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.bg = tmp

	tmp.pointerListener = tmp:GetComponent(TypeInfo.PointerListener)


end

---@private
function SkillRangePanel:InitGenerate__2(Root, data)
--[[
	SkillRangeBox
--]]
	local tmp = Root:Find("SkillRangeBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.skillRangeBox = tmp


end

---@private
function SkillRangePanel:InitGenerate__3(Root, data)
--[[
	SkillRangeBox/BoxBg/RangeBoxList
--]]
	local tmp = Root:Find("SkillRangeBox/BoxBg/RangeBoxList").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rangeBoxList = tmp


end

---@private
function SkillRangePanel:InitGenerate__4(Root, data)
--[[
	SkillRangeBox/BoxBg/RangeBoxList/RangeBox
--]]
	local tmp = Root:Find("SkillRangeBox/BoxBg/RangeBoxList/RangeBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rangeBox = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function SkillRangePanel:SetLocalizedText(Root)

    local locObj_SkillRangePanel_NameText = Root:Find("SkillRangeBox/BoxBg/NameBg/NameText")
    if locObj_SkillRangePanel_NameText then
        locObj_SkillRangePanel_NameText.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.SkillRangePanel_NameText
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return SkillRangePanel