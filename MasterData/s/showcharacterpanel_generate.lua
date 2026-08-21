---@class ShowCharacterPanel_Generate_skipBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton
---@field public canvasGroup UnityEngine.CanvasGroup

---@class ShowCharacterPanel_Generate_dialogueTxt
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public text TMPro.TextMeshProUGUI

---@class ShowCharacterPanel_Generate_dialogueCanvas
---@field public gameObject UnityEngine.GameObject
---@field public canvas UnityEngine.Canvas

---@class ShowCharacterPanel_Generate_whiteRight
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class ShowCharacterPanel_Generate_whiteLeft
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class ShowCharacterPanel_Generate_dialogueBg
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class ShowCharacterPanel_Generate_isNew
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform

---@class ShowCharacterPanel_Generate_rareTypeIcon
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public image UnityEngine.UI.Image

---@class ShowCharacterPanel_Generate_roleNameTxt
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public text TMPro.TextMeshProUGUI

---@class ShowCharacterPanel_Generate_roleTypeTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class ShowCharacterPanel_Generate_roleTypeIcon
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class ShowCharacterPanel_Generate_roleTypeIconBg
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public image UnityEngine.UI.Image

---@class ShowCharacterPanel_Generate_typeAndName
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public canvasGroup UnityEngine.CanvasGroup

---@class ShowCharacterPanel_Generate_showCharacter_skinImg
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public image UnityEngine.UI.Image

---@class ShowCharacterPanel_Generate_showCharacter
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public canvasGroup UnityEngine.CanvasGroup
---@field public skinImg ShowCharacterPanel_Generate_showCharacter_skinImg
---@field public spineRoot UnityEngine.GameObject

---@class ShowCharacterPanel_Generate_roleRoot
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform

---@class ShowCharacterPanel_Generate_roleTypeTipsIcon
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class ShowCharacterPanel_Generate_roleNationIcon
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class ShowCharacterPanel_Generate_roleNationIconBg
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public image UnityEngine.UI.Image
---@field public canvasGroup UnityEngine.CanvasGroup

---@class ShowCharacterPanel_Generate_effectMask
---@field public gameObject UnityEngine.GameObject
---@field public canvasGroup UnityEngine.CanvasGroup

---@class ShowCharacterPanel_Generate_rareTypeBgMask
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class ShowCharacterPanel_Generate_roleBreakIcon
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public image UnityEngine.UI.Image

---@class ShowCharacterPanel_Generate_roleBreakRoot
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform

---@class ShowCharacterPanel_Generate_rareTypeBg
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image
---@field public button UnityEngine.UI.Button
---@field public canvasGroup UnityEngine.CanvasGroup

---@class ShowCharacterPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public animator UnityEngine.Animator
---@field public canvasGroup UnityEngine.CanvasGroup
---@field public animOverCallBack AnimOverCallBack
---@field public rareTypeBg ShowCharacterPanel_Generate_rareTypeBg
---@field public roleBreakRoot ShowCharacterPanel_Generate_roleBreakRoot
---@field public roleBreakIcon ShowCharacterPanel_Generate_roleBreakIcon
---@field public rareTypeBgMask ShowCharacterPanel_Generate_rareTypeBgMask
---@field public effectMask ShowCharacterPanel_Generate_effectMask
---@field public roleNationIconBg ShowCharacterPanel_Generate_roleNationIconBg
---@field public roleNationIcon ShowCharacterPanel_Generate_roleNationIcon
---@field public roleTypeTipsIcon ShowCharacterPanel_Generate_roleTypeTipsIcon
---@field public roleRoot ShowCharacterPanel_Generate_roleRoot
---@field public showCharacter ShowCharacterPanel_Generate_showCharacter
---@field public typeAndName ShowCharacterPanel_Generate_typeAndName
---@field public roleTypeIconBg ShowCharacterPanel_Generate_roleTypeIconBg
---@field public roleTypeIcon ShowCharacterPanel_Generate_roleTypeIcon
---@field public roleTypeTxt ShowCharacterPanel_Generate_roleTypeTxt
---@field public roleNameTxt ShowCharacterPanel_Generate_roleNameTxt
---@field public rareTypeIcon ShowCharacterPanel_Generate_rareTypeIcon
---@field public isNew ShowCharacterPanel_Generate_isNew
---@field public dialogueBg ShowCharacterPanel_Generate_dialogueBg
---@field public whiteLeft ShowCharacterPanel_Generate_whiteLeft
---@field public whiteRight ShowCharacterPanel_Generate_whiteRight
---@field public dialogueCanvas ShowCharacterPanel_Generate_dialogueCanvas
---@field public dialogueTxt ShowCharacterPanel_Generate_dialogueTxt
---@field public skipBtn ShowCharacterPanel_Generate_skipBtn
---@field public effectRoot UnityEngine.GameObject
---@field public effect_Ui_ChouKa_R UnityEngine.GameObject
---@field public effect_Ui_ChouKa_SR UnityEngine.GameObject
---@field public effect_Ui_ChouKa_SSR UnityEngine.GameObject
---@field public effect_Ui_ChouKa_SSR_2 UnityEngine.GameObject
---@field public effect_Ui_ChouKa_SR_3 UnityEngine.GameObject
---@field public effect_Ui_ChouKa_SSR_7 UnityEngine.GameObject
---@field public effectTempRoot UnityEngine.GameObject
local ShowCharacterPanel = class("ShowCharacterPanel", require("WndBase"))

function ShowCharacterPanel:ctor(data)
end

---@private
function ShowCharacterPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("ShowCharacterPanel")

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
	self:InitGenerate__16(Root,data)
	self:InitGenerate__17(Root,data)
	self:InitGenerate__18(Root,data)
	self:InitGenerate__19(Root,data)
	self:InitGenerate__20(Root,data)
	self:InitGenerate__21(Root,data)
	self:InitGenerate__22(Root,data)
	self:InitGenerate__23(Root,data)
	self:InitGenerate__24(Root,data)
	self:InitGenerate__25(Root,data)
	self:InitGenerate__26(Root,data)
	self:InitGenerate__27(Root,data)
	self:InitGenerate__28(Root,data)
	self:InitGenerate__29(Root,data)
	self:InitGenerate__30(Root,data)
	self:InitGenerate__31(Root,data)
	self:InitGenerate__32(Root,data)
	self:InitGenerate__33(Root,data)
	self:InitGenerate__34(Root,data)

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function ShowCharacterPanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.canvasGroup = Root:GetComponent(TypeInfo.CanvasGroup)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function ShowCharacterPanel:InitGenerate__2(Root, data)
--[[
	RareTypeBg
--]]
	local tmp = Root:Find("RareTypeBg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rareTypeBg = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("ShowCharacterPanel_rareTypeBg")
			if self.rareTypeBg_Button_onClick then
				self:rareTypeBg_Button_onClick(self.rareTypeBg)
			end
		end)

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function ShowCharacterPanel:InitGenerate__3(Root, data)
--[[
	RareTypeBg/RoleBreakRoot
--]]
	local tmp = Root:Find("RareTypeBg/RoleBreakRoot").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.roleBreakRoot = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)


end

---@private
function ShowCharacterPanel:InitGenerate__4(Root, data)
--[[
	RareTypeBg/RoleBreakRoot/RoleBreakIcon
--]]
	local tmp = Root:Find("RareTypeBg/RoleBreakRoot/RoleBreakIcon").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.roleBreakIcon = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function ShowCharacterPanel:InitGenerate__5(Root, data)
--[[
	RareTypeBg/RareTypeBgMask
--]]
	local tmp = Root:Find("RareTypeBg/RareTypeBgMask").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rareTypeBgMask = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function ShowCharacterPanel:InitGenerate__6(Root, data)
--[[
	RareTypeBg/EffectMask
--]]
	local tmp = Root:Find("RareTypeBg/EffectMask").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.effectMask = tmp

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function ShowCharacterPanel:InitGenerate__7(Root, data)
--[[
	RoleNationIconBg
--]]
	local tmp = Root:Find("RoleNationIconBg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.roleNationIconBg = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)

	tmp.image = tmp:GetComponent(TypeInfo.Image)

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function ShowCharacterPanel:InitGenerate__8(Root, data)
--[[
	RoleNationIconBg/RoleNationIcon
--]]
	local tmp = Root:Find("RoleNationIconBg/RoleNationIcon").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.roleNationIcon = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function ShowCharacterPanel:InitGenerate__9(Root, data)
--[[
	RoleTypeTipsIcon
--]]
	local tmp = Root:Find("RoleTypeTipsIcon").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.roleTypeTipsIcon = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function ShowCharacterPanel:InitGenerate__10(Root, data)
--[[
	RoleRoot
--]]
	local tmp = Root:Find("RoleRoot").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.roleRoot = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)


end

---@private
function ShowCharacterPanel:InitGenerate__11(Root, data)
--[[
	RoleRoot/ShowCharacter
--]]
	local tmp = Root:Find("RoleRoot/ShowCharacter").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.showCharacter = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function ShowCharacterPanel:InitGenerate__12(Root, data)
--[[
	RoleRoot/ShowCharacter/SkinImg
--]]
	local tmp = Root:Find("RoleRoot/ShowCharacter/SkinImg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.showCharacter.skinImg = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function ShowCharacterPanel:InitGenerate__13(Root, data)
--[[
	RoleRoot/ShowCharacter/SpineRoot
--]]
	local tmp = Root:Find("RoleRoot/ShowCharacter/SpineRoot").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.showCharacter.spineRoot = tmp


end

---@private
function ShowCharacterPanel:InitGenerate__14(Root, data)
--[[
	TypeAndName
--]]
	local tmp = Root:Find("TypeAndName").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.typeAndName = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function ShowCharacterPanel:InitGenerate__15(Root, data)
--[[
	TypeAndName/RoleTypeIconBg
--]]
	local tmp = Root:Find("TypeAndName/RoleTypeIconBg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.roleTypeIconBg = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function ShowCharacterPanel:InitGenerate__16(Root, data)
--[[
	TypeAndName/RoleTypeIconBg/RoleTypeIcon
--]]
	local tmp = Root:Find("TypeAndName/RoleTypeIconBg/RoleTypeIcon").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.roleTypeIcon = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function ShowCharacterPanel:InitGenerate__17(Root, data)
--[[
	TypeAndName/RoleTypeTxt
--]]
	local tmp = Root:Find("TypeAndName/RoleTypeTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.roleTypeTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function ShowCharacterPanel:InitGenerate__18(Root, data)
--[[
	TypeAndName/RoleNameBg/RoleNameTxt
--]]
	local tmp = Root:Find("TypeAndName/RoleNameBg/RoleNameTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.roleNameTxt = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function ShowCharacterPanel:InitGenerate__19(Root, data)
--[[
	TypeAndName/RareTypeIcon
--]]
	local tmp = Root:Find("TypeAndName/RareTypeIcon").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rareTypeIcon = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function ShowCharacterPanel:InitGenerate__20(Root, data)
--[[
	TypeAndName/IsNew
--]]
	local tmp = Root:Find("TypeAndName/IsNew").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.isNew = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)


end

---@private
function ShowCharacterPanel:InitGenerate__21(Root, data)
--[[
	DialogueBg
--]]
	local tmp = Root:Find("DialogueBg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.dialogueBg = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function ShowCharacterPanel:InitGenerate__22(Root, data)
--[[
	DialogueBg/WhiteLeft
--]]
	local tmp = Root:Find("DialogueBg/WhiteLeft").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.whiteLeft = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function ShowCharacterPanel:InitGenerate__23(Root, data)
--[[
	DialogueBg/WhiteRight
--]]
	local tmp = Root:Find("DialogueBg/WhiteRight").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.whiteRight = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function ShowCharacterPanel:InitGenerate__24(Root, data)
--[[
	DialogueBg/DialogueCanvas
--]]
	local tmp = Root:Find("DialogueBg/DialogueCanvas").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.dialogueCanvas = tmp

	tmp.canvas = tmp:GetComponent(TypeInfo.Canvas)


end

---@private
function ShowCharacterPanel:InitGenerate__25(Root, data)
--[[
	DialogueBg/DialogueCanvas/DialogueTxt
--]]
	local tmp = Root:Find("DialogueBg/DialogueCanvas/DialogueTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.dialogueTxt = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function ShowCharacterPanel:InitGenerate__26(Root, data)
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
		UIMgr:SendUiUseMessage("ShowCharacterPanel_skipBtn")
			if self.skipBtn_ScaleButton_onClick then
				self:skipBtn_ScaleButton_onClick(self.skipBtn)
			end
		end)

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function ShowCharacterPanel:InitGenerate__27(Root, data)
--[[
	EffectRoot
--]]
	local tmp = Root:Find("EffectRoot").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.effectRoot = tmp


end

---@private
function ShowCharacterPanel:InitGenerate__28(Root, data)
--[[
	EffectRoot/Effect_Ui_ChouKa_R
--]]
	local tmp = Root:Find("EffectRoot/Effect_Ui_ChouKa_R").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.effect_Ui_ChouKa_R = tmp


end

---@private
function ShowCharacterPanel:InitGenerate__29(Root, data)
--[[
	EffectRoot/Effect_Ui_ChouKa_SR
--]]
	local tmp = Root:Find("EffectRoot/Effect_Ui_ChouKa_SR").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.effect_Ui_ChouKa_SR = tmp


end

---@private
function ShowCharacterPanel:InitGenerate__30(Root, data)
--[[
	EffectRoot/Effect_Ui_ChouKa_SSR
--]]
	local tmp = Root:Find("EffectRoot/Effect_Ui_ChouKa_SSR").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.effect_Ui_ChouKa_SSR = tmp


end

---@private
function ShowCharacterPanel:InitGenerate__31(Root, data)
--[[
	EffectRoot/Effect_Ui_ChouKa_SSR_2
--]]
	local tmp = Root:Find("EffectRoot/Effect_Ui_ChouKa_SSR_2").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.effect_Ui_ChouKa_SSR_2 = tmp


end

---@private
function ShowCharacterPanel:InitGenerate__32(Root, data)
--[[
	EffectRoot/Effect_Ui_ChouKa_SR_3
--]]
	local tmp = Root:Find("EffectRoot/Effect_Ui_ChouKa_SR_3").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.effect_Ui_ChouKa_SR_3 = tmp


end

---@private
function ShowCharacterPanel:InitGenerate__33(Root, data)
--[[
	EffectRoot/Effect_Ui_ChouKa_SSR_7
--]]
	local tmp = Root:Find("EffectRoot/Effect_Ui_ChouKa_SSR_7").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.effect_Ui_ChouKa_SSR_7 = tmp


end

---@private
function ShowCharacterPanel:InitGenerate__34(Root, data)
--[[
	EffectTempRoot
--]]
	local tmp = Root:Find("EffectTempRoot").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.effectTempRoot = tmp


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function ShowCharacterPanel:SetLocalizedText(Root)

    local locObj_ShowCharacterPanel_SkipTxt = Root:Find("AdjustRoot/SkipBtn/SkipTxt")
    if locObj_ShowCharacterPanel_SkipTxt then
        locObj_ShowCharacterPanel_SkipTxt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.ShowCharacterPanel_SkipTxt
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return ShowCharacterPanel