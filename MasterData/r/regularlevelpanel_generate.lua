---@class RegularLevelPanel_Generate_levelGroupBox_groupText
---@field public gameObject UnityEngine.GameObject
---@field public text UnityEngine.UI.Text

---@class RegularLevelPanel_Generate_levelGroupBox
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton
---@field public groupText RegularLevelPanel_Generate_levelGroupBox_groupText

---@class RegularLevelPanel_Generate_typeBox_typeText
---@field public gameObject UnityEngine.GameObject
---@field public text UnityEngine.UI.Text

---@class RegularLevelPanel_Generate_typeBox
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton
---@field public typeText RegularLevelPanel_Generate_typeBox_typeText

---@class RegularLevelPanel_Generate_backMainlBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class RegularLevelPanel_Generate_backBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class RegularLevelPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public backBtn RegularLevelPanel_Generate_backBtn
---@field public backMainlBtn RegularLevelPanel_Generate_backMainlBtn
---@field public regularTypeList UnityEngine.GameObject
---@field public typeBox RegularLevelPanel_Generate_typeBox
---@field public levelGroupList UnityEngine.GameObject
---@field public levelGroupBox RegularLevelPanel_Generate_levelGroupBox
local RegularLevelPanel = class("RegularLevelPanel", require("WndBase"))

function RegularLevelPanel:ctor(data)
end

---@private
function RegularLevelPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("RegularLevelPanel")

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

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function RegularLevelPanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function RegularLevelPanel:InitGenerate__2(Root, data)
--[[
	BackBtn
--]]
	local tmp = Root:Find("BackBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.backBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("RegularLevelPanel_backBtn")
			if self.backBtn_ScaleButton_onClick then
				self:backBtn_ScaleButton_onClick(self.backBtn)
			end
		end)


end

---@private
function RegularLevelPanel:InitGenerate__3(Root, data)
--[[
	BackMainlBtn
--]]
	local tmp = Root:Find("BackMainlBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.backMainlBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("RegularLevelPanel_backMainlBtn")
			if self.backMainlBtn_ScaleButton_onClick then
				self:backMainlBtn_ScaleButton_onClick(self.backMainlBtn)
			end
		end)


end

---@private
function RegularLevelPanel:InitGenerate__4(Root, data)
--[[
	RegularTypeList
--]]
	local tmp = Root:Find("RegularTypeList").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.regularTypeList = tmp


end

---@private
function RegularLevelPanel:InitGenerate__5(Root, data)
--[[
	RegularTypeList/TypeBox
--]]
	local tmp = Root:Find("RegularTypeList/TypeBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.typeBox = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)


end

---@private
function RegularLevelPanel:InitGenerate__6(Root, data)
--[[
	RegularTypeList/TypeBox/TypeText
--]]
	local tmp = Root:Find("RegularTypeList/TypeBox/TypeText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.typeBox.typeText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.Text)


end

---@private
function RegularLevelPanel:InitGenerate__7(Root, data)
--[[
	LevelGroupList
--]]
	local tmp = Root:Find("LevelGroupList").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.levelGroupList = tmp


end

---@private
function RegularLevelPanel:InitGenerate__8(Root, data)
--[[
	LevelGroupList/LevelGroupBox
--]]
	local tmp = Root:Find("LevelGroupList/LevelGroupBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.levelGroupBox = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)


end

---@private
function RegularLevelPanel:InitGenerate__9(Root, data)
--[[
	LevelGroupList/LevelGroupBox/GroupText
--]]
	local tmp = Root:Find("LevelGroupList/LevelGroupBox/GroupText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.levelGroupBox.groupText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.Text)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function RegularLevelPanel:SetLocalizedText(Root)

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return RegularLevelPanel