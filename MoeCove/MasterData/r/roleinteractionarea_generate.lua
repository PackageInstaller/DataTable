---@class RoleInteractionArea_Generate_skipBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class RoleInteractionArea_Generate_skipMask
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class RoleInteractionArea_Generate_adjustRoot
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform

---@class RoleInteractionArea_Generate_dialogText
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public text TMPro.TextMeshProUGUI

---@class RoleInteractionArea_Generate_dialogBox
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform

---@class RoleInteractionArea_Generate_spineRoot
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform

---@class RoleInteractionArea_Generate_skinImg
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public image UnityEngine.UI.Image
---@field public button UnityEngine.UI.Button

---@class RoleInteractionArea_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public rectTransform UnityEngine.RectTransform
---@field public skinImg RoleInteractionArea_Generate_skinImg
---@field public spineRoot RoleInteractionArea_Generate_spineRoot
---@field public dialogBox RoleInteractionArea_Generate_dialogBox
---@field public dialogText RoleInteractionArea_Generate_dialogText
---@field public dialogArrow UnityEngine.GameObject
---@field public adjustRoot RoleInteractionArea_Generate_adjustRoot
---@field public skipMask RoleInteractionArea_Generate_skipMask
---@field public skipBtn RoleInteractionArea_Generate_skipBtn
local RoleInteractionArea = class("RoleInteractionArea", require("CommonBase"))

function RoleInteractionArea:ctor(data)
end

---@private
function RoleInteractionArea:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("RoleInteractionArea")

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
function RoleInteractionArea:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.rectTransform = Root:GetComponent(TypeInfo.RectTransform)


end

---@private
function RoleInteractionArea:InitGenerate__2(Root, data)
--[[
	SkinImg
--]]
	local tmp = Root:Find("SkinImg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.skinImg = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)

	tmp.image = tmp:GetComponent(TypeInfo.Image)

	tmp.button = tmp:GetComponent(TypeInfo.Button)


end

---@private
function RoleInteractionArea:InitGenerate__3(Root, data)
--[[
	SpineRoot
--]]
	local tmp = Root:Find("SpineRoot").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.spineRoot = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)


end

---@private
function RoleInteractionArea:InitGenerate__4(Root, data)
--[[
	DialogBox
--]]
	local tmp = Root:Find("DialogBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.dialogBox = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)


end

---@private
function RoleInteractionArea:InitGenerate__5(Root, data)
--[[
	DialogBox/ScrollView/Viewport/DialogText
--]]
	local tmp = Root:Find("DialogBox/ScrollView/Viewport/DialogText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.dialogText = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function RoleInteractionArea:InitGenerate__6(Root, data)
--[[
	DialogBox/DialogArrow
--]]
	local tmp = Root:Find("DialogBox/DialogArrow").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.dialogArrow = tmp


end

---@private
function RoleInteractionArea:InitGenerate__7(Root, data)
--[[
	AdjustRoot
--]]
	local tmp = Root:Find("AdjustRoot").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.adjustRoot = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)


end

---@private
function RoleInteractionArea:InitGenerate__8(Root, data)
--[[
	AdjustRoot/SkipMask
--]]
	local tmp = Root:Find("AdjustRoot/SkipMask").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.skipMask = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("RoleInteractionArea_skipMask")
			if self.skipMask_Button_onClick then
				self:skipMask_Button_onClick(self.skipMask)
			end
		end)


end

---@private
function RoleInteractionArea:InitGenerate__9(Root, data)
--[[
	AdjustRoot/SkipBtn
--]]
	local tmp = Root:Find("AdjustRoot/SkipBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.skipBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("RoleInteractionArea_skipBtn")
			if self.skipBtn_ScaleButton_onClick then
				self:skipBtn_ScaleButton_onClick(self.skipBtn)
			end
		end)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function RoleInteractionArea:SetLocalizedText(Root)

    local locObj_ShowCharacterPanel_SkipTxt = Root:Find("AdjustRoot/SkipBtn/SkipTxt")
    if locObj_ShowCharacterPanel_SkipTxt then
        locObj_ShowCharacterPanel_SkipTxt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.ShowCharacterPanel_SkipTxt
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return RoleInteractionArea