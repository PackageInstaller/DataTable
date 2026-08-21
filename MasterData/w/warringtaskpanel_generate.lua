---@class WarringTaskPanel_Generate_taskBox_fastBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class WarringTaskPanel_Generate_taskBox_timeTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class WarringTaskPanel_Generate_taskBox_posTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class WarringTaskPanel_Generate_taskBox_taskName
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class WarringTaskPanel_Generate_taskBox
---@field public gameObject UnityEngine.GameObject
---@field public taskName WarringTaskPanel_Generate_taskBox_taskName
---@field public posTxt WarringTaskPanel_Generate_taskBox_posTxt
---@field public timeTxt WarringTaskPanel_Generate_taskBox_timeTxt
---@field public fastBtn WarringTaskPanel_Generate_taskBox_fastBtn

---@class WarringTaskPanel_Generate_typeBox_typeNameTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class WarringTaskPanel_Generate_typeBox
---@field public gameObject UnityEngine.GameObject
---@field public typeNameTxt WarringTaskPanel_Generate_typeBox_typeNameTxt

---@class WarringTaskPanel_Generate_closeBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class WarringTaskPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public rectTransform UnityEngine.RectTransform
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public maskImg UnityEngine.GameObject
---@field public closeBtn WarringTaskPanel_Generate_closeBtn
---@field public typeBox WarringTaskPanel_Generate_typeBox
---@field public taskBox WarringTaskPanel_Generate_taskBox
local WarringTaskPanel = class("WarringTaskPanel", require("WndBase"))

function WarringTaskPanel:ctor(data)
end

---@private
function WarringTaskPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("WarringTaskPanel")

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
function WarringTaskPanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.rectTransform = Root:GetComponent(TypeInfo.RectTransform)

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function WarringTaskPanel:InitGenerate__2(Root, data)
--[[
	maskImg
--]]
	local tmp = Root:Find("maskImg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.maskImg = tmp


end

---@private
function WarringTaskPanel:InitGenerate__3(Root, data)
--[[
	PanelBg/CloseBtn
--]]
	local tmp = Root:Find("PanelBg/CloseBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.closeBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("WarringTaskPanel_closeBtn")
			if self.closeBtn_ScaleButton_onClick then
				self:closeBtn_ScaleButton_onClick(self.closeBtn)
			end
		end)


end

---@private
function WarringTaskPanel:InitGenerate__4(Root, data)
--[[
	Custom/TypeBox
--]]
	local tmp = Root:Find("Custom/TypeBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.typeBox = tmp


end

---@private
function WarringTaskPanel:InitGenerate__5(Root, data)
--[[
	Custom/TypeBox/TyppTitle/TypeNameBg/TypeNameTxt
--]]
	local tmp = Root:Find("Custom/TypeBox/TyppTitle/TypeNameBg/TypeNameTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.typeBox.typeNameTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function WarringTaskPanel:InitGenerate__6(Root, data)
--[[
	Custom/TaskBox
--]]
	local tmp = Root:Find("Custom/TaskBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.taskBox = tmp


end

---@private
function WarringTaskPanel:InitGenerate__7(Root, data)
--[[
	Custom/TaskBox/Task/TaskName
--]]
	local tmp = Root:Find("Custom/TaskBox/Task/TaskName").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.taskBox.taskName = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function WarringTaskPanel:InitGenerate__8(Root, data)
--[[
	Custom/TaskBox/Task/PosTxt
--]]
	local tmp = Root:Find("Custom/TaskBox/Task/PosTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.taskBox.posTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function WarringTaskPanel:InitGenerate__9(Root, data)
--[[
	Custom/TaskBox/Task/TimeImg/TimeTxt
--]]
	local tmp = Root:Find("Custom/TaskBox/Task/TimeImg/TimeTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.taskBox.timeTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function WarringTaskPanel:InitGenerate__10(Root, data)
--[[
	Custom/TaskBox/Task/FastBtn
--]]
	local tmp = Root:Find("Custom/TaskBox/Task/FastBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.taskBox.fastBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("WarringTaskPanel_fastBtn")
			if self.fastBtn_ScaleButton_onClick then
				self:fastBtn_ScaleButton_onClick(self.taskBox.fastBtn)
			end
		end)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function WarringTaskPanel:SetLocalizedText(Root)

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return WarringTaskPanel